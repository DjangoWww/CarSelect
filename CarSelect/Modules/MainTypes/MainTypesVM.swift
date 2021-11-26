//
//  MainTypesVM.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import RxSwift
import RxRelay
import RxCocoa
import RxDataSources
import PromiseKit

/// MainTypesVM
public final class MainTypesVM {
    deinit {
        printDebug("MainTypesVM deinit")
    }

    public typealias TableSection = SectionModel<String?, ServerMainTypesModelRes.MainTypeInfoModel>

    public enum ViewState {
        case `init`
        case loading
        case success(hasMorePages: Bool) // more pages
        case failedWith(error: Error)
    }

    private let _disposeBag = DisposeBag()
    private let _serverProvider = ServerProvider()
    private let _viewStateRelay = BehaviorRelay<ViewState>(value: .`init`)
    private let _currentPageNumberRelay = BehaviorRelay<Int>(value: .zero)
    private let _tableSectionsRelay = BehaviorRelay<[TableSection]>(value: [])
    private let _manufacturerInfoModelRelay = BehaviorRelay<ServerManufacturerModelRes.ManufacturerInfoModel?>(value: nil)

    public let viewStateDriver: Driver<ViewState>
    public let pageSizeRelay = BehaviorRelay<Int>(value: 15)
    public let tableSectionsDriver: Driver<[TableSection]>
    public let manufacturerInfoDriver: Driver<ServerManufacturerModelRes.ManufacturerInfoModel>

    public init() {
        viewStateDriver = _viewStateRelay.asDriver()
        tableSectionsDriver = _tableSectionsRelay.asDriver().skip(1)
        manufacturerInfoDriver = _manufacturerInfoModelRelay
            .asDriver()
            .compactMap { $0 }

        Observable
            .combineLatest(
                _currentPageNumberRelay,
                pageSizeRelay,
                manufacturerInfoDriver.asObservable()
            )
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .map { ServerMainTypesModelReq(page: $0, pageSize: $1, manufacturer: $2.manufacturerID) }
            .bind { [weak self] in
                self?._getManufacturer(with: $0, currentPageNumber: $0.page)
            }
            .disposed(by: _disposeBag)
    }
}

// MARK: - public funcs
extension MainTypesVM {
    /// load next page
    public func loadNextPage() {
        _currentPageNumberRelay.accept(_currentPageNumberRelay.value + 1)
    }

    /// refresh datas
    public func refreshData() {
        _viewStateRelay.accept(.loading)
        _currentPageNumberRelay.accept(.zero)
    }

    /// use this func to get the model
    public func accept(_ model: ServerManufacturerModelRes.ManufacturerInfoModel) {
        _viewStateRelay.accept(.loading)
        _manufacturerInfoModelRelay.accept(model)
    }
}

// MARK: - private funcs
extension MainTypesVM {
    private func _getManufacturer(
        with modelReq: ServerMainTypesModelReq,
        currentPageNumber: Int
    ) {
//        _viewStateRelay.accept(.loading)
        Promise<Void>(resolver: { $0.fulfill(()) })
            .map { (modelReq, currentPageNumber) }
            .then(_requestMainTypes)
            .done(_handleSucceed)
            .catch(_handleFailed)
    }

    private func _requestMainTypes(
        with modelReq: ServerMainTypesModelReq,
        currentPageNumber: Int
    ) -> Promise<(ServerMainTypesModelRes, Int)> {
        return _serverProvider
            .request(target: .getMainTypes(modelReq))
            .map { ($0, currentPageNumber) }
    }

    private func _handleSucceed(
        with resTuple: (res: ServerMainTypesModelRes, pageNumber: Int)
    ) {
        let hasMorePages = resTuple.res.totalPageCount - 1 > resTuple.pageNumber
        let resItems: [ServerMainTypesModelRes.MainTypeInfoModel]
        if resTuple.pageNumber == .zero { // should reset datas
            resItems = resTuple.res.mainTypesInfo.models
                .sorted(by: { $0.mainTypeKey < $1.mainTypeKey })
        } else { // should append datas
            resItems = ((_tableSectionsRelay.value.first?.items ?? []) + resTuple.res.mainTypesInfo.models)
                .sorted(by: { $0.mainTypeKey < $1.mainTypeKey })
        }
        _tableSectionsRelay.accept([TableSection(model: nil, items: resItems)])
        _viewStateRelay.accept(.success(hasMorePages: hasMorePages))
    }

    private func _handleFailed(with error: Error) {
        printDebug(error)
        _viewStateRelay.accept(.failedWith(error: error))
    }
}

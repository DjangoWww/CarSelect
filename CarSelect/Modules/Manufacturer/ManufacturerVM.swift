//
//  ManufacturerVM.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import RxSwift
import RxRelay
import RxCocoa
import RxDataSources
import PromiseKit

/// ManufacturerVM
public final class ManufacturerVM {
    deinit {
        printDebug("ManufacturerVM deinit")
    }

    public typealias TableSection = SectionModel<String?, ServerManufacturerModelRes.ManufacturerInfoModel>

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

    public let viewStateDriver: Driver<ViewState>
    public let pageSizeRelay = BehaviorRelay<Int>(value: 15)
    public let tableSectionsDriver: Driver<[TableSection]>

    public init() {
        viewStateDriver = _viewStateRelay.asDriver()
        tableSectionsDriver = _tableSectionsRelay.asDriver().skip(1)

        Observable
            .combineLatest(_currentPageNumberRelay.skip(1), pageSizeRelay)
            .debounce(.milliseconds(200), scheduler: MainScheduler.instance)
            .map { ServerManufacturerModelReq(page: $0, pageSize: $1) }
            .bind { [weak self] in
                self?._getManufacturer(with: $0, currentPageNumber: $0.page)
            }
            .disposed(by: _disposeBag)
    }
}

// MARK: - public funcs
extension ManufacturerVM {
    /// load next page
    public func loadNextPage() {
        _currentPageNumberRelay.accept(_currentPageNumberRelay.value + 1)
    }

    /// refresh datas
    public func refreshData() {
        _viewStateRelay.accept(.loading)
        _currentPageNumberRelay.accept(.zero)
    }
}

// MARK: - private funcs
extension ManufacturerVM {
    private func _getManufacturer(
        with modelReq: ServerManufacturerModelReq,
        currentPageNumber: Int
    ) {
//        _viewStateRelay.accept(.loading)
        Promise<Void>(resolver: { $0.fulfill(()) })
            .map { (modelReq, currentPageNumber) }
            .then(_requestManufacturer)
            .done(_handleSucceed)
            .catch(_handleFailed)
    }

    private func _requestManufacturer(
        with modelReq: ServerManufacturerModelReq,
        currentPageNumber: Int
    ) -> Promise<(ServerManufacturerModelRes, Int)> {
        return _serverProvider
            .request(target: .getManufacturer(modelReq))
            .map { ($0, currentPageNumber) }
    }

    private func _handleSucceed(
        with resTuple: (res: ServerManufacturerModelRes, pageNumber: Int)
    ) {
        let hasMorePages = resTuple.res.totalPageCount > resTuple.pageNumber
        let resItems: [ServerManufacturerModelRes.ManufacturerInfoModel]
        if resTuple.pageNumber == .zero { // should reset datas
            resItems = resTuple.res.manufacturerInfo.models
                .sorted(by: { $0.manufacturerName < $1.manufacturerName })
        } else { // should append datas
            resItems = ((_tableSectionsRelay.value.first?.items ?? []) + resTuple.res.manufacturerInfo.models)
                .sorted(by: { $0.manufacturerName < $1.manufacturerName })
        }
        _tableSectionsRelay.accept([TableSection(model: nil, items: resItems)])
        _viewStateRelay.accept(.success(hasMorePages: hasMorePages))
    }

    private func _handleFailed(with error: Error) {
        printDebug(error)
        _viewStateRelay.accept(.failedWith(error: error))
    }
}

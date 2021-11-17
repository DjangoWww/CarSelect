//
//  MainTypesVC.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import UIKit

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import RxDataSources
import PromiseKit
import MJRefresh

/// ManufacturerVC
public final class MainTypesVC: UIViewController {
    deinit {
        printDebug("MainTypesVC deinit")
    }

    @IBOutlet private weak var _pageSizeLabel: UILabel!
    @IBOutlet private weak var _slider: UISlider!
    @IBOutlet private weak var _tableView: UITableView!

    private let _viewModel = MainTypesVM()
    private let _disposeBag = DisposeBag()

    public typealias SelectBlock = (
        _ mainTypeInfoModel: ServerMainTypesModelRes.MainTypeInfoModel,
        _ manufacturerInfoModel: ServerManufacturerModelRes.ManufacturerInfoModel
    ) -> Void
    public var selectBlock: SelectBlock?
}

// MARK: - Life cycle
extension MainTypesVC {
    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "MainTypesVC"
        _setUpSubviews()
        _bindViewModel()
    }
}

// MARK: - public funcs
extension MainTypesVC {
    /// use this func to get the model
    public func accept(_ model: ServerManufacturerModelRes.ManufacturerInfoModel) {
        _viewModel.accept(model)
    }
}

// MARK: - private funcs
extension MainTypesVC {
    private func _setUpSubviews() {
        let nibId = UINib(
            nibName: ._mainTypesTableViewCell,
            bundle: Bundle.main
        )
        _tableView.register(
            nibId,
            forCellReuseIdentifier: ._mainTypesTableViewCell
        )
        _tableView.mj_header = MJRefreshNormalHeader(
            refreshingBlock: { [weak self] in self?._viewModel.refreshData() }
        )
        _tableView.mj_footer = MJRefreshAutoNormalFooter(
            refreshingBlock: { [weak self] in self?._viewModel.loadNextPage() }
        )
    }

    private func _bindViewModel() {
        _slider.rx.value
            .map { ($0 * 100).intValue }
            .bind(to: _viewModel.pageSizeRelay)
            .disposed(by: _disposeBag)

        _viewModel.pageSizeRelay.asDriver()
            .map { "pageSize: \($0)" }
            .drive(_pageSizeLabel.rx.text)
            .disposed(by: _disposeBag)

        _viewModel.pageSizeRelay
            .map { $0.floatValue / 100 }
            .bind(to: _slider.rx.value)
            .disposed(by: _disposeBag)

        _viewModel.viewStateDriver
            .drive { [weak self] in self?._handleViewState($0) }
            .disposed(by: _disposeBag)

        let dataSource = RxTableViewSectionedReloadDataSource<MainTypesVM.TableSection>.init { dataS, tableV, indexP, model in
            guard let cell = tableV.dequeueReusableCell(
                withIdentifier: ._mainTypesTableViewCell,
                for: indexP
            ) as? MainTypesTableViewCell else {
                let assertMsg = "you should register cell be4 use"
                printDebug(assertMsg, assertMessage: assertMsg)
                return UITableViewCell()
            }
            cell.model = model
            cell.isEven = indexP.row % 2 == 0
            return cell
        }

        _viewModel.tableSectionsDriver
            .drive(_tableView.rx.items(dataSource: dataSource))
            .disposed(by: _disposeBag)
        
        _tableView.rx
            .modelSelected(ServerMainTypesModelRes.MainTypeInfoModel.self)
            .asDriver()
            .withLatestFrom(_viewModel.manufacturerInfoDriver) { ($0, $1) }
            .drive { [weak self] in self?._handleSelectedWith($0, $1) }
            .disposed(by: _disposeBag)
    }

    /// handle viewState
    private func _handleViewState(
        _ viewState: MainTypesVM.ViewState
    ) {
        switch viewState {
        case .`init`:
            break
        case .loading:
            _tableView.makeActivity()
        case .success(let hasMorePages):
            _tableView.mj_header?.endRefreshing()
            if hasMorePages {
                _tableView.mj_footer?.endRefreshing()
            } else {
                _tableView.mj_footer?.endRefreshingWithNoMoreData()
            }
            _tableView.hideToast()
            view.hideToast()
        case .failedWith(let err):
            _tableView.mj_header?.endRefreshing()
            _tableView.mj_footer?.endRefreshing()
            _tableView.hideToast()
            view.hideToast()
            view.makeToast(err.errorDescription)
        }
    }

    /// handleSelected
    private func _handleSelectedWith(
        _ mainTypeInfoModel: ServerMainTypesModelRes.MainTypeInfoModel,
        _ manufacturerInfoModel: ServerManufacturerModelRes.ManufacturerInfoModel
    ) {
        navigationController?.popViewController(
            animated: true,
            finish: { [weak self] _ in self?.selectBlock?(mainTypeInfoModel, manufacturerInfoModel) }
        )
    }
}

extension String {
    fileprivate static let _mainTypesTableViewCell = "MainTypesTableViewCell"
}

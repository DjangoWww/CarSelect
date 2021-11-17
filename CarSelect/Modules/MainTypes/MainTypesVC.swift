//
//  MainTypesVC.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import UIKit

/// MainTypesVC
public final class MainTypesVC: UIViewController {
    
}

// MARK: - Life cycle
extension MainTypesVC {
    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "MainTypesVC"
        _setUpSubviews()
        _bindViewModel()
//        _viewModel.refreshData()
    }
}

// MARK: - private funcs
extension MainTypesVC {
    private func _setUpSubviews() {
//        let nibId = UINib(
//            nibName: ._manufacturerTableViewCell,
//            bundle: Bundle.main
//        )
//        _tableView.register(
//            nibId,
//            forCellReuseIdentifier: ._manufacturerTableViewCell
//        )
//        _tableView.mj_header = MJRefreshNormalHeader(
//            refreshingBlock: { [weak self] in self?._viewModel.refreshData() }
//        )
//        _tableView.mj_footer = MJRefreshAutoNormalFooter(
//            refreshingBlock: { [weak self] in self?._viewModel.loadNextPage() }
//        )
    }
    private func _bindViewModel() {
//        _slider.rx.value
//            .map { ($0 * 100).intValue }
//            .bind(to: _viewModel.pageSizeRelay)
//            .disposed(by: _disposeBag)
//
//        _viewModel.pageSizeRelay.asDriver()
//            .map { "pageSize: \($0)" }
//            .drive(_pageSizeLabel.rx.text)
//            .disposed(by: _disposeBag)
//
//        _viewModel.pageSizeRelay
//            .map { $0.floatValue / 100 }
//            .bind(to: _slider.rx.value)
//            .disposed(by: _disposeBag)
//
//        _viewModel.viewStateDriver
//            .drive { [weak self] in self?._handleViewState($0) }
//            .disposed(by: _disposeBag)
//
//        let dataSource = RxTableViewSectionedReloadDataSource<ManufacturerVM.TableSection>.init { dataS, tableV, indexP, model in
//            guard let cell = tableV.dequeueReusableCell(
//                withIdentifier: ._manufacturerTableViewCell,
//                for: indexP
//            ) as? ManufacturerTableViewCell else {
//                let assertMsg = "you should register cell be4 use"
//                printDebug(assertMsg, assertMessage: assertMsg)
//                return UITableViewCell()
//            }
//            cell.model = model
//            cell.isEven = indexP.row % 2 == 0
//            return cell
//        }
//
//        _viewModel.tableSectionsDriver
//            .drive(_tableView.rx.items(dataSource: dataSource))
//            .disposed(by: _disposeBag)
//
//        Driver
//            .zip(
//                _tableView.rx.itemSelected.asDriver(),
//                _tableView.rx.modelSelected(
//                    ServerManufacturerModelRes.ManufacturerInfoModel.self
//                ).asDriver()
//            )
//            .drive { [weak self] in self?._pushToMainTypesVC(with: $0.1) }
//            .disposed(by: _disposeBag)
    }

    /// handle viewState
    private func _handleViewState(
        _ viewState: ManufacturerVM.ViewState
    ) {
//        view.hideToast()
//        switch viewState {
//        case .`init`:
//            break
//        case .loading:
//            _tableView.makeActivity()
//        case .success(let hasMorePages):
//            _tableView.mj_header?.endRefreshing()
//            if hasMorePages {
//                _tableView.mj_footer?.endRefreshing()
//            } else {
//                _tableView.mj_footer?.endRefreshingWithNoMoreData()
//            }
//            _tableView.hideToast()
//        case .failedWith(let err):
//            _tableView.mj_header?.endRefreshing()
//            _tableView.mj_footer?.endRefreshing()
//            _tableView.hideToast()
//            _tableView.makeToast(err.errorDescription)
//        }
    }

    /// pushToMainTypesVC
    private func _pushToMainTypesVC(
        with model: ServerManufacturerModelRes.ManufacturerInfoModel
    ) {
//        let mainTypesVC = MainTypesVC()
//        navigationController?.pushViewController(mainTypesVC, animated: true)
    }
}

extension String {
    fileprivate static let _manufacturerTableViewCell = "ManufacturerTableViewCell"
}

//
//  ManufacturerVC.swift
//  CarSelect
//
//  Created by Django on 2021/11/17.
//

import UIKit
import RxSwift
import RxRelay
import RxCocoa
import RxDataSources
import PromiseKit
import MJRefresh

/// ManufacturerVC
public final class ManufacturerVC: UIViewController {
    deinit {
        printDebug("ManufacturerVC deinit")
    }

    @IBOutlet private weak var _pageSizeLabel: UILabel!
    @IBOutlet private weak var _slider: UISlider!
    @IBOutlet private weak var _tableView: UITableView!

    private let _viewModel = ManufacturerVM()
    private let _disposeBag = DisposeBag()
}

// MARK: - Life cycle
extension ManufacturerVC {
    public override func viewDidLoad() {
        super.viewDidLoad()

        title = "ManufacturerVC"
        _setUpSubviews()
        _bindViewModel()
        _viewModel.refreshData()
    }
}

// MARK: - private funcs
extension ManufacturerVC {
    private func _setUpSubviews() {
        navigationController?.navigationBar.tintColor = .blue
        navigationController?.navigationBar.setValue(true, forKey: "hidesShadow")
        let nibId = UINib(
            nibName: ._manufacturerTableViewCell,
            bundle: Bundle.main
        )
        _tableView.register(
            nibId,
            forCellReuseIdentifier: ._manufacturerTableViewCell
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

        let dataSource = RxTableViewSectionedReloadDataSource<ManufacturerVM.TableSection>.init { dataS, tableV, indexP, model in
            guard let cell = tableV.dequeueReusableCell(
                withIdentifier: ._manufacturerTableViewCell,
                for: indexP
            ) as? ManufacturerTableViewCell else {
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

        Driver
            .zip(
                _tableView.rx.itemSelected.asDriver(),
                _tableView.rx.modelSelected(
                    ServerManufacturerModelRes.ManufacturerInfoModel.self
                ).asDriver()
            )
            .drive { [weak self] in self?._pushToMainTypesVC(with: $0.1) }
            .disposed(by: _disposeBag)
    }

    /// handle viewState
    private func _handleViewState(
        _ viewState: ManufacturerVM.ViewState
    ) {
        view.hideToast()
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

    /// pushToMainTypesVC
    private func _pushToMainTypesVC(
        with model: ServerManufacturerModelRes.ManufacturerInfoModel
    ) {
        let mainTypesVC = MainTypesVC().then {
            $0.accept(model)
            $0.selectBlock = { [weak self] (mainTypeInfoModel, manufacturerInfoModel) in
                let cancleAction = AlertActionType(
                    title: "Sure",
                    style: .cancel,
                    handler: nil
                )
                self?.showAlertVcWith(
                    title: "Alert",
                    message: "You've selected <\(manufacturerInfoModel.manufacturerName)>, <\(mainTypeInfoModel.mainTypeValue)> ",
                    preferredStyle: .alert,
                    actions: [cancleAction]
                )
            }
        }
        navigationController?.pushViewController(mainTypesVC, animated: true)
    }
}

// MARK: - AlertAble extension for ManufacturerVC
extension ManufacturerVC: AlertAble { }

extension String {
    fileprivate static let _manufacturerTableViewCell = "ManufacturerTableViewCell"
}

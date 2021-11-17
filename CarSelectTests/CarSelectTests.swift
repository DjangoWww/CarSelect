//
//  CarSelectTests.swift
//  CarSelectTests
//
//  Created by Django on 2021/11/15.
//

import XCTest
@testable import CarSelect
import RxSwift
import RxCocoa
import RxRelay
import RxTest
import RxBlocking
import PromiseKit

// MARK: - extension for XCTest
// MARK: ServerManufacturerModelRes.ManufacturerInfoModel: Equatable
extension ServerManufacturerModelRes.ManufacturerInfoModel: Equatable {
    public static func == (
        lhs: ServerManufacturerModelRes.ManufacturerInfoModel,
        rhs: ServerManufacturerModelRes.ManufacturerInfoModel
    ) -> Bool {
        return lhs.manufacturerName == rhs.manufacturerName
        && lhs.manufacturerID == rhs.manufacturerID
    }
}
// MARK: ManufacturerVM.ViewState: Equatable
extension ManufacturerVM.ViewState: Equatable {
    public static func == (
        lhs: ManufacturerVM.ViewState,
        rhs: ManufacturerVM.ViewState
    ) -> Bool {
        switch (lhs, rhs) {
        case (.`init`, .`init`):
            return true
        case (.loading, .loading):
            return true
        case (.success(let hasMorePages1), .success(let hasMorePages2)):
            return hasMorePages1 == hasMorePages2
        case (.failedWith, .failedWith):
            return true
        default:
            return false
        }
    }
}

// MARK: - ManufacturerVMTests
public final class ManufacturerVMTests: XCTestCase {
    private var _disposeBag: DisposeBag!
    private var _viewModel: ManufacturerVM!
    private var _scheduler: ConcurrentDispatchQueueScheduler!
    private var _testScheduler: TestScheduler!
    
    public override func setUpWithError() throws {
        _disposeBag = DisposeBag()
        _viewModel = ManufacturerVM()
        _scheduler = ConcurrentDispatchQueueScheduler(qos: .default)
        _testScheduler = TestScheduler(initialClock: 0)
    }

    public override func tearDownWithError() throws {
        _disposeBag = nil
        _viewModel = nil
        _scheduler = nil
        _testScheduler = nil
    }

    func testInitialState() throws {
        let viewStateObs = _testScheduler.createObserver(ManufacturerVM.ViewState.self)
        let pageSizeObs = _testScheduler.createObserver(Int.self)
        let tableSectionsObs = _testScheduler.createObserver([ManufacturerVM.TableSection].self)
        
        _viewModel.viewStateDriver.drive(viewStateObs).disposed(by: _disposeBag)
        _viewModel.pageSizeRelay.bind(to: pageSizeObs).disposed(by: _disposeBag)
        _viewModel.tableSectionsDriver.drive(tableSectionsObs).disposed(by: _disposeBag)
        
        XCTAssertRecordedElements(viewStateObs.events, [.`init`])
        XCTAssertRecordedElements(pageSizeObs.events, [15])
        XCTAssertRecordedElements(tableSectionsObs.events, [])
        // This is an example of a functional test case.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testReqManufacturer() throws {
        _viewModel.refreshData()
        let viewStateObs = _testScheduler.createObserver(ManufacturerVM.ViewState.self)
        _viewModel.viewStateDriver.drive(viewStateObs).disposed(by: _disposeBag)
        let tableSectionsRes = try _viewModel.tableSectionsDriver.toBlocking().first()
        XCTAssert(tableSectionsRes != [], "error req")
        XCTAssertRecordedElements(
            viewStateObs.events,
            [.loading, .success(hasMorePages: true)]
        )
    }
}

// MARK: - ManufacturerVMTests
public final class ServerProviderTests: XCTestCase {
    private var _serverProvider: ServerProvider!

    public override func setUpWithError() throws {
        _serverProvider = ServerProvider()
    }

    public override func tearDownWithError() throws {
        _serverProvider = nil
    }

    func testReqManufacturer() throws {
        let expectation = expectation(description: "expectation for manufacturer result")
        let reqModel = ServerManufacturerModelReq(page: 0, pageSize: 15)
        let promise: Promise<ServerManufacturerModelRes> = _serverProvider
            .request(target: .getManufacturer(reqModel))
        promise
            .done { _ in expectation.fulfill() }
            .catch { XCTFail($0.errorDescription) }
        let waiter = XCTWaiter()
        waiter.wait(for: [expectation], timeout: 30)
    }
}

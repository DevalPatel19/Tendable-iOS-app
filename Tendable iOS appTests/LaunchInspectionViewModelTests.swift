//
//  LaunchInspectionViewModelTests.swift
//  Tendable iOS appTests
//
//  Created by Deval Patel on 24/07/24.
//

@testable import Tendable_iOS_app
import XCTest

final class LaunchInspectionViewModelTests: XCTestCase {

    private var viewModel: LaunchInspectionViewModel?

    override func setUpWithError() throws {
        viewModel = LaunchInspectionViewModel(apiHandler: APIHandlerMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }
    
    func testStartInspection() {
        let expectation = expectation(description: "startInspection success")
        Task {
            do {
                let result = try await viewModel?.startInspection()
                if result != nil {
                    expectation.fulfill()
                } else {
                    XCTFail("startInspection failed")
                }
            } catch {
                XCTFail("startInspection failed: \(error)")
            }
        }
        wait(for: [expectation], timeout: 1)
    }

}

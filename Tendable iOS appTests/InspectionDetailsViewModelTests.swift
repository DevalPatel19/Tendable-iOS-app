//
//  InspectionDetailsViewModelTests.swift
//  Tendable iOS appTests
//
//  Created by Deval Patel on 24/07/24.
//

@testable import Tendable_iOS_app
import XCTest

final class InspectionDetailsViewModelTests: XCTestCase {

    private var viewModel: InspectionDetailsViewModel?

    override func setUpWithError() throws {
        viewModel = InspectionDetailsViewModel(apiHandler: APIHandlerMock(), databaseHandler: DatabaseHandlerMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testSaveInspection() {
        XCTAssertTrue(((viewModel?.saveInspection(model: MockDataHandler.getData(), index: nil)) != nil))
    }
    
    func testSubmitInspection() throws {
        let expectation = expectation(description: "submitInspection success")
        Task {
            do {
                let result = try await viewModel?.submitInspection(model: MockDataHandler.getData())
                if result ?? false {
                    expectation.fulfill()
                } else {
                    XCTFail("submitInspection failed")
                }
            } catch {
                XCTFail("submitInspection failed: \(error)")
            }
        }
        wait(for: [expectation], timeout: 1)
    }

}

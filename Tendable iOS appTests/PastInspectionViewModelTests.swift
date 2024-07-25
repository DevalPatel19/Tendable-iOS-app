//
//  PastInspectionViewModelTests.swift
//  Tendable iOS appTests
//
//  Created by Deval Patel on 24/07/24.
//

@testable import Tendable_iOS_app
import XCTest

final class PastInspectionViewModelTests: XCTestCase {
    
    private var viewModel: PastInspectionViewModel?

    override func setUpWithError() throws {
        viewModel = PastInspectionViewModel(databaseHandler: DatabaseHandlerMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testLoadInspectionHistory() {
        viewModel?.loadInspectionHistory()
        XCTAssertEqual(viewModel?.pastInspections.count, 1)
    }
}

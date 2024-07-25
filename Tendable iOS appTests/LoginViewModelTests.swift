//
//  LoginViewModelTests.swift
//  Tendable iOS appTests
//
//  Created by Deval Patel on 24/07/24.
//

@testable import Tendable_iOS_app
import XCTest

final class LoginViewModelTests: XCTestCase {

    private var viewModel: LoginViewModel?

    override func setUpWithError() throws {
        viewModel = LoginViewModel(apiHandler: APIHandlerMock())
    }

    override func tearDownWithError() throws {
        viewModel = nil
    }

    func testLoginUser() {
        let expectation = expectation(description: "loginUser success")
        Task {
            do {
                let result = try await viewModel?.loginUser(email: "abc@gmail.com", password: "abc")
                if result ?? false {
                    expectation.fulfill()
                } else {
                    XCTFail("loginUser failed")
                }
            } catch {
                XCTFail("loginUser failed: \(error)")
            }
        }
        wait(for: [expectation], timeout: 1)
    }
    
    func testRegisterUser() {
        let expectation = expectation(description: "registerUser success")
        Task {
            do {
                let result = try await viewModel?.registerUser(email: "abc@gmail.com", password: "abc")
                if result ?? false {
                    expectation.fulfill()
                } else {
                    XCTFail("registerUser failed")
                }
            } catch {
                XCTFail("registerUser failed: \(error)")
            }
        }
        wait(for: [expectation], timeout: 1)
    }

}

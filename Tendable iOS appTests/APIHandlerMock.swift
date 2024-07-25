//
//  APIHandlerMock.swift
//  Tendable iOS appTests
//
//  Created by Deval Patel on 24/07/24.
//

@testable import Tendable_iOS_app
import Foundation

class APIHandlerMock: APIHandlerProtocol {
    func registerUser(model: LoginRegisterModel) async throws -> Bool {
        return true
    }
    
    func loginUser(model: LoginRegisterModel) async throws -> Bool {
        return true
    }
    
    func getInspection() async throws -> InspectionModel? {
        return MockDataHandler.getData()
    }
    
    func submitInspection(model: InspectionModel) async throws -> Bool {
        return true
    }
}

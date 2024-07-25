//
//  LoginViewModel.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 23/07/24.
//

import Foundation

class LoginViewModel: ObservableObject {
    
    private var apiHandler: APIHandlerProtocol
    
    init(apiHandler: APIHandlerProtocol = APIHandler()) {
        self.apiHandler = apiHandler
    }
    
    func loginUser(email: String, password: String) async throws -> Bool {
        let model = LoginRegisterModel(email: email, password: password)
        return try await apiHandler.loginUser(model: model)
    }
    
    func registerUser(email: String, password: String) async throws -> Bool {
        let model = LoginRegisterModel(email: email, password: password)
        return try await apiHandler.registerUser(model: model)
    }
}

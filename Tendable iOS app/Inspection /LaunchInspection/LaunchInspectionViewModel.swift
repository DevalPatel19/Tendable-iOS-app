//
//  InspectionViewModel.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 23/07/24.
//

import Foundation

class LaunchInspectionViewModel: ObservableObject {
    private var apiHandler: APIHandlerProtocol
    
    init(apiHandler: APIHandlerProtocol = APIHandler()) {
        self.apiHandler = apiHandler
    }
    
    func startInspection() async throws -> InspectionModel? {
        return try? await apiHandler.getInspection()
    }    
}

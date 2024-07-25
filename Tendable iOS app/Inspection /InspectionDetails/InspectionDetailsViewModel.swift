//
//  InspectionDetailsViewModel.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 24/07/24.
//

import Foundation

class InspectionDetailsViewModel: ObservableObject {
    
    private var apiHandler: APIHandlerProtocol
    private var databaseHandler: DatabaseHandlerProtocol
    
    init(apiHandler: APIHandlerProtocol = APIHandler(),
         databaseHandler: DatabaseHandlerProtocol = DatabaseHandler()) {
        self.apiHandler = apiHandler
        self.databaseHandler = databaseHandler
    }
    
    func submitInspection(model: InspectionModel) async throws -> Bool {
        try await apiHandler.submitInspection(model: model)
    }
    
    func saveInspection(model: InspectionModel, index: Int?) -> Bool {
        databaseHandler.saveData(model: model, index: index)
    }
}

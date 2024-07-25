//
//  PastInspectionViewModel.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 24/07/24.
//

import Foundation

class PastInspectionViewModel: ObservableObject {
    
    @Published var pastInspections = [InspectionModel]()
    
    private var databaseHandler: DatabaseHandlerProtocol

    init(databaseHandler: DatabaseHandlerProtocol = DatabaseHandler()) {
        self.databaseHandler = databaseHandler
        loadInspectionHistory()
    }
    
    func loadInspectionHistory() {
        var inspectionModelArray = [InspectionModel]()
        for data in databaseHandler.loadData() ?? [] {
            if let inspectionModel = try? JSONDecoder().decode(InspectionModel.self, from: data) {
                inspectionModelArray.append(inspectionModel)
            }
        }
        pastInspections = inspectionModelArray
    }
}

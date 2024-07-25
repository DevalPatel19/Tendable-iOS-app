//
//  DatabaseHandler.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 24/07/24.
//

import Foundation

protocol DatabaseHandlerProtocol {
    func saveData(model: InspectionModel, index: Int?) -> Bool
    func loadData() -> [Data]?
}

class DatabaseHandler: DatabaseHandlerProtocol {
    private let inspectionDataKey = "inspectionDataKey"
    
    func saveData(model: InspectionModel, index: Int?) -> Bool {
        var dataArray = [Data]()
        if let data = try? JSONEncoder().encode(model) {
            dataArray = loadData() ?? []
            if let index, index < dataArray.count {
                dataArray[index] = data
            } else {
                dataArray.append(data)
            }
            UserDefaults.standard.set(dataArray, forKey: inspectionDataKey)
            return true
        }
        return false
    }
    
    func loadData() -> [Data]? {
        UserDefaults.standard.array(forKey: inspectionDataKey) as? [Data]
    }
}

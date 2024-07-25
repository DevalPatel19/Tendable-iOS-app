//
//  DatabaseHandlerMock.swift
//  Tendable iOS appTests
//
//  Created by Deval Patel on 24/07/24.
//

@testable import Tendable_iOS_app
import Foundation

final class DatabaseHandlerMock: DatabaseHandlerProtocol {
    private var savedData: InspectionModel?
    
    func saveData(model: InspectionModel, index: Int?) -> Bool {
        savedData = model
        return true
    }
    
    func loadData() -> [Data]? {
        if let data = try? JSONEncoder().encode(MockDataHandler.getData()) {
            return [data]
        }
        return nil
    }
}

enum MockDataHandler {
    static func getData() -> InspectionModel {
        let inspectionType = InspectionType(access: "", id: 1, name: "")
        let answerChoice = AnswerChoice(id: 1, name: "", score: 0.5)
        let question = Question(id: 1, name: "", answerChoices: [answerChoice])
        let category = Category(id: 1, name: "", questions: [question])
        let survey = Survey(categories: [category], id: 1)
        let inspectionDetails = InspectionDetails(area: .init(id: 1, name: ""), id: 1, inspectionType: inspectionType, survey: survey)
        return InspectionModel(inspection: inspectionDetails)
    }
}

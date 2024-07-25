//
//  InspectionModel.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 23/07/24.
//

import Foundation

struct InspectionModel: Codable {
    let inspection: InspectionDetails
    var isCompleted: Bool?
    var savedDate: Date?
}

struct InspectionDetails: Codable {
    let area: Area
    let id: Int
    let inspectionType: InspectionType
    var survey: Survey
}

struct Area: Codable {
    let id: Int
    let name: String
}

struct InspectionType: Codable {
    let access: String
    let id: Int
    let name: String
}

struct Survey: Codable {
    let categories: [Category]
    let id: Int
}

struct Category: Codable, Identifiable {
    let id: Int
    let name: String
    var questions: [Question]
}

struct Question: Codable, Identifiable {
    let id: Int
    let name: String
    var selectedAnswerChoiceId: Int?
    let answerChoices: [AnswerChoice]
}

struct AnswerChoice: Codable, Identifiable {
    let id: Int
    let name: String
    let score: Double
}

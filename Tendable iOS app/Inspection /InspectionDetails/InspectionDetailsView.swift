//
//  InspectionDetailsView.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 24/07/24.
//

import SwiftUI

struct InspectionDetailsView: View {
    var inspectionModel: InspectionModel
    var pastInspection: (past: Bool, index: Int?, isCompleted: Bool) = (past: false, index: nil, isCompleted: false)
    
    @Environment(\.dismiss) var dismiss
    
    @Binding var refreshView: Bool
    
    @State private var selectedAnswer: [Int: Int?] = [:]
    @State private var showFinalScore = false
    @State private var finalScore: Double = .zero
    @State private var showFailedAlert = false
    @State private var showSaveSuccessAlert = false
    @State private var alertMessage = ""
    
    @StateObject private var viewModel = InspectionDetailsViewModel()
    
    var body: some View {
        VStack {
            List(inspectionModel.inspection.survey.categories) { category in
                Section(category.name) {
                    ForEach(category.questions) { question in
                        
                        Text(question.name)
                        
                        ForEach(question.answerChoices) { answerChoice in
                            HStack {
                                Text(answerChoice.name)
                                Spacer()
                                if let answerId = selectedAnswer[question.id],
                                   answerChoice.id == answerId {
                                    Image(systemName: "checkmark")
                                        .foregroundStyle(.green)
                                }
                            }
                            .contentShape(Rectangle())
                            .frame(maxWidth: .infinity)
                            .onTapGesture {
                                selectedAnswer[question.id] = answerChoice.id
                            }
                        }
                        .padding(.leading, 20)
                        
                    }
                }
            }
            
            if !pastInspection.past || (pastInspection.past && !pastInspection.isCompleted) {
                HStack {
                    Button("Save") {
                        saveInspection()
                    }
                    .padding(.trailing)
                    .font(.headline)
                    
                    Button("Submit") {
                        submitInspection()
                    }
                    .font(.headline)
                    .disabled(
                        !selectedAnswer.values.filter {
                            $0 == nil
                        }.isEmpty
                    )
                    .alert("Submitted successfully!\n final score: \(String(format: "%.2f", finalScore))", isPresented: $showFinalScore) {
                        Button("OK") {
                            dismiss()
                        }
                    }
                }
            }
        }
        .navigationTitle("Inception Details")
        .alert(alertMessage, isPresented: $showFailedAlert, actions: {
            Button("OK") {}
        })
        .alert(alertMessage, isPresented: $showSaveSuccessAlert, actions: {
            Button("OK") {
                dismiss()
            }
        })
        .onAppear {
            inspectionModel.inspection.survey.categories.forEach {
                $0.questions.forEach {
                    self.selectedAnswer[$0.id] = $0.selectedAnswerChoiceId
                }
            }
        }
    }
    
    private func saveInspection() {
        if viewModel.saveInspection(model: getInspectionModel(isSave: true),
                                    index: pastInspection.index) {
            alertMessage = "Save successful"
            showSaveSuccessAlert = true
            refreshView = true
        } else {
            showFailureAlert(saveFailed: true)
        }
    }
    
    private func submitInspection() {
        Task {
            do {
                let submitted = try await viewModel.submitInspection(model: getInspectionModel())
                if submitted {
                    let model = getInspectionModel(isSave: true, isCompleted: true)
                    if viewModel.saveInspection(model: model,
                                             index: pastInspection.index)
                    
                    {
                        model.inspection.survey.categories.forEach { category in
                            category.questions.forEach { question in
                                finalScore += question.answerChoices.first(where: {
                                    $0.id == question.selectedAnswerChoiceId
                                })?.score ?? .zero
                            }
                        }
                        
                        refreshView = true
                        showFinalScore = true
                    } else {
                        showFailureAlert()
                    }
                } else {
                    showFailureAlert()
                }
            } catch {
                showFailureAlert()
            }
        }
    }
    
    private func showFailureAlert(saveFailed: Bool = false) {
        alertMessage = saveFailed ? "Failed to save inspection" : "Failed to submit inspection"
        showFailedAlert = true
    }
    
    private func getInspectionModel(isSave: Bool = false, isCompleted: Bool = false) -> InspectionModel {
        var inspection = inspectionModel.inspection
        var categories = [Category]()
        for category in inspection.survey.categories {
            var category = category
            var questions = [Question]()
            for question in category.questions {
                var question = question
                if let selectedAnswer = selectedAnswer[question.id] {
                    question.selectedAnswerChoiceId = selectedAnswer
                }
                questions.append(question)
            }
            category.questions = questions
            categories.append(category)
        }
        inspection.survey = Survey(categories: categories, id: inspection.survey.id)
        let inspectionDetails = InspectionDetails(area: inspection.area, id: inspection.id, inspectionType: inspection.inspectionType, survey: inspection.survey)
        var model: InspectionModel
        if isSave {
            model = InspectionModel(inspection: inspectionDetails, isCompleted: isCompleted, savedDate: Date())
        } else {
            model = InspectionModel(inspection: inspectionDetails)
        }
        return model
    }
}

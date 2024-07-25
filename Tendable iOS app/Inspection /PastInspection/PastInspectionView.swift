//
//  PastInspectionView.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 24/07/24.
//

import SwiftUI

struct PastInspectionView: View {
    @StateObject private var viewModel = PastInspectionViewModel()
    @State private var refreshView: Bool = false

    var body: some View {
        if viewModel.pastInspections.isEmpty {
            Text("No past inspections")
                .font(.title)
        } else {
            List(viewModel.pastInspections.indices, id: \.self) { index in
                let isCompleted = viewModel.pastInspections[index].isCompleted ?? false
                NavigationLink {
                    InspectionDetailsView(inspectionModel: viewModel.pastInspections[index],
                                          pastInspection: (past: true,
                                                           index: index,
                                                           isCompleted: isCompleted),
                                          refreshView: $refreshView)
                } label: {
                    HStack {
                        Text("Inspection")
                        Spacer()
                        VStack(spacing: 10) {
                            Text(isCompleted ? "Completed" : "Draft")
                            if let savedDate = viewModel.pastInspections[index].savedDate {
                                Text(getFormattedDate(savedDate))
                            }
                        }
                    }
                }
            }
            .navigationTitle("Inception History")
            .onAppear {
                if refreshView {
                    viewModel.loadInspectionHistory()
                }
            }
        }
    }
    
    private func getFormattedDate(_ date: Date) -> String {
        let formatter = DateFormatter()
        formatter.dateFormat = "yyyy-MM-dd HH:mm"
        return formatter.string(from: date)
    }
}

#Preview {
    NavigationStack {
        PastInspectionView()
    }
}

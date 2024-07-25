//
//  InspectionView.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 23/07/24.
//

import SwiftUI

struct LaunchInspectionView: View {
    
    @StateObject private var viewModel = LaunchInspectionViewModel()
    @State private var inspectionModel: InspectionModel?
    @State private var showInspectionDetailsView = false
    @State private var showAlert = false
    
    var body: some View {
        VStack {
            Button("Start new Inspection") {
                Task {
                    if let model = try? await viewModel.startInspection() {
                        inspectionModel = model
                        showInspectionDetailsView = true
                    } else {
                        showAlert = true
                    }
                }
            }
            .padding(.bottom)
            .font(.headline)
            
            NavigationLink("View past Inspection") {
                PastInspectionView()
            }
            .font(.headline)
        }
        .alert("Failed to load inspection", isPresented: $showAlert, actions: {
            Button("OK") {}
        })
        .navigationTitle("Launch Inspection")
        .navigationBarBackButtonHidden()
        .navigationDestination(isPresented: $showInspectionDetailsView) {
            if let inspectionModel {
                InspectionDetailsView(inspectionModel: inspectionModel, refreshView: .constant(false))
            }
        }
    }
}

#Preview {
    NavigationStack {
        LaunchInspectionView()
    }
}

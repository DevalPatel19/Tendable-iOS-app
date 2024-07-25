//
//  ContentView.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 23/07/24.
//

import SwiftUI

struct LoginView: View {
    
    @State private var email: String = ""
    @State private var password: String = ""
    @State private var showAlert = false
    @State private var alertMessage = ""
    @State private var loginSuccess = false
    @State private var isLoading = false
    
    @StateObject private var viewModel = LoginViewModel()
    
    var body: some View {
        NavigationStack {
            VStack {
                
                Text("Login / Register")
                    .font(.largeTitle)
                    .bold()
                    .padding(.bottom, 50)
                
                TextField("Enter email", text: $email)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                SecureField("Enter password", text: $password)
                    .textFieldStyle(.roundedBorder)
                    .textInputAutocapitalization(.never)
                    .padding(.horizontal)
                    .padding(.bottom)
                
                if isLoading {
                    ProgressView()
                }
                
                HStack(spacing: 30) {
                    Button("Login") {
                        isLoading = true
                        Task {
                            do {
                                let loginSuccessful = try await viewModel.loginUser(email: email,
                                                    password: password)
                                if loginSuccessful {
                                    loginSuccess = true
                                } else {
                                    showAlert(message: "Login failed")
                                }
                            } catch APIError.userNotFound {
                                showAlert(message: "User not found")
                            } catch {
                                showAlert(message: "Login failed")
                            }
                        }
                    }
                    .disabled(disableButton())
                    .padding()
                    .font(.headline)
                    
                    Button("Register") {
                        isLoading = true
                        Task {
                            do {
                                let registerSuccessful = try await viewModel.registerUser(email: email,
                                                                                      password: password)
                                if registerSuccessful {
                                    showAlert(message: "Register Successful")
                                } else {
                                    showAlert(message: "Register failed")
                                }
                            } catch APIError.userAlreadyExists {
                                showAlert(message: "User already exists")
                            } catch {
                                showAlert(message: "Register failed")
                            }
                        }
                    }
                    .disabled(disableButton())
                    .padding()
                    .font(.headline)
                }

            }
            .alert(alertMessage, isPresented: $showAlert, actions: {
                Button("OK") {}
            })
            .navigationDestination(isPresented: $loginSuccess) {
                LaunchInspectionView()
            }
            .padding()
        }
    }
    
    private func showAlert(message: String) {
        alertMessage = message
        showAlert = true
        isLoading = false
    }
    
    private func disableButton() -> Bool {
        !(!email.trimmingCharacters(in: .whitespaces).isEmpty && !password.trimmingCharacters(in: .whitespaces).isEmpty)
    }
}

#Preview {
    LoginView()
}

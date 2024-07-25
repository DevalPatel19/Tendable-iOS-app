//
//  APIHandler.swift
//  Tendable iOS app
//
//  Created by Deval Patel on 23/07/24.
//

import Foundation
import Combine

protocol APIHandlerProtocol {
    func registerUser(model: LoginRegisterModel) async throws -> Bool
    func loginUser(model: LoginRegisterModel) async throws -> Bool
    func getInspection() async throws -> InspectionModel?
    func submitInspection(model: InspectionModel) async throws -> Bool
}

enum APIError: Error {
   case userAlreadyExists
   case userNotFound
}

class APIHandler: APIHandlerProtocol {
    
    private enum APIEndPoints: String {
        case register = "/api/register"
        case login = "/api/login"
        case startInspection = "/api/inspections/start"
        case submitInspection = "/api/inspections/submit"
    }
    
    private enum HttpMethods: String {
        case get = "GET"
        case post = "POST"
    }
    
    private let host = "http://localhost:5001"
    
    func loginUser(model: LoginRegisterModel) async throws -> Bool {
        do {
            let urlRequest = try generateUrlRequest(endPoint: .login, httpMethod: .post, model: model)
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    return true
                } else if httpResponse.statusCode == 401 {
                    throw APIError.userNotFound
                } else {
                    return false
                }
            } else {
                return false
            }
        } catch {
            throw error
        }
    }
    
    func registerUser(model: LoginRegisterModel) async throws -> Bool {
        do {
            let urlRequest = try generateUrlRequest(endPoint: .register, httpMethod: .post, model: model)
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            if let httpResponse = response as? HTTPURLResponse {
                if httpResponse.statusCode == 200 {
                    return true
                } else if httpResponse.statusCode == 401 {
                    throw APIError.userAlreadyExists
                } else {
                    return false
                }
            } else {
                return false
            }
        } catch {
            throw error
        }
    }
    
    func getInspection() async throws -> InspectionModel? {
        do {
            let urlRequest = try generateUrlRequest(endPoint: .startInspection, httpMethod: .get)
            let (data, response) = try await URLSession.shared.data(for: urlRequest)
            
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                return try JSONDecoder().decode(InspectionModel.self, from: data)
            }
            return nil
        } catch {
            throw error
        }
    }
    
    func submitInspection(model: InspectionModel) async throws -> Bool {
        do {
            let urlRequest = try generateUrlRequest(endPoint: .submitInspection, httpMethod: .post, model: model)
            let (_, response) = try await URLSession.shared.data(for: urlRequest)
            if let httpResponse = response as? HTTPURLResponse, httpResponse.statusCode == 200 {
                return true
            }
            return false
        } catch {
            throw error
        }
    }
    
    private func generateUrlRequest(endPoint: APIEndPoints, httpMethod: HttpMethods, model: Encodable? = nil) throws -> URLRequest {
        guard let url = URL(string: host + endPoint.rawValue) else {
            throw URLError(.badURL)
        }
        var urlRequest = URLRequest(url: url)
        urlRequest.httpMethod = httpMethod.rawValue
        urlRequest.setValue("application/json", forHTTPHeaderField: "Content-Type")
        if let model {
            urlRequest.httpBody = try? JSONEncoder().encode(model)
        }
        return urlRequest
    }
}

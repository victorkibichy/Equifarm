//
//  NetworkManager.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/11/24.
//

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://102.210.244.222:8082/api/v1/auth"
    
    private init() {}
    
    // Sign Up function
    func signUp(firstName: String, lastName: String, nationalID: String, email: String, phoneNumber: String, password: String, role: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/register") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1001, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let body: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "nationalId": nationalID,
            "email": email,
            "phoneNo": phoneNumber,
            "password": password,
            "role": role.uppercased(),
            "latitude": 0,  // Adjust as needed
            "longitude": 0  // Adjust as needed
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data, let httpResponse = response as? HTTPURLResponse, (200...299).contains(httpResponse.statusCode) else {
                let errorResponse = String(data: data ?? Data(), encoding: .utf8) ?? "Unknown error"
                completion(.failure(NSError(domain: errorResponse, code: 1004, userInfo: nil)))
                return
            }
            
            completion(.success("Registration successful!"))
        }
        
        task.resume()
    }
    
    /// Authenticate function



    public final func authenticate(emailOrNationalId: String, password: String, completion: @escaping (Result<String, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)/authenticate") else {
            completion(.failure(NetworkError.invalidURL))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.timeoutInterval = 30 // Optional: Set a timeout interval
        
        let body: [String: Any] = [
            "emailOrNationalId": emailOrNationalId,
            "password": password
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body, options: [])
        } catch {
            completion(.failure(error))
            return
        }
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                if let error = error {
                    completion(.failure(NetworkError.requestFailed(error.localizedDescription)))
                    return
                }
                
                guard let data = data, let httpResponse = response as? HTTPURLResponse else {
                    completion(.failure(NetworkError.unknownError))
                    return
                }
                
                switch httpResponse.statusCode {
                case 200...299:
                    do {
                        if let jsonResponse = try JSONSerialization.jsonObject(with: data, options: []) as? [String: Any] {
                            if let token = jsonResponse["token"] as? String {
                                // Save the token securely if needed
                                completion(.success(token))
                            } else {
                                completion(.success("Login successful!"))
                            }
                        } else {
                            let responseString = String(data: data, encoding: .utf8) ?? "Success"
                            completion(.success(responseString))
                        }
                    } catch {
                        completion(.failure(NetworkError.responseParsingFailed))
                    }
                case 401:
                    completion(.failure(NetworkError.serverError("Unauthorized: Invalid credentials")))
                case 500...599:
                    completion(.failure(NetworkError.serverError("Server error: Please try again later")))
                default:
                    let errorResponse = String(data: data, encoding: .utf8) ?? "Unknown error"
                    completion(.failure(NetworkError.serverError(errorResponse)))
                }
            }
        }
        
        task.resume()
    }

}

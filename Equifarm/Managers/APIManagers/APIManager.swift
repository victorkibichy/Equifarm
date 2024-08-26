import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    private let baseURL = "http://102.210.244.222:8082"
    
    private init() {}
    
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
}

import Foundation

class NetworkManager {
    static let shared = NetworkManager()
    
    private init() {}
}

extension NetworkManager {
    func signUp(firstName: String, lastName: String, nationalID: String, email: String, phoneNumber: String, password: String, role: String, completion: @escaping (Result<String, Error>) -> Void) {
        // Ensure the URL is valid
        guard let url = URL(string: "http://52.15.152.26:8082/api/v1/") else {  // Assuming the endpoint is /signup
            completion(.failure(NSError(domain: "Invalid URL", code: 1001, userInfo: nil)))
            return
        }
        
        // Create a URL request and set its method to POST
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        
        // Set request headers
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("auth/register", forHTTPHeaderField: "Authorization")
        
        // Prepare the request body with the user details
        let body: [String: Any] = [
            "firstName": firstName,
            "lastName": lastName,
            "nationalID": nationalID,
            "email": email,
            "phoneNumber": phoneNumber,
            "password": password,
            "role": role
        ]
        
        // Convert the request body to JSON data
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            completion(.failure(error))
            return
        }
        
        // Perform the network request
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            // Handle network errors
            if let error = error {
                completion(.failure(error))
                return
            }
            
            // Handle HTTP responses
            guard let httpResponse = response as? HTTPURLResponse else {
                completion(.failure(NSError(domain: "Invalid Response", code: 1002, userInfo: nil)))
                return
            }
            
            // Check for success status code
            guard (200...299).contains(httpResponse.statusCode) else {
                completion(.failure(NSError(domain: "Invalid Status Code", code: httpResponse.statusCode, userInfo: nil)))
                return
            }
            
            // Ensure data is not nil
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 1003, userInfo: nil)))
                return
            }
            
            // Handle the response data (e.g., convert it to a string for this example)
            do {
                let responseString = try JSONDecoder().decode(String.self, from: data)
                completion(.success(responseString))
            } catch {
                completion(.failure(error))
            }
        }
        
        // Start the network request
        task.resume()
    }
}

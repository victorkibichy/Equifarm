import Foundation

class APIManager: ObservableObject {
    private let baseURL = "http://102.210.244.222:8082"
    
    func fetchData(endpoint: String, completion: @escaping (Result<Data, Error>) -> Void) {
        guard let url = URL(string: "\(baseURL)\(endpoint)") else {
            completion(.failure(NSError(domain: "Invalid URL", code: 1001, userInfo: nil)))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "GET" // Adjust HTTP method (GET, POST, etc.) as needed
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            if let error = error {
                completion(.failure(error))
                return
            }
            
            guard let data = data else {
                completion(.failure(NSError(domain: "No Data", code: 1003, userInfo: nil)))
                return
            }
            
            completion(.success(data))
        }
        
        task.resume()
    }
}

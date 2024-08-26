//
//  OpenAIManager.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 8/6/24.
//

// OpenAIManager.swift
import Foundation

class OpenAIManager: ObservableObject {
    private let apiKey: String = "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"
    
    @Published var messages: [ChatMessage] = []
    @Published var isLoading: Bool = false

    func sendMessage(prompt: String) {
        guard let url = URL(string: "https://api.openai.com/v1/engines/davinci-codex/completions") else {
            self.messages.append(ChatMessage(id: UUID(), text: "Invalid URL", isUser: false))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "prompt": prompt,
            "max_tokens": 150
        ]
        
        do {
            request.httpBody = try JSONSerialization.data(withJSONObject: body)
        } catch {
            self.messages.append(ChatMessage(id: UUID(), text: "Failed to create request body", isUser: false))
            return
        }
        
        self.isLoading = true
        
        let task = URLSession.shared.dataTask(with: request) { data, response, error in
            DispatchQueue.main.async {
                self.isLoading = false
            }
            
            if let error = error {
                DispatchQueue.main.async {
                    self.messages.append(ChatMessage(id: UUID(), text: "Error: \(error.localizedDescription)", isUser: false))
                }
                return
            }
            
            guard let data = data else {
                DispatchQueue.main.async {
                    self.messages.append(ChatMessage(id: UUID(), text: "No Data", isUser: false))
                }
                return
            }
            
            do {
                let jsonResponse = try JSONSerialization.jsonObject(with: data, options: [])
                print("Response JSON: \(jsonResponse)") // Debugging line
                
                if let json = jsonResponse as? [String: Any],
                   let choices = json["choices"] as? [[String: Any]],
                   let text = choices.first?["text"] as? String {
                    DispatchQueue.main.async {
                        self.messages.append(ChatMessage(id: UUID(), text: text.trimmingCharacters(in: .whitespacesAndNewlines), isUser: false))
                    }
                } else {
                    DispatchQueue.main.async {
                        self.messages.append(ChatMessage(id: UUID(), text: "Invalid Response", isUser: false))
                    }
                }
            } catch {
                DispatchQueue.main.async {
                    self.messages.append(ChatMessage(id: UUID(), text: "Error: \(error.localizedDescription)", isUser: false))
                }
            }
        }
        
        task.resume()
    }
}



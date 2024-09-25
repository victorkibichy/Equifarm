//
//  OpenAIManager.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 8/6/24.
//

// OpenAIManager.swift

import Foundation

class OpenAIManager: ObservableObject {
    private let apiKey: String = "sk-your-api-key" // Store it securely in production
    
    @Published var messages: [ChatMessage] = []
    @Published var isLoading: Bool = false

    func sendMessage(prompt: String) {
        guard let url = URL(string: "https://api.openai.com/v1/chat/completions") else {
            self.messages.append(ChatMessage(id: UUID(), text: "Invalid URL", isUser: false))
            return
        }
        
        var request = URLRequest(url: url)
        request.httpMethod = "POST"
        request.setValue("application/json", forHTTPHeaderField: "Content-Type")
        request.setValue("Bearer \(apiKey)", forHTTPHeaderField: "Authorization")
        
        let body: [String: Any] = [
            "model": "gpt-3.5-turbo", // Use the correct model name
            "messages": [
                ["role": "system", "content": "You are a helpful assistant."], // System role
                ["role": "user", "content": prompt] // User's message
            ],
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
                   let message = choices.first?["message"] as? [String: Any],
                   let content = message["content"] as? String {
                    DispatchQueue.main.async {
                        self.messages.append(ChatMessage(id: UUID(), text: content.trimmingCharacters(in: .whitespacesAndNewlines), isUser: false))
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

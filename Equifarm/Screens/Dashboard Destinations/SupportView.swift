//
//  SupportView.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/24/24.
//

import SwiftUI

struct SupportView: View {
    @StateObject private var openAIManager = OpenAIManager()
    @State private var userInput: String = ""
    
    var body: some View {
        VStack {
            List(openAIManager.messages) { message in
                Text(message.text)
                    .frame(maxWidth: .infinity, alignment: message.isUser ? .trailing : .leading)
                    .padding()
                    .background(message.isUser ? Color.blue : Color.gray.opacity(0.2))
                    .cornerRadius(10)
            }
            
            HStack {
                TextField("Type your message", text: $userInput)
                    .textFieldStyle(RoundedBorderTextFieldStyle())
                    .padding()
                
                if openAIManager.isLoading {
                    ProgressView()
                        .padding()
                } else {
                    Button(action: sendMessage) {
                        Image(systemName: "paperplane.fill")
                            .padding()
                    }
                }
            }
        }
        .navigationTitle("Support Chatbot")
    }
    
    private func sendMessage() {
        guard !userInput.isEmpty else { return }
        openAIManager.messages.append(ChatMessage(id: UUID(), text: "You: \(userInput)", isUser: true))
        openAIManager.sendMessage(prompt: userInput)
        userInput = ""
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}

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
                HStack {
                    if message.isUser {
                        Spacer()
                        Text(message.text)
                            .padding()
                            .background(Color.blue.opacity(0.2))
                            .cornerRadius(10)
                            .frame(maxWidth: 300, alignment: .trailing)
                    } else {
                        Text(message.text)
                            .padding()
                            .background(Color.gray.opacity(0.2))
                            .cornerRadius(10)
                            .frame(maxWidth: 300, alignment: .leading)
                        Spacer()
                    }
                }
            }
            .listStyle(PlainListStyle())

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
        let userMessage = ChatMessage(id: UUID(), text: userInput, isUser: true)
        openAIManager.messages.append(userMessage)
        openAIManager.sendMessage(prompt: userInput)
        userInput = ""
    }
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}

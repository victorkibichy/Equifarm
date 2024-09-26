//
//  SupportView.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/24/24.
//

import SwiftUI
import GoogleGenerativeAI

struct SupportView: View {
    
    let model = GenerativeModel(name: "gemini-pro", apiKey: "AIzaSyCOgv6Jmw9u164msDI9VF8FuDXZ7LtSoE8")

    @State private var textInput = ""
    @State private var aiResponse = "Hello! How can I help you today ?"
    
    
    var body: some View {
        
            
            VStack {
                
                // MARK: Animating Logo
                Image("support")
                    .resizable()
                    .scaledToFit()
                    .frame(width: 200)
                
                ScrollView {
                    Text(aiResponse)
                        .font(.largeTitle)
                        .multilineTextAlignment(.center)
                    
                }
                
                HStack {
                    TextField("Enter A Mesasge To the Support Team", text: $textInput)
                        .textFieldStyle(.roundedBorder)
                        .foregroundStyle(.black)
                    
                    Button(action: sendMessage, label: {
                        Image(systemName: "paperplane.fill")
                    })
                }
                
            }
            .foregroundStyle(.black)
            .padding()
            .background {
                ZStack {
                    Color.mint
                }
                .ignoresSafeArea()
            }
               
        .navigationTitle("Support Chatbot")

    }
    
    
    //MARK: Fetch Response
    func sendMessage() {
        aiResponse = ""
        Task {
            do {
                let response = try await model.generateContent(textInput)
                guard let text = response.text else {
                    textInput = "Sorry, I couldn't Processs that. \nPlease try Again Later"
                    return
                }
                textInput = ""
                aiResponse = text
                
            } catch {
                aiResponse = "Something Went Wrong! \n\(error.localizedDescription)"
            }
        }
    }
    
}

struct SupportView_Previews: PreviewProvider {
    static var previews: some View {
        SupportView()
    }
}

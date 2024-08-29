//
//  SignUpView.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/11/24.
//

import SwiftUI

struct SignUpView: View {
    @State private var firstName: String = ""
    @State private var lastName: String = ""
    @State private var nationalID: String = ""
    @State private var email: String = ""
    @State private var phoneNumber: String = ""
    @State private var password: String = ""
    @State private var confirmPassword: String = ""
    @State private var selectedRoleIndex = 0
    @State private var message: String = ""
    @State private var showAlert = false
    let roles = ["Farmer", "Agrodealer", "Buyer", "Service Provider", "Transporter"]
    
    var body: some View {
        ScrollView {
            VStack {
                Image("splashscreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text("Sign Up")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                Group {
                    TextField("First Name", text: $firstName)
                    TextField("Last Name", text: $lastName)
                    TextField("National ID", text: $nationalID)
                    TextField("Email", text: $email)
                    TextField("Phone Number", text: $phoneNumber)
                        .keyboardType(.phonePad)
                    SecureField("Password", text: $password)
                    SecureField("Confirm Password", text: $confirmPassword)
                }
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
                
                HStack {
                    ScrollView {
                        Picker("Select Role", selection: $selectedRoleIndex) {
                            ForEach(0..<roles.count) { index in
                                Text(roles[index]).tag(index)
                            }
                        }
                    }
                }
                .pickerStyle(.inline)
                .padding()
                
                Button(action: signUp) {
                    Text("Sign Up")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                
                Text(message)
                    .foregroundColor(.red)
                    .padding()
                
                Spacer()
            }
            .padding()
        }
        .alert(isPresented: $showAlert) {
            Alert(title: Text("Sign Up Result"), message: Text(message), dismissButton: .default(Text("OK")))
        }
    }
    
    private func signUp() {
        guard password == confirmPassword else {
            message = "Passwords do not match."
            showAlert = true
            return
        }
        
        NetworkManager.shared.signUp(
            firstName: firstName,
            lastName: lastName,
            nationalID: nationalID,
            email: email,
            phoneNumber: phoneNumber,
            password: password,
            role: roles[selectedRoleIndex]
        ) { result in
            DispatchQueue.main.async {
                switch result {
                case .success(let response):
                    message = response
                case .failure(let error):
                    message = "Sign Up failed: \(error.localizedDescription)"
                }
                showAlert = true
            }
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

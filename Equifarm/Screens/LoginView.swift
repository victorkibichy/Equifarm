//
//  LoginView.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/11/24.
//

import SwiftUI

struct LoginView: View {
    @State private var username: String = ""
    @State private var password: String = ""
    @State private var isSignUpViewPresented = false
    @State private var isResetPasswordPagePresented = false // State to control the presentation of the ResetPasswordPage
    @State private var isDashboardScreenPresented = false // State to control the presentation of the DashboardScreen
    @State private var loginErrorMessage: String? = nil // State to show login error messages

    var body: some View {
        TabView {
            VStack {
                Image("splashscreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .padding()
                
                Text("Login")
                    .font(.title)
                    .fontWeight(.bold)
                    .foregroundColor(.blue)
                
                TextField("Username", text: $username)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                SecureField("Password", text: $password)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                if let errorMessage = loginErrorMessage {
                    Text(errorMessage)
                        .foregroundColor(.red)
                        .padding()
                }
                
                Button(action: {
                    // Call the authenticate function
                    NetworkManager.shared.authenticate(emailOrNationalId: username, password: password) { result in
                        DispatchQueue.main.async {
                            switch result {
                            case .success(let message):
                                print(message) // Handle success message
                                isDashboardScreenPresented = true
                                
                            case .failure(let error):
                                loginErrorMessage = "Login failed: \(error.localizedDescription)"
                                // Keep isDashboardScreenPresented as false to deny access
                            }
                        }
                    }
                }) {
                    Text("Login")
                        .font(.headline)
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.bottom, 16) // Add some bottom padding to the button
                
                Button(action: {
                    // Open the sign-up view
                    isSignUpViewPresented = true
                }) {
                    Text("Don't have a profile? Sign Up")
                        .foregroundColor(.blue)
                        .padding(.top, 8)
                }
                .sheet(isPresented: $isSignUpViewPresented) {
                    SignUpView()
                }
                
                Button(action: {
                    // Navigate to the ResetPasswordPage
                    isResetPasswordPagePresented = true
                }) {
                    Text("Forgot Password?")
                        .foregroundColor(.blue)
                        .padding(.top, 8)
                }
                .sheet(isPresented: $isResetPasswordPagePresented) {
                    ResetPasswordPage()
                }
                
                Spacer()
            }
            .padding()
            .navigationBarHidden(true) // Hide the navigation bar
            .navigationBarTitle("", displayMode: .inline) // Set the navigation title to empty
            .navigationBarBackButtonHidden(true) // Hide the back button
            .navigationBarTitleDisplayMode(.inline) // Set the navigation title display mode
            .background(Color.white.edgesIgnoringSafeArea(.all)) // Set the background color
            .fullScreenCover(isPresented: $isDashboardScreenPresented) {
                DashboardView()
            }
        }
    }
}

struct LoginView_Previews: PreviewProvider {
    static var previews: some View {
        LoginView()
    }
}

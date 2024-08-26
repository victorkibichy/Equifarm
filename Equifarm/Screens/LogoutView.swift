//
//  LogoutView.swift
//  Forex Calc Swift UI
//
//  Created by  Bouncy Baby on 6/7/24.
//

import Foundation
import SwiftUI

struct LogoutView: View {
    @State private var logoutMessage: String = ""
    @State private var isLoggedOut: Bool = false
    
    var body: some View {
        VStack {
            Image("splashscreen")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            // This NavigationLink will navigate to the LoginView if isLoggedOut becomes true
            NavigationLink(destination: LoginView(), isActive: $isLoggedOut) {
                EmptyView()
            }
            
            Button(action: {
                // Handle logout action
                print("Logout button tapped")
                
                // Perform any necessary cleanup, such as clearing user data
                logoutUser()
                
                // Update the logout message
                logoutMessage = "You have been logged out."
                
                // Set isLoggedOut to true to trigger navigation to the login view
                isLoggedOut = true
            }) {
                Text("Logout")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
            .padding()
            
            Text(logoutMessage)
                .foregroundColor(.blue)
                .padding()
        }
    }
    
    func logoutUser() {
        // Perform any necessary logout operations, such as clearing user data
        // Example: Resetting user defaults or clearing app state
        UserDefaults.standard.removeObject(forKey: "isLoggedIn")
        UserDefaults.standard.synchronize()
        
        // Additional cleanup can be done here
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}

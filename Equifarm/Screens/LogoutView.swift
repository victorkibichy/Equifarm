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
            
            NavigationLink(destination: LoginView(), isActive: $isLoggedOut) {
                EmptyView()
            }
            
            Button(action: {
                // Handle logout action
                // Here you can implement the logout functionality
                print("Logout button tapped")
                
                // Update the logout message
                logoutMessage = "Logout successful"
                
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
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}

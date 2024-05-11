import SwiftUI

struct ResetPasswordPage: View {
    @State private var email: String = ""
    @State private var isEmailSent = false // State to track if email is sent
    
    var body: some View {
        VStack {
            
            Image("splashscreen")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            
            Text("Reset Password")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            if !isEmailSent {
                // If email is not sent, show the email input form
                TextField("Email", text: $email)
                    .padding()
                    .background(Color.gray.opacity(0.2))
                    .cornerRadius(8)
                    .padding(.horizontal)
                
                Button(action: {
                    // Simulate sending email (for demonstration purposes)
                    // Here you would implement the actual logic to send the password reset email
                    print("Email sent to: \(email)")
                    isEmailSent = true
                }) {
                    Text("Send Email")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.top, 16)
            } else {
                // If email is sent, show the confirmation message
                Text("Password reset email sent to \(email)")
                    .padding()
                    .multilineTextAlignment(.center)
                
                Button(action: {
                    // Reset the email and switch back to the email input form
                    email = ""
                    isEmailSent = false
                }) {
                    Text("Reset")
                        .foregroundColor(.white)
                        .padding()
                        .frame(maxWidth: .infinity)
                        .background(Color.blue)
                        .cornerRadius(8)
                        .padding(.horizontal)
                }
                .padding(.top, 16)
            }
            
            Spacer()
        }
        .padding()
        .navigationTitle("Reset Password") // Set the navigation title
    }
}

struct ResetPasswordPage_Previews: PreviewProvider {
    static var previews: some View {
        ResetPasswordPage()
    }
}

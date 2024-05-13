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
    let roles = ["Farmer", "Agrodealer", "Buyer", "Service Provider", "Transporter"]
    
    var body: some View {
        VStack {
            Text("Sign Up")
                .font(.title)
                .fontWeight(.bold)
                .foregroundColor(.blue)
            
            TextField("First Name", text: $firstName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Last Name", text: $lastName)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("National ID", text: $nationalID)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Email", text: $email)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            TextField("Phone Number", text: $phoneNumber)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
                .keyboardType(.phonePad) // Set keyboard type to phone pad
            
            SecureField("Password", text: $password)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            SecureField("Confirm Password", text: $confirmPassword)
                .padding()
                .background(Color.gray.opacity(0.2))
                .cornerRadius(8)
                .padding(.horizontal)
            
            Picker(selection: $selectedRoleIndex, label: Text("Select Role")) {
                ForEach(0..<roles.count) { index in
                    Text(roles[index]).tag(index)
                }
            }
            .pickerStyle(SegmentedPickerStyle())
            .padding()
            
            Button(action: {
                // Handle sign up button action
                // Here you can perform validation and send email confirmation
                
                // Example: Send email confirmation to the user's mailbox
                print("Sign Up button tapped")
                print("First Name: \(firstName)")
                print("Last Name: \(lastName)")
                print("National ID: \(nationalID)")
                print("Email: \(email)")
                print("Phone Number: \(phoneNumber)")
                print("Password: \(password)")
                print("Confirm Password: \(confirmPassword)")
                print("Selected Role: \(roles[selectedRoleIndex])")
            }) {
                Text("Sign Up")
                    .font(.headline)
                    .foregroundColor(.white)
                    .padding()
                    .frame(maxWidth: .infinity)
                    .background(Color.blue)
                    .cornerRadius(8)
                    .padding(.horizontal)
            }
        }
        .padding()
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

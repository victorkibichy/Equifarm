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
        ScrollView {
            VStack {
                // Image at the top
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
                
                Picker("Select Role", selection: $selectedRoleIndex) {
                    ForEach(0..<roles.count) { index in
                        Text(roles[index]).tag(index)
                    }
                }
                .pickerStyle(SegmentedPickerStyle())
                .padding()
                
                Button(action: {
                    NetworkManager.shared.signUp(firstName: firstName, lastName: lastName, nationalID: nationalID, email: email, phoneNumber: phoneNumber, password: password, role: roles[selectedRoleIndex]) { result in
                        switch result {
                        case .success(let response):
                            print("Sign Up successful: \(response)")
                            // Handle successful sign-up (e.g., navigate to a different view)
                        case .failure(let error):
                            print("Sign Up failed: \(error.localizedDescription)")
                            // Handle error (e.g., show an alert)
                        }
                    }
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
                
                Text("Please select Role") // Text view below Confirm Password field
                    .foregroundColor(.red) // Change color to red or any desired color
                    .padding(.top, 8) // Add some top padding
                
                Spacer() // Pushes everything up
            }
            .padding()
        }
    }
}

struct SignUpView_Previews: PreviewProvider {
    static var previews: some View {
        SignUpView()
    }
}

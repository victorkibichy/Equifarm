import SwiftUI

struct AutoOpenPage: View {
    @State private var isLoginViewPresented = false
    @State private var isSignUpViewPresented = false
    
    var body: some View {
        VStack {
            Spacer()
            
            Text("This page opens automatically after 2.5 seconds.")
                .font(.subheadline)
                .foregroundColor(.blue)
            
            Button(action: {
                // Open the login view
                isLoginViewPresented = true
            }) {
                Image("splashscreen2")
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .frame(maxWidth: .infinity, maxHeight: .infinity)
                    .edgesIgnoringSafeArea(.all)
            }
            .padding()
            
            Spacer()
            
            Button(action: {
                // Open the sign-up view
                isSignUpViewPresented = true
            }) {
                Text("Don't have a profile? Sign Up")
                    .foregroundColor(.blue)
            }
            .padding()
            .sheet(isPresented: $isSignUpViewPresented) {
                SignUpView()
            }
        }
    }
}

struct AutoOpenPage_Previews: PreviewProvider {
    static var previews: some View {
        AutoOpenPage()
    }
}

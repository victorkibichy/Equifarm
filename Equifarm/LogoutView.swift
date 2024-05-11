import SwiftUI

struct LogoutView: View {
    var body: some View {
        VStack {
            Image("splashscreen")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding()
            
            Button(action: {
                // Handle logout action
                // Here you can implement the logout functionality
                print("Logout button tapped")
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
        }
    }
}

struct LogoutView_Previews: PreviewProvider {
    static var previews: some View {
        LogoutView()
    }
}

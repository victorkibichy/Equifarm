import SwiftUI

struct AutoOpenPage: View {
    @State private var isLoginViewPresented = false
    @State private var isImageVisible = true
    
    var body: some View {
        VStack {
          
            
            if isImageVisible {
                Image("splashscreen")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    
                    .onAppear {
                        // Hide the image after two seconds
                        Timer.scheduledTimer(withTimeInterval: 2, repeats: false) { _ in
                            isImageVisible = false
                            isLoginViewPresented = true
                        }
                    }
            } else {
                EmptyView()
            }
            
           
            
            Button(action: {
                // Open the sign-up view
                isLoginViewPresented = true
            }) {
               
            }
            .padding()
            .sheet(isPresented: $isLoginViewPresented) {
                LoginView()
            }
        }
    }
}

struct AutoOpenPage_Previews: PreviewProvider {
    static var previews: some View {
        AutoOpenPage()
    }
}

//
//  ContentView.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/11/24.
//
import SwiftUI

struct ContentView: View {
    @State private var isActiveAutoOpenPage = false
    
    var body: some View {
        VStack {
          
            
            Text("Welcome To Equifarm")
                .font(.title)
                .fontWeight(.semibold)
                .foregroundColor(Color(hue: 1.0, saturation: 0.899, brightness: 0.685))
                .multilineTextAlignment(.center)
                .padding(.top, 10)
            
            Spacer()


            Image("splashscreen")
                .resizable()
                .cornerRadius(20)
                .aspectRatio(contentMode: .fit)
            
          Spacer()
        }
        .onAppear {
            // Start a timer to navigate to AutoOpenPage after 2.5 seconds
            DispatchQueue.main.asyncAfter(deadline: .now() + 2.5) {
                isActiveAutoOpenPage = true
            }
        }
        .fullScreenCover(isPresented: $isActiveAutoOpenPage) {
            AutoOpenPage()
        }
    }
}

struct ContentView_Previews: PreviewProvider {
    static var previews: some View {
        ContentView()
    }
}

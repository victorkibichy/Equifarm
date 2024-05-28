//
//  FarmTechView.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/24/24.
//

import Foundation
import SwiftUI

struct ProduceView: View {
    var body: some View {
        NavigationView {
            VStack {
                // Tabs
                HStack {
                    Button(action: {
                        // Action for Machineries tab
                    }) {
                        Text("Upload Produce")
                            .padding()
                            .background(Color.blue)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                   
                    Spacer()
                   
                    Button(action: {
                        // Action for Tools tab
                    }) {
                        Text("Manage Produce")
                            .padding()
                            .background(Color.pink)
                            .foregroundColor(.white)
                            .cornerRadius(8)
                    }
                }
                .padding(.horizontal)
               
                // Grid of items
                ScrollView {
                    LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                        ForEach(0..<6) { index in
                           ProducesView()
                        }
                    }
                    .padding()
                }
            }
            .navigationTitle("My Produce")
            .background(Color.mint)
        }
        
    }
}

struct ProducesView: View {
    var body: some View {
        VStack {
            Image(systemName: "photo") // Placeholder for tractor image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .clipped()
                Spacer()
           
            Text("Eggs Tray")
                .font(.headline)
           
            Text("Seller: four farmers ltd")
                .font(.subheadline)
                .foregroundColor(.gray)
           
            Text("Price: sh 1000")
                .font(.subheadline)
                .foregroundColor(.gray)
           
            Text("Availability: In Stock")
                .font(.subheadline)
                .foregroundColor(.gray)
           
            HStack {
                Button(action: {
                    // Action for add to cart
                }) {
                    Image(systemName: "cart")
                        .foregroundColor(.black)
                }
               
                Spacer()
               
                Button(action: {
                    // Action for favorite
                }) {
                    Image(systemName: "heart")
                        .foregroundColor(.black)
                }
            }
            .padding(.horizontal)
            .padding(.bottom, 8)
        }
        .background(Color.white)
        .cornerRadius(8)
        .shadow(radius: 4)
    }
}

struct ProduceView_Previews: PreviewProvider {
    static var previews: some View {
        ProduceView()
    }
}

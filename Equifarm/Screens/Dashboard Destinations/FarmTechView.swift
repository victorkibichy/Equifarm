//
//  FarmTechView.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/24/24.
//

import Foundation
import SwiftUI

struct FarmTechView: View {
    var body: some View {
                    ScrollView {
                VStack {
                    HStack {
                        Button(action: {
                            // Action for Upload tab
                        }) {
                            Text("Machineries")
                                .padding()
                                .background(Color.blue)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                        
                        Spacer()
                        
                        Button(action: {
                            // Action for Tools tab
                        }) {
                            Text("Tools")
                                .padding()
                                .background(Color.pink)
                                .foregroundColor(.white)
                                .cornerRadius(8)
                        }
                    }
                    .padding(.horizontal)
                                     
                        LazyVGrid(columns: [GridItem(.flexible()), GridItem(.flexible())], spacing: 20) {
                            ForEach(0..<6) { index in
                                SellItemView()
                            }
                        }
                        .padding()
                                    }
            }
            .navigationTitle("Farm Tech")
            .background(Color.mint)
        }
        
    }

struct SellItemView: View {
    var body: some View {
        VStack {
            Image(systemName: "photo") // Placeholder for tractor image
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 150)
                .clipped()
                Spacer()
           
            Text("Tractor")
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

struct FarmTechView_Previews: PreviewProvider {
    static var previews: some View {
        NavigationView { FarmTechView()}
    }
}

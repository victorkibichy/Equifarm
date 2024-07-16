//
//  TrainingView.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/24/24.
//

import Foundation
import SwiftUI

struct TrainingView: View {
    let trainingTopics = [
        "Soil Preparation",
        "Planting Techniques",
        "Pest Management",
        "Irrigation Systems",
        "Harvesting Methods",
        "Post-Harvest Handling",
        "Crop Rotation",
        "Organic Farming",
        "Agricultural Technology"
    ]
    
    var body: some View {
        NavigationView {
            List(trainingTopics, id: \.self) { topic in
                NavigationLink(destination: TrainingDetailView(topic: topic)) {
                    Text(topic)
                        .padding()
                }
            }
            .navigationTitle("Training")
        }
    }
}

struct TrainingDetailView: View {
    var topic: String
    
    var body: some View {
        VStack {
            Text(topic)
                .font(.largeTitle)
                .padding()
            
            Text("Details and resources about \(topic) will be displayed here.")
                .padding()
            
            Spacer()
        }
        .navigationTitle(topic)
    }
}

struct TrainingView_Previews: PreviewProvider {
    static var previews: some View {
        TrainingView()
    }
}

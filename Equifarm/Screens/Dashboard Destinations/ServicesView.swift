//
//  ServicesView.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/24/24.
//

import Foundation
import SwiftUI

struct ServicesView: View {
    let services = [
        Service(name: "Soil Testing", imageName: "soiltest"),
        Service(name: "Irrigation Systems", imageName: "irrigation"),
        Service(name: "Pest Control", imageName: "pestcontrol"),
        Service(name: "Fertilizer Supply", imageName: "fertilizer"),
        Service(name: "Machinery Rental", imageName: "machinery"),
        Service(name: "Crop Insurance", imageName: "insurance")
    ]
    
    var body: some View {
        NavigationView {
            List(services) { service in
                NavigationLink(destination: ServiceDetailView(service: service)) {
                    HStack {
                        Image(service.imageName)
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .frame(width: 50, height: 50)
                            .padding(5)
                        
                        Text(service.name)
                            .font(.headline)
                            .padding(.leading, 10)
                    }
                    .padding()
                }
            }
            .navigationTitle("Agricultural Services")
        }
    }
}

struct Service: Identifiable {
    let id = UUID()
    let name: String
    let imageName: String
}

struct ServiceDetailView: View {
    let service: Service
    
    var body: some View {
        VStack {
            Image(service.imageName)
                .resizable()
                .aspectRatio(contentMode: .fit)
                .frame(height: 200)
                .padding()
            
            Text(service.name)
                .font(.largeTitle)
                .padding()
            
            Text("Detailed information about \(service.name). Here you can provide more details about the service, how to avail it, contact information, etc.")
                .padding()
            
            Spacer()
        }
        .navigationTitle(service.name)
    }
}

struct ServicesView_Previews: PreviewProvider {
    static var previews: some View {
        ServicesView()
    }
}




//
//  FarmerViewModel.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/29/24.
//

import Foundation

class FarmerViewModel: ObservableObject {
    private struct Retuned: Codable {
        var count: Int
        var next: String
    }
    var urlString = "http://52.15.152.26:8082/api/v1/"
    func getData() async {
        print("🕸️ We are accessing the URL\(urlString)")
        // create a URL
        
        guard let url = URL(string: urlString) else {
            print("😡Error could nor create a URL from the\(urlString)")
            
            
            return
        }
        
        do {
            let (data, response) = try await URLSession.shared.data(from: url)
            
            guard let returned = try? JSONDecoder().decode(Retuned.self, from: data) else {
                print("😡 Error: Could not get data from \(urlString)")
                
                return
            }
            
            print("😎 JSON rewurned! count: \(returned.count), next: \(returned.next)")
            
        }
        
        catch {
            print("😡 Error: Could not get data from \(urlString)")
            
            
        }
    }
    
    
}

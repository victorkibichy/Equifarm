//
//  MyFarm.swift
//  Equifarm
//
//  Created by  Bouncy Baby on 5/24/24.
//

import SwiftUI
import MapKit
import CoreLocation


struct MyFarmView: View {
    @StateObject private var locationManager = LocationManager()

    var body: some View {
        VStack {
            if let coordinate = locationManager.location?.coordinate {
                MapView(coordinate: coordinate)
                    .edgesIgnoringSafeArea(.all)
            } else {
                Text("Locating...")
                    .font(.largeTitle)
                    .foregroundColor(.gray)
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
    }
}
struct MapView: UIViewRepresentable {
    var coordinate: CLLocationCoordinate2D

    func makeUIView(context: Context) -> MKMapView {
        MKMapView()
    }

    func updateUIView(_ uiView: MKMapView, context: Context) {
        let region = MKCoordinateRegion(
            center: coordinate,
            span: MKCoordinateSpan(latitudeDelta: 0.05, longitudeDelta: 0.05)
        )
        uiView.setRegion(region, animated: true)
        uiView.showsUserLocation = true
    }
}
class LocationManager: NSObject, ObservableObject, CLLocationManagerDelegate {
    private let locationManager = CLLocationManager()

    @Published var location: CLLocation?

    override init() {
        super.init()
        locationManager.delegate = self
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestWhenInUseAuthorization()
    }

    func requestLocation() {
        locationManager.requestLocation()
    }

    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.first {
            self.location = location
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print("Failed to find user's location: \(error.localizedDescription)")
    }
}

struct MyFarmView_Previews: PreviewProvider {
    static var previews: some View {
        MyFarmView()
    }
}

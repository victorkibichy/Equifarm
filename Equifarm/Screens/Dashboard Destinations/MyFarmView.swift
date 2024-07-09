import SwiftUI
import MapKit

struct MyFarmView: View {
    @StateObject private var locationManager = LocationManager()
    @State private var showFarmText = true
    var body: some View {
        ZStack {
            MapView(userLocation: $locationManager.location)
                .edgesIgnoringSafeArea(.all)
            
            VStack {
                Spacer()
                if showFarmText {
                    Text("Your Farm Location")
                        .font(.title)
                        .fontWeight(.bold)
                        .foregroundColor(.red)
                        .padding()
                        .onAppear {
                            DispatchQueue.main.asyncAfter(deadline: .now() + 3) {
                                withAnimation {
                                    showFarmText = false
                                }
                            }
                        }
                }
                Spacer()
            }
        }
        .onAppear {
            locationManager.requestLocation()
        }
    }
}

struct MapView: UIViewRepresentable {
    @Binding var userLocation: CLLocation?

    func makeUIView(context: Context) -> MKMapView {
        let mapView = MKMapView()
        mapView.showsUserLocation = true
        return mapView
    }

    func updateUIView(_ mapView: MKMapView, context: Context) {
        if let location = userLocation {
            let coordinate = location.coordinate
            let region = MKCoordinateRegion(center: coordinate, latitudinalMeters: 1000, longitudinalMeters: 1000)
            mapView.setRegion(region, animated: true)
        }
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
        NavigationView { MyFarmView()}
    }
}


import CoreLocation
import MapKit
import SwiftUI

final class LocationManager: NSObject, ObservableObject {
    @Published var location: CLLocation?
    @Published var region = MKCoordinateRegion(
        center: CLLocationCoordinate2D(latitude: 38.898150, longitude: -77.034340),
        span: MKCoordinateSpan(latitudeDelta: 0.2, longitudeDelta: 0.2)
    )
    private var hasSetRegion = false

    private let locationManager = CLLocationManager()

    override init() {
        super.init()

        locationManager.delegate = self

        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.distanceFilter = kCLDistanceFilterNone
        locationManager.requestWhenInUseAuthorization()
        locationManager.startUpdatingLocation()
    }
}

extension LocationManager: CLLocationManagerDelegate {
    func locationManager(_: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            self.location = location

            if !hasSetRegion {
                region = MKCoordinateRegion(center: location.coordinate,
                                            span: MKCoordinateSpan(latitudeDelta: 0.09, longitudeDelta: 0.09))

                hasSetRegion = true
            }
        }
    }
}

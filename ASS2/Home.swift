import UIKit
import CoreLocation
import MapKit

class Home: NSObject, MKAnnotation  {
    var title: String?
    var coordinate: CLLocationCoordinate2D
    init (latitude: Double, longitude: Double) {
        self.coordinate = CLLocationCoordinate2D()
        self.coordinate.latitude = latitude
        self.coordinate.longitude = longitude
    }
}

import CoreLocation
import MapKit
// MARK: - ...  Navigation protocol for navigate to place on maps
protocol Navigation: AnyObject {
    func openMapForLocation(delegate: UIViewController?, location: CLLocationCoordinate2D)
}
// MARK: - ...  Navigation implementation for navigate to place on maps
extension Navigation {
    func openMapForLocation(delegate: UIViewController?, location: CLLocationCoordinate2D) {
        var instance = NavigateMap()
        instance.lat = location.latitude
        instance.lng = location.longitude
        instance.openMapForPlace(delegate: delegate)
    }
}
// MARK: - ...  Navigation Struct for navigate to place on maps
struct NavigateMap {
    var lat: Double?
    var lng: Double?
    var title: String?
    func openMapForPlace(delegate: UIViewController? = nil) {
        let installedNavigationApps : [String] = ["Apple Maps","Google Maps", "Cancel"] // Apple Maps is always installed
        let alert = UIAlertController(title: "Alert".localized, message: "Select Navigation App".localized, preferredStyle: .actionSheet)
        for app in installedNavigationApps {
            let button = UIAlertAction(title: app, style: .default) { (action) in
                if action.title == "Apple Maps".localized {
                    self.openAppleMap()
                } else if action.title == "Google Maps".localized {
                    self.openGoogleMap()
                }
            }
            alert.addAction(button)
        }
        delegate?.present(alert, animated: true, completion: nil)
    }
    func openAppleMap() {
        let latitude: CLLocationDegrees = lat ?? 0
        let longitude: CLLocationDegrees = lng ?? 0
        let coordinate = CLLocationCoordinate2DMake(latitude, longitude)
        let mapItem = MKMapItem(placemark: MKPlacemark(coordinate: coordinate, addressDictionary:nil))
        mapItem.name = title
        mapItem.openInMaps(launchOptions: [MKLaunchOptionsDirectionsModeKey : MKLaunchOptionsDirectionsModeDriving])
    }
    func openGoogleMap() {
        let (lat, lng, _) = (self.lat ?? 0, self.lng ?? 0, self.title ?? "")
        if (UIApplication.shared.canOpenURL(URL(string:"comgooglemaps://")!)) {
            UIApplication.shared.open(URL(string:
                "comgooglemaps://?saddr=&daddr=\(lat),\(lng)&directionsmode=driving")!)
        } else {
            NSLog("Can't use comgooglemaps://")
        }
    }
}

//
//  GoogleMapView.swift
//  GoogleMaps_tutorial
//
//  Created by Gihyun Kim on 2020/04/08.
//  Copyright © 2020 wimes. All rights reserved.
//


import SwiftUI
import UIKit
import GoogleMaps
import GooglePlaces
import CoreLocation
import Combine

//UIViewRepresentableController: UIViewController를 SwiftUI로 연결
//UIViewRepresentable: UIKit을 SwiftUI로 연결

//ref: https://stackoverflow.com/questions/58350211/how-to-wrap-swiftui-view-into-uiviewcontrollerrepresentable-so-that-google-maps
class GoogleMapController: UIViewController, CLLocationManagerDelegate{
    var locationManager = CLLocationManager()
    var mapView: GMSMapView!
    let defaultLocation = CLLocation(latitude: 42.361145, longitude: -71.057083)
    var zoomLevel: Float = 6.0
    let marker: GMSMarker = GMSMarker()

    override func viewDidLoad() {
        super.viewDidLoad()

        locationManager = CLLocationManager()
        locationManager.desiredAccuracy = kCLLocationAccuracyBest
        locationManager.requestAlwaysAuthorization()
        locationManager.distanceFilter = 50
        locationManager.startUpdatingLocation()
        locationManager.delegate = self

        let camera = GMSCameraPosition.camera(withLatitude: defaultLocation.coordinate.latitude, longitude: defaultLocation.coordinate.longitude, zoom: zoomLevel)
        mapView = GMSMapView.map(withFrame: view.bounds, camera: camera)
        mapView.autoresizingMask = [.flexibleWidth, .flexibleHeight]
        mapView.isMyLocationEnabled = true
        mapView.setMinZoom(14, maxZoom: 20)
        mapView.settings.compassButton = true
        mapView.isMyLocationEnabled = true
        mapView.settings.myLocationButton = true
        mapView.settings.scrollGestures = true
        mapView.settings.zoomGestures = true
        mapView.settings.rotateGestures = true
        mapView.settings.tiltGestures = true
        mapView.isIndoorEnabled = false

        marker.position = CLLocationCoordinate2D(latitude: 42.361145, longitude: -71.057083)
        marker.title = "Boston"
        marker.snippet = "USA"
        marker.map = mapView

        view.addSubview(mapView)
    }

    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
        switch status {
        case .restricted:
          print("Location access was restricted.")
        case .denied:
          print("User denied access to location.")
          // Display the map using the default location.
          mapView.isHidden = false
        case .notDetermined:
          print("Location status not determined.")
        case .authorizedAlways: fallthrough
        case .authorizedWhenInUse:
          print("Location status is OK.")
        }
    }

    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        locationManager.stopUpdatingLocation()
        print("Error: \(error)")
    }
    
}

struct GoogMapControllerRepresentable: UIViewControllerRepresentable {
    func makeUIViewController(context: UIViewControllerRepresentableContext<GoogMapControllerRepresentable>) -> GoogleMapController {
        return GoogleMapController()
    }

    func updateUIViewController(_ uiViewController: GoogleMapController, context: UIViewControllerRepresentableContext<GoogMapControllerRepresentable>) {

    }
}


// ref:https://stackoverflow.com/questions/58194015/google-maps-integration-into-swiftui
//struct GoogleMapView: UIViewRepresentable {
//    let marker: GMSMarker = GMSMarker()
//
//    /// Creates a `UIView` instance to be presented.
//    func makeUIView(context: Self.Context) -> GMSMapView {
//        print("makeUIView")
//        let camera = GMSCameraPosition.camera(withLatitude: -33.86, longitude: 151.20, zoom: 6.0)
//        let mapView = GMSMapView.map(withFrame: CGRect.zero, camera: camera)
//
//        return mapView
//    }
//
//    /// Updates the presented `UIView` (and coordinator) to the latest
//    /// configuration.
//    func updateUIView(_ mapView: GMSMapView, context: Self.Context) {
//        print("updateUIView")
//        marker.position = CLLocationCoordinate2D(latitude: -33.86, longitude: 151.20)
//        marker.title = "Sydney"
//        marker.snippet = "Australia"
//        marker.map = mapView
//    }
//}

//CLLocation
//ref: https://stackoverflow.com/questions/57681885/how-to-get-current-location-using-swiftui-without-viewcontrollers
//class LocationManager: NSObject, ObservableObject {
//
//    override init() {
//        super.init()
//        self.locationManager.delegate = self
//        self.locationManager.desiredAccuracy = kCLLocationAccuracyBest
//        self.locationManager.requestWhenInUseAuthorization()
//        self.locationManager.startUpdatingLocation()
//    }
//
//    @Published var locationStatus: CLAuthorizationStatus? {
//        willSet {
//            objectWillChange.send()
//        }
//    }
//
//    @Published var lastLocation: CLLocation? {
//        willSet {
//            objectWillChange.send()
//        }
//    }
//
//    var statusString: String {
//        guard let status = locationStatus else {
//            return "unknown"
//        }
//
//        switch status {
//        case .notDetermined: return "notDetermined"
//        case .authorizedWhenInUse: return "authorizedWhenInUse"
//        case .authorizedAlways: return "authorizedAlways"
//        case .restricted: return "restricted"
//        case .denied: return "denied"
//        default: return "unknown"
//        }
//
//    }
//
//    let objectWillChange = PassthroughSubject<Void, Never>()
//
//    private let locationManager = CLLocationManager()
//}
//
//extension LocationManager: CLLocationManagerDelegate {
//
//    func locationManager(_ manager: CLLocationManager, didChangeAuthorization status: CLAuthorizationStatus) {
//        self.locationStatus = status
//        print(#function, statusString)
//    }
//
//    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
//        guard let location = locations.last else { return }
//        self.lastLocation = location
//        print(#function, location)
//    }
//
//}
//

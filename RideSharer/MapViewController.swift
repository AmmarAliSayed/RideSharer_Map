//
//  MapViewController.swift
//  RideSharer
//
//

import UIKit
import MapKit
class MapViewController: UIViewController {

    @IBOutlet weak var mapView: MKMapView!
    private let locationManager = LocationHandler.shared.locationManager
    override func viewDidLoad() {
        super.viewDidLoad()
        enableLocationServices()
        showsUserLocation()
    }
    func enableLocationServices() {
        guard let manger = locationManager else {
                return
            }
        switch manger.authorizationStatus {
        case .notDetermined:
            print("DEBUG: Not determined..")
            locationManager?.requestWhenInUseAuthorization()
        case .restricted, .denied:
            //show an alert telling the user that they have not provided permission.
            print("DEBUG: denied..")
            showAlert ()
            break
        case .authorizedAlways:
            print("DEBUG: Auth always..")
        case .authorizedWhenInUse:
            print("DEBUG: Auth when in use..")
            locationManager?.startUpdatingLocation()
            //locationManager?.desiredAccuracy = kCLLocationAccuracyBest
        @unknown default:
            break
        }
    }
    func showsUserLocation() {
        mapView.showsUserLocation = true
        DispatchQueue.global().async {
            self.mapView.userTrackingMode = .follow
        }
    }
    func showAlert (){
        DispatchQueue.main.async {
            // create the alert
            let alert = UIAlertController(title: "Error", message: "you have not provided permission so you will not see your location!!", preferredStyle: UIAlertController.Style.alert)
            // add an action (button)
            alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: nil))
            // show the alert
            self.present(alert, animated: true, completion: nil)
        }
    }
}

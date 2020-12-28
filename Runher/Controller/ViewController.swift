//
//  ViewController.swift
//  Runher
//
//  Created by Hannah Friedman on 12/28/20.
//
import UIKit
import CoreLocation

class ViewController: UIViewController, CLLocationManagerDelegate {
    
    let locationManager = CLLocationManager()
    var run: Run!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        configureView()
        
        locationManager.delegate = self
        locationManager.requestWhenInUseAuthorization()
        locationManager.requestLocation()
    }
    
    private func configureView() {
        
    }
    
    
    
    
    @IBAction func startPressed(_ sender: UIButton) {
        
    }
    
    @IBAction func statsPressed(_ sender: UIButton) {
    }
    

    @IBAction func settingsPressed(_ sender: UIButton) {
    }
    
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        if let location = locations.last {
            locationManager.stopUpdatingLocation()
            let lat = location.coordinate.latitude
            let lon = location.coordinate.longitude
        }
    }
    
    func locationManager(_ manager: CLLocationManager, didFailWithError error: Error) {
        print(error)
    }
}


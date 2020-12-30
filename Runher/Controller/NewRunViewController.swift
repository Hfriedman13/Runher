//
//  NewRunViewController.swift
//  Runher
//
//  Created by Hannah Friedman on 12/28/20.
//
import CoreLocation
import UIKit

class NewRunViewController: UIViewController {
    
    @IBOutlet weak var dataStackView: UIStackView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    @IBOutlet weak var backButton: UIButton!
    
    private var run: Run?
    private let locationManager = LocationManager.shared
    private var seconds = 0
    private var timer: Timer?
    private var distance = Measurement(value: 0, unit: UnitLength.meters)
    private var locationList: [CLLocation] = []
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStackView.isHidden = true
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        timer?.invalidate()
        locationManager.stopUpdatingLocation()
    }
    
    
    private func startRun() {
        dataStackView.isHidden = true
        
        seconds = 0
        distance = Measurement(value: 0, unit: UnitLength.meters)
        locationList.removeAll()
        updateDisplay()
        timer = Timer.scheduledTimer(withTimeInterval: 1.0, repeats: true) { _ in
            self.eachSecond()
        }
        startLocationUpdates()
        
    }
    //MARK: - Stop function ALERT NOT WORKING CORRECTLY
    private func stopRun() {
        dataStackView.isHidden = false
        let alertController = UIAlertController(title: "End run?",
                                                message: "Do you wish to end your run?",
                                                preferredStyle: .actionSheet)
        
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) {
            _ in
            self.stopRun()
            self.performSegue(withIdentifier: "RunDetailsViewController", sender: nil)
        })
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) {
            _ in
            self.stopRun()
            _ = self.navigationController?.popToRootViewController(animated: true)
            
        })
        
        alertController.pruneNegativeWidthConstraints()
        present(alertController, animated: true, completion: nil)
        
        //MARK: - Shows details page after 5 seconds regardless of whats pressed
        
                DispatchQueue.main.asyncAfter(deadline: .now() + 5){
                    alertController.dismiss(animated: true, completion: {
                                self.performSegue(withIdentifier: "RunDetailsViewController", sender: self)
                    })
        }
        
    }
    
    //changing start to stop
    @IBAction func startPressed(_ sender: UIButton) {
        if sender.currentTitle == "START" {
            startRun()
            sender.setTitle("STOP", for: .normal)
            
        }
        else {
            stopRun()
            sender.setTitle("START", for: .normal)
        }
        
    }
    
    @IBAction func backButtonPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    func eachSecond() {
        seconds += 1
        updateDisplay()
    }
    
    private func updateDisplay() {
        let formattedDistance = FormatDisplay.distance(distance)
        let formattedTime = FormatDisplay.time(seconds)
        let formattedPace = FormatDisplay.pace(distance: distance,
                                               seconds: seconds,
                                               outputUnit: UnitSpeed.minutesPerMile)
        
        distanceLabel.text = "Distance:  \(formattedDistance)"
        timeLabel.text = "Time:  \(formattedTime)"
        paceLabel.text = "Pace:  \(formattedPace)"
    }
    
    private func startLocationUpdates() {
        locationManager.delegate = self
        locationManager.activityType = .fitness
        locationManager.distanceFilter = 10
        locationManager.startUpdatingLocation()
    }
    
    
    
}

extension NewRunViewController: SegueHandlerType {
    enum SegueIdentifier: String {
        case details = "RunDetailsViewController"
    }
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        switch segueIdentifier(for: segue) {
        case .details:
            let destination: RunDetailsViewController = segue.destination as! RunDetailsViewController
            destination.run = run
        }
    }
}
extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}
extension NewRunViewController: CLLocationManagerDelegate {
    
    func locationManager(_ manager: CLLocationManager, didUpdateLocations locations: [CLLocation]) {
        for newLocation in locations {
            let howRecent = newLocation.timestamp.timeIntervalSinceNow
            guard newLocation.horizontalAccuracy < 20 && abs(howRecent) < 10 else { continue }
            
            if let lastLocation = locationList.last {
                let delta = newLocation.distance(from: lastLocation)
                distance = distance + Measurement(value: delta, unit: UnitLength.meters)
            }
            
            locationList.append(newLocation)
        }
    }
}

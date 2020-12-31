//
//  RunDetailsViewController.swift
//  Runher
//
//  Created by Hannah Friedman on 12/29/20.
//

import UIKit
import MapKit

class RunDetailsViewController: UIViewController {
    
    @IBOutlet weak var mapView: MKMapView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var backButton: UIButton!
    
    var run: Run!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        configureView()
    }
    private func configureView() {
        let distance = Measurement(value: run.distance, unit: UnitLength.meters)
          let seconds = Int(run.duration)
          let formattedDistance = FormatDisplay.distance(distance)
          let formattedDate = FormatDisplay.date(run.timestamp)
          let formattedTime = FormatDisplay.time(seconds)
          let formattedPace = FormatDisplay.pace(distance: distance,
                                                 seconds: seconds,
                                                 outputUnit: UnitSpeed.minutesPerMile)
          
          distanceLabel.text = "Distance:  \(formattedDistance)"
          dateLabel.text = formattedDate
          timeLabel.text = "Time:  \(formattedTime)"
          paceLabel.text = "Pace:  \(formattedPace)"
    }
    
}


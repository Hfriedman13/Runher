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
    
    var run: Run!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
        configureView()
    }
    private func configureView() {
        
    }
}

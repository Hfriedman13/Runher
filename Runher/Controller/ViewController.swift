//
//  ViewController.swift
//  Runher
//
//  Created by Hannah Friedman on 12/28/20.
//
import UIKit

class ViewController: UIViewController{
    
    @IBOutlet weak var statsButton: UIButton!
    @IBOutlet weak var newRunButton: UIButton!
    @IBOutlet weak var settingsButton: UIButton!
    
    public var run: Run!
    
    override func viewDidLoad() {
      super.viewDidLoad()
        
    }
    
    @IBAction func newRunPressed(_ sender: UIButton) {
        performSegue(withIdentifier: .newRun, sender: nil)
    }
    
}

extension ViewController: SegueHandlerType {
  enum SegueIdentifier: String {
    case newRun = "NewRunViewController"
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segueIdentifier(for: segue) {
    case .newRun:
        _ = segue.destination as! NewRunViewController
      //destination.run = run
    }
  }
}

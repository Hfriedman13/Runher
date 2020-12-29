//
//  NewRunViewController.swift
//  Runher
//
//  Created by Hannah Friedman on 12/28/20.
//

import UIKit

class NewRunViewController: UIViewController {
    
    @IBOutlet weak var dataStackView: UIStackView!
    @IBOutlet weak var distanceLabel: UILabel!
    @IBOutlet weak var paceLabel: UILabel!
    @IBOutlet weak var timeLabel: UILabel!
    @IBOutlet weak var startButton: UIButton!
    
    private var run: Run?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStackView.isHidden = true
    }
    
    private func startRun() {
      dataStackView.isHidden = true
      //startButton.setTitle("STOP", for: .normal)
    }
      
    private func stopRun() {
      dataStackView.isHidden = false
      
        let alertController = UIAlertController(title: "End run?",
                                                message: "Do you wish to end your run?",
                                                preferredStyle: .actionSheet)
        alertController.addAction(UIAlertAction(title: "Cancel", style: .cancel))
        alertController.addAction(UIAlertAction(title: "Save", style: .default) { _ in
          self.stopRun()
          self.performSegue(withIdentifier: .details, sender: nil)
        })
        alertController.addAction(UIAlertAction(title: "Discard", style: .destructive) { _ in
          self.stopRun()
          _ = self.navigationController?.popToRootViewController(animated: true)
        })
            
        present(alertController, animated: true)
        
    }
    
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
    
}

extension NewRunViewController: SegueHandlerType {
  enum SegueIdentifier: String {
    case details = "RunDetailsViewController"
  }

  override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
    switch segueIdentifier(for: segue) {
    case .details:
      let destination = segue.destination as! RunDetailsViewController
      destination.run = run
    }
  }
}

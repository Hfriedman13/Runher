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
      //add timer in that goes while running?
    }
      
    private func stopRun() {
      dataStackView.isHidden = false
//alerts to end run / save run
//currently broken -- endless loop, if save then goes to details screen
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
        alertController.pruneNegativeWidthConstraints()
        //alertController.view.addSubview(UIView())
        present(alertController, animated: true, completion: nil)
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
extension UIAlertController {
    func pruneNegativeWidthConstraints() {
        for subView in self.view.subviews {
            for constraint in subView.constraints where constraint.debugDescription.contains("width == - 16") {
                subView.removeConstraint(constraint)
            }
        }
    }
}

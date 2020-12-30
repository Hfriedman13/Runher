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
    @IBOutlet weak var backButton: UIButton!
    
    private var run: Run?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        dataStackView.isHidden = true
    }
    
    private func startRun() {
      dataStackView.isHidden = true
      //add timer in that goes while running?
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
        
//        DispatchQueue.main.asyncAfter(deadline: .now() + 5){
//            alertController.dismiss(animated: true, completion: {
//                        self.performSegue(withIdentifier: "RunDetailsViewController", sender: self)
//            })
        //}
       
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

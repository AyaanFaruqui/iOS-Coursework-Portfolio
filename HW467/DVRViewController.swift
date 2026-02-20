//
//  DVRViewController.swift
//  HW467
//
//  Created by CDMStudent on 2/16/26.
//

import UIKit

class DVRViewController: UIViewController {
    
    var isPowerOn = false
    
    @IBOutlet weak var powerValueLabel: UILabel!
    
    @IBOutlet weak var stateValueLabel: UILabel!
    
    @IBOutlet var mediaButtons: [UIButton]!
    

    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mediaButtons.forEach { $0.isEnabled = false }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    
    @IBAction func switchToTVPressed(_ sender: UIButton) {
        self.dismiss(animated: true, completion: nil)
    }
    
    
    @IBAction func playPressed(_ sender: UIButton) {
        if !isPowerOn { return }
        if stateValueLabel.text == "Recording" {
            showInvalidOperationAlert(for: "Play")
        } else {
            stateValueLabel.text = "Playing"
        }
    }
    
    @IBAction func stopPressed(_ sender: UIButton) {
        if !isPowerOn { return }
        stateValueLabel.text = "Stopped"
    }
    
    @IBAction func recordPressed(_ sender: UIButton) {
        if !isPowerOn {
            return
        }
        if stateValueLabel.text == "Stopped" {
                stateValueLabel.text = "Recording"
            } else {

                showInvalidOperationAlert(for: "Record")
            }
    }
    
    @IBAction func powerToggled(_ sender: UISwitch) {
        isPowerOn = sender.isOn
        powerValueLabel.text = isPowerOn ? "On" : "Off"
        if !isPowerOn {
            stateValueLabel.text = "Stopped"
        }
        mediaButtons.forEach { $0.isEnabled = isPowerOn }
    }
    
    @IBAction func pausePressed(_ sender: UIButton) {
        if !isPowerOn { return }
        if stateValueLabel.text == "Playing" {
            stateValueLabel.text = "Paused"
        } else {
            showInvalidOperationAlert(for: "Pause")
        }
    }
    
    @IBAction func fastForwardPressed(_ sender: UIButton) {
        if !isPowerOn { return }
        if stateValueLabel.text == "Playing" {
            stateValueLabel.text = "Fast Forwarding"
        } else {
            showInvalidOperationAlert(for: "Fast Forward")
        }
    }
    
    @IBAction func fastRewindPressed(_ sender: UIButton) {
        if !isPowerOn { return }
        if stateValueLabel.text == "Playing" {
            stateValueLabel.text = "Fast Rewinding"
        } else {
            showInvalidOperationAlert(for: "Fast Rewind")
        }
    }
    
    func showInvalidOperationAlert(for operation: String) {
        let currentState = stateValueLabel.text ?? "Unknown"
        let alert = UIAlertController(title: "Invalid Operation",
        message: "Cannot \(operation) while \(currentState)",
        preferredStyle: .actionSheet)
        let forceAction = UIAlertAction(title: "Force", style: .destructive) { _ in
            self.showForceOperationAlert(for: operation)
        }
        
        let cancelAction = UIAlertAction(title: "Cancel", style: .cancel)
        
        alert.addAction(forceAction)
        alert.addAction(cancelAction)
        present(alert, animated: true)
    }
    
    
    func showForceOperationAlert(for operation: String) {
        let alert = UIAlertController(title: "Force Operation",
                                      message: "\(operation) operation succeeded",
                                      preferredStyle: .alert)
        
        let okAction = UIAlertAction(title: "Ok", style: .default) { _ in
            
            let stateMapping = [
                "Play": "Playing",
                "Stop": "Stopped",
                "Pause": "Paused",
                "Fast Forward": "Fast Forwarding",
                "Fast Rewind": "Fast Rewinding",
                "Record": "Recording"
            ]
            self.stateValueLabel.text = stateMapping[operation] ?? "Stopped"
        }
        alert.addAction(okAction)
        present(alert, animated: true)
    }
    
}

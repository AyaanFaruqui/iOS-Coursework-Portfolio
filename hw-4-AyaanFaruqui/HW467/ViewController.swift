//
//  ViewController.swift
//  HW467
//
//  Created by Rohan Panchal on 1/27/25.
//

import UIKit

class ViewController: UIViewController {
    
    @IBOutlet weak var powerValueLabel: UILabel!
    
    @IBOutlet weak var volumeValueLabel: UILabel!
    
    @IBOutlet weak var channelValueLabel: UILabel!
    
    @IBOutlet weak var volumeSlider: UISlider!
    
    @IBOutlet weak var favoriteChannelSegmentedControl: UISegmentedControl!
    
    @IBOutlet var remoteButtons: [UIButton]!
    
    @IBOutlet weak var powerSwitch: UISwitch!
    

    override func viewDidLoad() {
        super.viewDidLoad()
        
        powerValueLabel.accessibilityIdentifier = "TV_Power_Value"
        volumeValueLabel.accessibilityIdentifier = "TV_Speaker_Volume_Value"
        channelValueLabel.accessibilityIdentifier = "Current_Channel_Value"
        
        
        
        favoriteChannelSegmentedControl.accessibilityIdentifier =     "Favorite_Channel_Segmented_Control"
        favoriteChannelSegmentedControl.accessibilityTraits = .button
        volumeSlider.accessibilityIdentifier = "Volume_Slider"
        powerSwitch.accessibilityIdentifier = "Power_Switch"
        
        setupInitialState()
        // Do any additional setup after loading the view.
    }
    
    private func setupInitialState() {
        powerValueLabel.text = "Off"
        volumeValueLabel.text = "0"
        channelValueLabel.text = "50"
        powerSwitch.isOn = false
        volumeSlider.value = 0
        updateControls(enabled: false)
        }
    
    private func updateControls(enabled: Bool) {
        volumeSlider.isEnabled = enabled
        favoriteChannelSegmentedControl.isEnabled = enabled
        if let buttons = remoteButtons {
            for button in buttons {
                button.isEnabled = enabled
            }
        }
    }
    
        @IBAction func powerToggled(_ sender: UISwitch) {
            let isTVOn = sender.isOn
            powerValueLabel.text = isTVOn ? "On" : "Off"
                
            updateControls(enabled: isTVOn)
        }
    
    @IBAction func numberPressed(_ sender: UIButton) {
        guard let digit = sender.currentTitle else { return }
            let currentText = channelValueLabel.text ?? ""
            if currentText.count >= 2 {
                channelValueLabel.text = digit
            } else {
                let combined = currentText + digit
                if let val = Int(combined) {
                    channelValueLabel.text = String(format: "%02d", val)
                }
            }
    }
    
    @IBAction func channelToggled(_ sender: UIButton) {
        if let currentText = channelValueLabel.text, var channel = Int(currentText) {
                if sender.currentTitle == "CH+" {
                    channel = (channel >= 99) ? 1 : channel + 1
                } else if sender.currentTitle == "CH-" {
                    channel = (channel <= 1) ? 99 : channel - 1
                }
                channelValueLabel.text = String(format: "%02d", channel)
            }
    }
    
    @IBAction func volumeSlid(_ sender: UISlider) {
        volumeValueLabel.text = "\(Int(sender.value))"
    }
    
    
    @IBAction func favoriteChannelChanged(_ sender: UISegmentedControl) {
        let favoriteChannels = ["07", "05", "02", "32"]
        channelValueLabel.text = favoriteChannels[sender.selectedSegmentIndex]
    }
    
    

}


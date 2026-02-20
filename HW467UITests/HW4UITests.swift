//
//  HW4UITests.swift
//  HW4UITests
//
//  Created by Rohan Panchal on 1/28/24.
//

import XCTest

final class HW4UITests: XCTestCase {
    
    let VALID_TV_POWER_VALUES = [
        "on", "off", "On", "Off"
    ]
    
    let VALID_VOLUME_RANGE = 0...100
    
    let VALID_CHANNEL_RANGE = 0...99
    let DEFAULT_CHANNEL_VALUE = 50

    // 1.A
    // 10 Points
    func testAllElementsExist() {

        let app = XCUIApplication()
        app.launch()
                
        // Check that all of the header elements exist
        XCTAssertTrue(app.staticTexts["My TV"].exists)
        XCTAssertTrue(app.staticTexts["TV Power:"].exists)
        XCTAssertTrue(app.staticTexts["TV_Power_Value"].exists) // Use Identifier
        XCTAssertTrue(app.staticTexts["Speaker Volume:"].exists)
        XCTAssertTrue(app.staticTexts["TV_Speaker_Volume_Value"].exists) // Use Identifier
        XCTAssertTrue(app.staticTexts["Current Channel:"].exists)
        XCTAssertTrue(app.staticTexts["Current_Channel_Value"].exists) // Use Identifier
        
        // Check for the remote title
        XCTAssertTrue(app.staticTexts["My Remote Control"].exists)

        // Check for power label + switch
        XCTAssertTrue(app.staticTexts["Power"].exists)
        XCTAssertTrue(app.switches["Power_Switch"].exists) // Use Identifier
        
        // Check for volume label + Slider
        XCTAssertTrue(app.staticTexts["Volume"].exists)
        XCTAssertTrue(app.sliders["Volume_Slider"].exists) // Use Identifier
        
        // Check for Channel label and buttons
        XCTAssertTrue(app.staticTexts["Channel"].exists)
        
        XCTAssertTrue(app.buttons["0"].exists)
        XCTAssertTrue(app.buttons["1"].exists)
        XCTAssertTrue(app.buttons["2"].exists)
        XCTAssertTrue(app.buttons["3"].exists)
        XCTAssertTrue(app.buttons["4"].exists)
        XCTAssertTrue(app.buttons["5"].exists)
        XCTAssertTrue(app.buttons["6"].exists)
        XCTAssertTrue(app.buttons["7"].exists)
        XCTAssertTrue(app.buttons["8"].exists)
        XCTAssertTrue(app.buttons["9"].exists)
        
        XCTAssertTrue(app.buttons["CH+"].exists)
        XCTAssertTrue(app.buttons["CH-"].exists)
        
        
        // Check for favorite channel label and segmented control
        XCTAssertTrue(app.staticTexts["Favorite Channel"].exists)
        XCTAssertTrue(app.segmentedControls["Favorite_Channel_Segmented_Control"].exists)
        
        // Check that there are 4 buttons in the segmented control.
        XCTAssertTrue(app.segmentedControls["Favorite_Channel_Segmented_Control"].buttons.count == 4)
    }
    
    // 1.B
    // 10 Points
    func testPowerButtonTogglesTVPowerValue() {
        
        let app = XCUIApplication()
        app.launch()
        
        var currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must begin in 'off' state
        XCTAssertEqual(currentPowerValue, "off" )
        
        XCTAssertFalse(app.sliders["Volume_Slider"].isEnabled)
        
        XCTAssertFalse(app.buttons["0"].isEnabled)
        XCTAssertFalse(app.buttons["1"].isEnabled)
        XCTAssertFalse(app.buttons["2"].isEnabled)
        XCTAssertFalse(app.buttons["3"].isEnabled)
        XCTAssertFalse(app.buttons["4"].isEnabled)
        XCTAssertFalse(app.buttons["5"].isEnabled)
        XCTAssertFalse(app.buttons["6"].isEnabled)
        XCTAssertFalse(app.buttons["7"].isEnabled)
        XCTAssertFalse(app.buttons["8"].isEnabled)
        XCTAssertFalse(app.buttons["9"].isEnabled)
        
        XCTAssertFalse(app.buttons["CH+"].isEnabled)
        XCTAssertFalse(app.buttons["CH-"].isEnabled)
        
        // To test that a segmented control is disabled, you must iterate over each sub-button
        app.segmentedControls.matching(identifier: "Favorite_Channel_Segmented_Control").buttons.allElementsBoundByIndex.forEach { element in
            XCTAssertFalse(element.isEnabled)
        }
        
        /*
         Toggle power value
         */
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must now be in 'on' state
        XCTAssertEqual(currentPowerValue, "on" )
        
        XCTAssertTrue(app.sliders["Volume_Slider"].isEnabled)
        
        XCTAssertTrue(app.buttons["0"].isEnabled)
        XCTAssertTrue(app.buttons["1"].isEnabled)
        XCTAssertTrue(app.buttons["2"].isEnabled)
        XCTAssertTrue(app.buttons["3"].isEnabled)
        XCTAssertTrue(app.buttons["4"].isEnabled)
        XCTAssertTrue(app.buttons["5"].isEnabled)
        XCTAssertTrue(app.buttons["6"].isEnabled)
        XCTAssertTrue(app.buttons["7"].isEnabled)
        XCTAssertTrue(app.buttons["8"].isEnabled)
        XCTAssertTrue(app.buttons["9"].isEnabled)
        
        XCTAssertTrue(app.buttons["CH+"].isEnabled)
        XCTAssertTrue(app.buttons["CH-"].isEnabled)
        
        // To test that a segmented control is disabled, you must iterate over each sub-button
        app.segmentedControls.matching(identifier: "Favorite_Channel_Segmented_Control").buttons.allElementsBoundByIndex.forEach { element in
            XCTAssertTrue(element.isEnabled)
        }
    }
    
    // 1.C
    // Points: 10
    func testVolumeSliderChangesVolumeValue() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must now be in 'on' state
        XCTAssertEqual(currentPowerValue, "on" )
        
        XCTAssertTrue(app.sliders["Volume_Slider"].isEnabled)
        
        // Swipe right on the volume slider and check the volume value is in the range.
        
        var currentVolumeValue = app.staticTexts["TV_Speaker_Volume_Value"].label
        
        app.sliders["Volume_Slider"].swipeRight()
        
        var newVolumeValue = app.staticTexts["TV_Speaker_Volume_Value"].label
        
        XCTAssertNotEqual(currentVolumeValue, newVolumeValue)
        
        // Swipe left on the volume slider and check the volume value is in the range.
        
        currentVolumeValue = app.staticTexts["TV_Speaker_Volume_Value"].label
        
        app.sliders["Volume_Slider"].swipeLeft()
        
        newVolumeValue = app.staticTexts["TV_Speaker_Volume_Value"].label
        
        XCTAssertNotEqual(currentVolumeValue, newVolumeValue)
    }
    
    // 1.D
    // Points: 10
    func testVolumeSliderStaysWithinRange() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must now be in 'on' state
        XCTAssertEqual(currentPowerValue, "on" )
        
        
        // Check that the volume slider is enabled
        
        XCTAssertTrue(app.sliders["Volume_Slider"].isEnabled)
        
        
        // Check the current default volume value is within the range.
        var currentVolumeValue = app.staticTexts["TV_Speaker_Volume_Value"].label
        
        XCTAssertTrue(VALID_VOLUME_RANGE.contains(Int(currentVolumeValue)!))
        
        
        // Swipe right on the volume slider and check the volume value is in the range.
        
        app.sliders["Volume_Slider"].swipeRight()
        
        var newVolumeValue = app.staticTexts["TV_Speaker_Volume_Value"].label
        
        XCTAssertTrue(VALID_VOLUME_RANGE.contains(Int(newVolumeValue)!))
        
        
        // Swipe left on the volume slider and check the volume value is in the range.
        
        currentVolumeValue = app.staticTexts["TV_Speaker_Volume_Value"].label
        
        app.sliders["Volume_Slider"].swipeLeft()
        
        newVolumeValue = app.staticTexts["TV_Speaker_Volume_Value"].label
        
        XCTAssertTrue(VALID_VOLUME_RANGE.contains(Int(newVolumeValue)!))
    }
    
    // 1.E
    // Points: 5
    func testChannelPlusIncrementsChannelValue() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        
        // TV_Power_Value must now be in 'on' state
        
        XCTAssertEqual(currentPowerValue, "on" )
        
        
        // Check that both CH+ and CH- are enabled
        
        XCTAssertTrue(app.buttons["CH+"].isEnabled)
        XCTAssertTrue(app.buttons["CH-"].isEnabled)
        
        // Check that the Current_Channel_Value is equal
        let currentChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertTrue(VALID_CHANNEL_RANGE.contains(currentChannelValue))
        XCTAssertEqual(currentChannelValue, DEFAULT_CHANNEL_VALUE)
        
        app.buttons["CH+"].tap()
        
        let newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertEqual(newChannelValue, 51)
        
    }
    
    // 1.F
    // Points: 5
    func testChannelMinusDecrementsChannelValue() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        
        // TV_Power_Value must now be in 'on' state
        
        XCTAssertEqual(currentPowerValue, "on" )
        
        
        // Check that both CH+ and CH- are enabled
        
        XCTAssertTrue(app.buttons["CH+"].isEnabled)
        XCTAssertTrue(app.buttons["CH-"].isEnabled)
        
        let currentChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertTrue(VALID_CHANNEL_RANGE.contains(currentChannelValue))
        XCTAssertEqual(currentChannelValue, DEFAULT_CHANNEL_VALUE)
        
        app.buttons["CH-"].tap()
        
        let newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertEqual(newChannelValue, 49)
    }
    
    // 1.G
    // Points: 5
    func testChannelNumberSequence01() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must now be in 'on' state
        
        XCTAssertEqual(currentPowerValue, "on" )
        
        
        // Check that all of the number buttons are enabled
        
        XCTAssertTrue(app.buttons["0"].isEnabled)
        XCTAssertTrue(app.buttons["1"].isEnabled)
        XCTAssertTrue(app.buttons["2"].isEnabled)
        XCTAssertTrue(app.buttons["3"].isEnabled)
        XCTAssertTrue(app.buttons["4"].isEnabled)
        XCTAssertTrue(app.buttons["5"].isEnabled)
        XCTAssertTrue(app.buttons["6"].isEnabled)
        XCTAssertTrue(app.buttons["7"].isEnabled)
        XCTAssertTrue(app.buttons["8"].isEnabled)
        XCTAssertTrue(app.buttons["9"].isEnabled)
        
        // Check default Current_Channel_Value
        
        let currentChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertTrue(VALID_CHANNEL_RANGE.contains(currentChannelValue))
        XCTAssertEqual(currentChannelValue, DEFAULT_CHANNEL_VALUE)
        
        app.buttons["0"].tap()
        app.buttons["1"].tap()
        
        let newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertEqual(newChannelValue, 01)
    }
    
    // 1.H
    // Points: 5
    func testChannelNumberSequence02() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must now be in 'on' state
        
        XCTAssertEqual(currentPowerValue, "on" )
        
        
        // Check that all of the number buttons are enabled
        
        XCTAssertTrue(app.buttons["0"].isEnabled)
        XCTAssertTrue(app.buttons["1"].isEnabled)
        XCTAssertTrue(app.buttons["2"].isEnabled)
        XCTAssertTrue(app.buttons["3"].isEnabled)
        XCTAssertTrue(app.buttons["4"].isEnabled)
        XCTAssertTrue(app.buttons["5"].isEnabled)
        XCTAssertTrue(app.buttons["6"].isEnabled)
        XCTAssertTrue(app.buttons["7"].isEnabled)
        XCTAssertTrue(app.buttons["8"].isEnabled)
        XCTAssertTrue(app.buttons["9"].isEnabled)
        
        // Check default Current_Channel_Value
        
        let currentChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertTrue(VALID_CHANNEL_RANGE.contains(currentChannelValue))
        XCTAssertEqual(currentChannelValue, DEFAULT_CHANNEL_VALUE)
        
        app.buttons["1"].tap()
        app.buttons["0"].tap()
        
        let newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertEqual(newChannelValue, 10)
    }
    
    // 1.I
    // Points: 5
    func testChannelNumberSequence03() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must now be in 'on' state
        
        XCTAssertEqual(currentPowerValue, "on" )
        
        
        // Check that all of the number buttons are enabled
        
        XCTAssertTrue(app.buttons["0"].isEnabled)
        XCTAssertTrue(app.buttons["1"].isEnabled)
        XCTAssertTrue(app.buttons["2"].isEnabled)
        XCTAssertTrue(app.buttons["3"].isEnabled)
        XCTAssertTrue(app.buttons["4"].isEnabled)
        XCTAssertTrue(app.buttons["5"].isEnabled)
        XCTAssertTrue(app.buttons["6"].isEnabled)
        XCTAssertTrue(app.buttons["7"].isEnabled)
        XCTAssertTrue(app.buttons["8"].isEnabled)
        XCTAssertTrue(app.buttons["9"].isEnabled)
        
        // Check default Current_Channel_Value
        
        let currentChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertTrue(VALID_CHANNEL_RANGE.contains(currentChannelValue))
        XCTAssertEqual(currentChannelValue, DEFAULT_CHANNEL_VALUE)
        
        app.buttons["3"].tap()
        app.buttons["0"].tap()
        
        app.buttons["3"].tap()
        app.buttons["1"].tap()
        
        let newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertEqual(newChannelValue, 31)
    }
    
    // 1.J
    // Points: 5
    func testChannelNumberSequence04() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must now be in 'on' state
        
        XCTAssertEqual(currentPowerValue, "on" )
        
        
        // Check that all of the number buttons are enabled
        
        XCTAssertTrue(app.buttons["0"].isEnabled)
        XCTAssertTrue(app.buttons["1"].isEnabled)
        XCTAssertTrue(app.buttons["2"].isEnabled)
        XCTAssertTrue(app.buttons["3"].isEnabled)
        XCTAssertTrue(app.buttons["4"].isEnabled)
        XCTAssertTrue(app.buttons["5"].isEnabled)
        XCTAssertTrue(app.buttons["6"].isEnabled)
        XCTAssertTrue(app.buttons["7"].isEnabled)
        XCTAssertTrue(app.buttons["8"].isEnabled)
        XCTAssertTrue(app.buttons["9"].isEnabled)
        
        // Check default Current_Channel_Value
        
        let currentChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertTrue(VALID_CHANNEL_RANGE.contains(currentChannelValue))
        XCTAssertEqual(currentChannelValue, DEFAULT_CHANNEL_VALUE)
        
        app.buttons["3"].tap()
        app.buttons["0"].tap()
        
        app.buttons["3"].tap()
        
        app.buttons["CH+"].tap()
        
        let newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertEqual(newChannelValue, 31)
    }
    
    // 1.K
    // Points: 5
    func testChannelTopEndOfRange() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must now be in 'on' state
        
        XCTAssertEqual(currentPowerValue, "on" )
        
        // Check that all of the number buttons are enabled
        
        XCTAssertTrue(app.buttons["0"].isEnabled)
        XCTAssertTrue(app.buttons["1"].isEnabled)
        XCTAssertTrue(app.buttons["2"].isEnabled)
        XCTAssertTrue(app.buttons["3"].isEnabled)
        XCTAssertTrue(app.buttons["4"].isEnabled)
        XCTAssertTrue(app.buttons["5"].isEnabled)
        XCTAssertTrue(app.buttons["6"].isEnabled)
        XCTAssertTrue(app.buttons["7"].isEnabled)
        XCTAssertTrue(app.buttons["8"].isEnabled)
        XCTAssertTrue(app.buttons["9"].isEnabled)
        
        // Check default Current_Channel_Value
        
        let currentChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        var newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertTrue(VALID_CHANNEL_RANGE.contains(currentChannelValue))
        XCTAssertEqual(currentChannelValue, DEFAULT_CHANNEL_VALUE)
        
        app.buttons["9"].tap()
        app.buttons["9"].tap()
        
        newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertEqual(newChannelValue, 99)
        
        app.buttons["CH+"].tap()
        
        newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertEqual(newChannelValue, 01)
    }
    
    // 1.L
    // Points: 5
    func testChannelBottomEndOfRange() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must now be in 'on' state
        
        XCTAssertEqual(currentPowerValue, "on" )
        
        // Check that all of the number buttons are enabled
        
        XCTAssertTrue(app.buttons["0"].isEnabled)
        XCTAssertTrue(app.buttons["1"].isEnabled)
        XCTAssertTrue(app.buttons["2"].isEnabled)
        XCTAssertTrue(app.buttons["3"].isEnabled)
        XCTAssertTrue(app.buttons["4"].isEnabled)
        XCTAssertTrue(app.buttons["5"].isEnabled)
        XCTAssertTrue(app.buttons["6"].isEnabled)
        XCTAssertTrue(app.buttons["7"].isEnabled)
        XCTAssertTrue(app.buttons["8"].isEnabled)
        XCTAssertTrue(app.buttons["9"].isEnabled)
        
        // Check default Current_Channel_Value
        
        let currentChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        var newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertTrue(VALID_CHANNEL_RANGE.contains(currentChannelValue))
        XCTAssertEqual(currentChannelValue, DEFAULT_CHANNEL_VALUE)
        
        app.buttons["0"].tap()
        app.buttons["1"].tap()
        
        newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertEqual(newChannelValue, 01)
        
        app.buttons["CH-"].tap()
        
        newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertEqual(newChannelValue, 99)
    }
    
    // 1.M
    // Points: 10
    func testSegmentedControlChangesChannelValue() {
        
        let app = XCUIApplication()
        app.launch()
        
        // Tap the Power_Switch
        app.switches["Power_Switch"].tap()
        
        let currentPowerValue = app.staticTexts["TV_Power_Value"].label.lowercased()
        
        // TV_Power_Value must now be in 'on' state
        
        XCTAssertEqual(currentPowerValue, "on" )
        
        
        // Check that all of the number buttons are enabled
        
        app.segmentedControls.matching(identifier: "Favorite_Channel_Segmented_Control").buttons.allElementsBoundByIndex.forEach { element in
            XCTAssertTrue(element.isEnabled)
        }
        
        // Check default Current_Channel_Value
        
        var currentChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertTrue(VALID_CHANNEL_RANGE.contains(currentChannelValue))
        XCTAssertEqual(currentChannelValue, DEFAULT_CHANNEL_VALUE)
        
        // Iterate over each segmented control button and check for changing channel values.
        
        var newChannelValue: Int
        
        let segmentedControlButtons = app.segmentedControls
            .matching(identifier: "Favorite_Channel_Segmented_Control")
            .buttons
            .allElementsBoundByIndex
        
        // button 0
        
        segmentedControlButtons[0].tap()
        
        newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertNotEqual(currentChannelValue, newChannelValue)
        
        // Button 1
        
        currentChannelValue = newChannelValue
        
        segmentedControlButtons[1].tap()
        
        newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertNotEqual(currentChannelValue, newChannelValue)
        
        // Button 2
        
        currentChannelValue = newChannelValue
        
        segmentedControlButtons[2].tap()
        
        newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertNotEqual(currentChannelValue, newChannelValue)
        
        // Button 3
        
        currentChannelValue = newChannelValue
        
        segmentedControlButtons[3].tap()
        
        newChannelValue = Int(app.staticTexts["Current_Channel_Value"].label)!
        
        XCTAssertNotEqual(currentChannelValue, newChannelValue)
    }
}

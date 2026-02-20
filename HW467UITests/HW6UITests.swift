//
//  HW6UITests.swift
//  HW4UITests
//
//  Created by Rohan Panchal on 2/06/24.
//

import XCTest

final class HW6UITests: XCTestCase {

    // 1.A
    // 10 Points
    func testAllElementsExist() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        XCTAssertTrue(app.staticTexts["My DVR"].exists)
        
        XCTAssertTrue(app.staticTexts["DVR Power:"].exists)
        XCTAssertTrue(app.staticTexts["DVR_Power_Value"].exists) //
        
        XCTAssertTrue(app.staticTexts["State:"].exists)
        XCTAssertTrue(app.staticTexts["DVR_State_Value"].exists) //
 
        XCTAssertTrue(app.staticTexts["DVR Remote Control"].exists)
        
        XCTAssertTrue(app.staticTexts["Power:"].exists)
        
        XCTAssertTrue(app.switches["DVR_Power_Switch"].exists) //
        
        XCTAssertTrue(app.buttons["Play"].exists)
        XCTAssertTrue(app.buttons["Stop"].exists)
        XCTAssertTrue(app.buttons["Pause"].exists)
        XCTAssertTrue(app.buttons["Fast Forward"].exists)
        XCTAssertTrue(app.buttons["Fast Rewind"].exists)
        XCTAssertTrue(app.buttons["Record"].exists)
        
        XCTAssertTrue(app.buttons["Switch to TV"].exists)
    }
    
    // 1.B
    // 5 Points
    func testLaunchSettings() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        // Check power and state to be Off and Stopped
        
        XCTAssertEqual(app.staticTexts["DVR_Power_Value"].label, "Off") //
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped") //
        
        // All buttons should be disabled.
        XCTAssertFalse(app.buttons["Play"].isEnabled)
        XCTAssertFalse(app.buttons["Stop"].isEnabled)
        XCTAssertFalse(app.buttons["Pause"].isEnabled)
        XCTAssertFalse(app.buttons["Fast Forward"].isEnabled)
        XCTAssertFalse(app.buttons["Fast Rewind"].isEnabled)
        XCTAssertFalse(app.buttons["Record"].isEnabled)
    }
    
    // 1.C
    // 5 Points
    func testPowerSwitchShouldChangeValues() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        // Check power and state to be On and Stopped
        
        XCTAssertEqual(app.staticTexts["DVR_Power_Value"].label, "On") //
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped") //
        
        // All buttons should be disabled.
        XCTAssertTrue(app.buttons["Play"].isEnabled)
        XCTAssertTrue(app.buttons["Stop"].isEnabled)
        XCTAssertTrue(app.buttons["Pause"].isEnabled)
        XCTAssertTrue(app.buttons["Fast Forward"].isEnabled)
        XCTAssertTrue(app.buttons["Fast Rewind"].isEnabled)
        XCTAssertTrue(app.buttons["Record"].isEnabled)
    }
    
    // 1.D
    // 5 Points
    func testStopButtonShouldWorkWhenInStoppedMode() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        // Should already be in Stopped Mode
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
    }
    
    // 1.E
    // 5 Points
    func testStopButtonShouldWorkWhenInPlayingMode() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        //
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
    }
    
    // 1.F
    // 5 Points
    func testStopButtonShouldWorkWhenInPausedMode() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        //
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        app.buttons["Pause"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Paused")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
    }
    
    // 1.G
    // 5 Points
    func testStopButtonShouldWorkWhenInFastForwardingMode() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        //
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        app.buttons["Fast Forward"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Fast Forwarding")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
    }
    
    // 1.H
    // 5 Points
    func testStopButtonShouldWorkWhenInFastRewindingMode() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        //
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        app.buttons["Fast Rewind"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Fast Rewinding")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
    }
    
    // 1.I
    // 5 Points
    func testStopButtonShouldWorkWhenInRecordingMode() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        //
        
        app.buttons["Record"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Recording")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
    }
    
    // 1.J
    // 10
    func testRecordButtonOnlyWorksWhenInStoppedMode() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        //
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
        
        app.buttons["Record"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Recording")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
        
        // Stopped -> Play -> Fast Forward -> Record - * -> Cancel -> Stop
        
        app.buttons["Play"].tap()
        
        app.buttons["Fast Forward"].tap()
        
        app.buttons["Record"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
        
        app.buttons["Cancel"].tap()
        
        app.buttons["Stop"].tap()
        
        // Stopped -> Play -> Fast Rewind -> Record - * -> Cancel -> Stop
        
        app.buttons["Play"].tap()
        
        app.buttons["Fast Rewind"].tap()
        
        app.buttons["Record"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
        
        app.buttons["Cancel"].tap()
        
        app.buttons["Stop"].tap()
        
        // Stopped -> Play -> Paused -> Record - * -> Cancel -> Stop
        
        app.buttons["Play"].tap()
        
        app.buttons["Pause"].tap()
        
        app.buttons["Record"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
        
        app.buttons["Cancel"].tap()
        
        app.buttons["Stop"].tap()
        
        // Stopped -> Playing -> Record - * -> Cancel -> Stop
        
        app.buttons["Play"].tap()
        
        app.buttons["Record"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
        
        app.buttons["Cancel"].tap()
        
        app.buttons["Stop"].tap()
        
        // Stopped -> Record -> Record -> * -> Cancel -> Stop
        
        app.buttons["Record"].tap()
        
        app.buttons["Record"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
        
        app.buttons["Cancel"].tap()
        
        app.buttons["Stop"].tap()
    }
    
    // 1.K
    // 10 Points
    func testPlayButton() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        //
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
        
        // Stopped -> Play -> Fast Forward -> Play
        
        app.buttons["Play"].tap()
        
        app.buttons["Fast Forward"].tap()
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        // Stopped -> Play -> Fast Rewind -> Play
        
        app.buttons["Play"].tap()
        
        app.buttons["Fast Rewind"].tap()
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        // Stopped -> Play -> Pause -> Play
        
        app.buttons["Play"].tap()
        
        app.buttons["Pause"].tap()
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        // Stopped -> Play -> Stop -> Play
        
        app.buttons["Play"].tap()
        
        app.buttons["Stop"].tap()
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
    }
    
    // 1.L
    // 5 Points
    func testPauseOnlyWorksWhenPlaying() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        //
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        app.buttons["Pause"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Paused")
    }
    
    // 1.M
    // 5 Points
    func testFastForwardOnlyWorksWhenPlaying() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        //
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        app.buttons["Fast Forward"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Fast Forwarding")
        
        app.buttons["Stop"].tap()
        
        app.buttons["Fast Forward"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
    }
    
    // 1.N
    // 5 Points
    func testFastRewindOnlyWorksWhenPlaying() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        //
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
        
        app.buttons["Play"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Playing")
        
        app.buttons["Fast Rewind"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Fast Rewinding")
        
        app.buttons["Stop"].tap()
        
        app.buttons["Fast Rewind"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
    }
    
    // 1.O
    // 10
    func testForceOperations() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        // Force Record
        // Stopped -> Play -> Record -> FORCE
        
        app.buttons["Play"].tap()
        
        app.buttons["Record"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
        
        app.buttons["Force"].tap()
        
        app.buttons["Ok"].waitForExistence(timeout: 1.0)
        app.buttons["Ok"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Recording")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
        
        // Force Record
        // Stopped -> Play -> Pause -> Record -> FORCE
        
        app.buttons["Play"].tap()
        app.buttons["Pause"].tap()
        
        app.buttons["Record"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
        
        app.buttons["Force"].tap()
        
        app.buttons["Ok"].waitForExistence(timeout: 1.0)
        app.buttons["Ok"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Recording")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
        
        // Force Record
        // Stopped -> Play -> Fast Forward -> Record -> FORCE
        
        app.buttons["Play"].tap()
        app.buttons["Fast Forward"].tap()
        
        app.buttons["Record"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
        
        app.buttons["Force"].tap()
    
        app.buttons["Ok"].waitForExistence(timeout: 1.0)
        app.buttons["Ok"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Recording")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
        
        // Force Record
        // Stopped -> Play -> Fast Rewind -> Record -> FORCE
        
        app.buttons["Play"].tap()
        app.buttons["Fast Rewind"].tap()
        
        app.buttons["Record"].tap()
        
        XCTAssertTrue(app.staticTexts["Invalid Operation"].exists)
        
        app.buttons["Force"].tap()
        
        app.buttons["Ok"].waitForExistence(timeout: 1.0)
        app.buttons["Ok"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Recording")
        
        app.buttons["Stop"].tap()
        
        XCTAssertEqual(app.staticTexts["DVR_State_Value"].label, "Stopped")
    }
    
    // 1.P
    // 5 Points
    func testSwitchToTVDismissesDVR() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.buttons["Switch to DVR"].exists)
        
        app.buttons["Switch to DVR"].tap()
        
        app.switches["DVR_Power_Switch"].tap()
        
        app.buttons["Switch to TV"].tap()
        
        XCTAssertTrue(app.staticTexts["My Remote Control"].exists)
    }
    
}

//
//  HW7UITests.swift
//  HW4UITests
//
//  Created by Rohan Panchal on 2/14/24.
//

import XCTest

final class HW7UITests: XCTestCase {

    // 1.A
    // 10 Points
    func testContainsTabView() {
        
        let app = XCUIApplication()
        app.launch()
        
        XCTAssertTrue(app.tabBars.count == 1)
        
        XCTAssertTrue(app.tabBars.firstMatch.exists)
        
        XCTAssertTrue(app.tabBars.firstMatch.buttons.count == 3)
        
        XCTAssertTrue(app.tabBars.firstMatch.buttons["Remote"].exists)
        XCTAssertTrue(app.tabBars.firstMatch.buttons["DVR"].exists)
        XCTAssertTrue(app.tabBars.firstMatch.buttons["Configuration"].exists)
    }
    
    // 1.B
    // 10 Points
    func testTabViewContainsAllThreeViews() {
        
        let app = XCUIApplication()
        app.launch()
        
        changeToRemote(app: app)
        
        XCTAssertTrue(app.staticTexts["My Remote Control"].exists)
        
        changeToDVR(app: app)
        
        XCTAssertTrue(app.staticTexts["DVR Remote Control"].exists)
        
        changeToConfiguration(app: app)
        
        XCTAssertTrue(app.staticTexts["Configure Favorite Channels"].exists)
    }
    
    // 1.C
    // 10 Points
    func testAllElementsExist() {
        
        let app = XCUIApplication()
        app.launch()
        
        changeToConfiguration(app: app)
        
        XCTAssertTrue(app.staticTexts["Configure Favorite Channels"].exists)
        
        XCTAssertTrue(app.staticTexts["Button"].exists)
        
        XCTAssertTrue(app.segmentedControls.firstMatch.exists)
        
        XCTAssertTrue(app.staticTexts["Label"].exists)
        
        XCTAssertTrue(app.textFields["Label_TextField_Value"].exists)
        
        XCTAssertTrue(app.staticTexts["Channel"].exists)
        
        XCTAssertTrue(app.staticTexts["Channel_Label_Value"].exists)
        XCTAssertTrue(app.steppers.firstMatch.exists)
        
        XCTAssertTrue(app.buttons["Cancel"].exists)
        XCTAssertTrue(app.buttons["Save"].exists)
    }
    
    // 1.D
    // 10 Points
    // Put in a label with 5 characters and make sure it fails.
    func testLabelValidation() {
        
        let app = XCUIApplication()
        app.launch()
        
        changeToConfiguration(app: app)
        
        app.textFields["Label_TextField_Value"].tap()
        app.textFields["Label_TextField_Value"].typeText("abcde")
        app.buttons["Save"].tap()
            
        XCTAssertTrue(app.alerts.firstMatch.waitForExistence(timeout: 1.0))
        
        XCTAssertEqual(app.alerts.firstMatch.staticTexts.firstMatch.label, 
                       "Invalid label length")
    }
    
    // 1.E
    // 10 Points
    func testStepperChangesLabel() {
        
        let app = XCUIApplication()
        app.launch()
        changeToConfiguration(app: app)
        
        var currentChannelValue = Int(app.staticTexts["Channel_Label_Value"].label)!
        
        let changedChannelValue = currentChannelValue + 4
        
        
        let steppersQuery = app.steppers
        steppersQuery.buttons["Increment"].tap()
        steppersQuery.buttons["Increment"].tap()
        steppersQuery.buttons["Increment"].tap()
        steppersQuery.buttons["Increment"].tap()
        
        
        currentChannelValue = Int(app.staticTexts["Channel_Label_Value"].label)!
        
        XCTAssertEqual(currentChannelValue, changedChannelValue)
    }
    
    // 1.F
    // 50 Points
    func testStandardFlow01() {
        
        let app = XCUIApplication()
        app.launch()
        changeToConfiguration(app: app)
        
        let steppersQuery = app.steppers
        steppersQuery.buttons["Increment"].tap()
        steppersQuery.buttons["Increment"].tap()
        steppersQuery.buttons["Increment"].tap()
        steppersQuery.buttons["Increment"].tap()
        
        app.textFields["Label_TextField_Value"].tap()
        app.textFields["Label_TextField_Value"].typeText("ROH\n")
        
        tapBackground(app: app)
        
        app.segmentedControls.buttons["2"].tap()

        app.buttons["Save"].tap()
        
        
        changeToRemote(app: app)
        
        app.switches["Power_Switch"].tap()
        
        let segmentedControlButtons = app.segmentedControls
            .matching(identifier: "Favorite_Channel_Segmented_Control")
            .buttons
            .allElementsBoundByIndex
        
        segmentedControlButtons[1].tap()
        
        XCTAssertEqual(segmentedControlButtons[1].label, "ROH")
        
        XCTAssertEqual(Int(app.staticTexts["Current_Channel_Value"].label)!, 5)
        
    }
    
}

extension HW7UITests {
    
    private func changeToRemote(app: XCUIApplication) {
        app.tabBars.firstMatch.buttons["Remote"].tap()
    }
    
    private func changeToDVR(app: XCUIApplication) {
        app.tabBars.firstMatch.buttons["DVR"].tap()
    }
    
    private func changeToConfiguration(app: XCUIApplication) {
        app.tabBars.firstMatch.buttons["Configuration"].tap()
    }
    
    private func tapBackground(app: XCUIApplication) {
        
        let label = app.staticTexts["Configure Favorite Channels"]
        let coordinate = label.coordinate(withNormalizedOffset: CGVectorMake(0.5, 1.2))
        coordinate.tap()
    }
}

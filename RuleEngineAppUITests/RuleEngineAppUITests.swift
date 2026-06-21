//
//  RuleEngineAppUITests.swift
//  RuleEngineAppUITests
//
//  Created by Sonjoy Borkakoty on 19/06/26.
//

import XCTest

final class RuleEngineAppUITests: XCTestCase {
    
    var app: XCUIApplication!
    
    override class var runsForEachTargetApplicationUIConfiguration: Bool {
        true
    }

    override func setUpWithError() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        
        app.launch()
    }

    @MainActor
    func testAppLaunch() throws {
        continueAfterFailure = false
        app = XCUIApplication()
        app.launch()
    }
    
    
    func testLoginScreenLaunch() {
        
        XCTAssertTrue(app.textFields["txtEmail"].exists)
        
        XCTAssertTrue(app.secureTextFields["txtPassword"].exists)
        
        XCTAssertTrue(app.buttons["btnLogin"].exists)
    }
    
    func testLoginWorkflow() {
        
        //forcefully logout to test signin workflow
        app.launchArguments.append("--uitesting")
        app.launchArguments.append("--logout")
        
        let txtEmail = app.textFields["txtEmail"]
        let txtPassword = app.secureTextFields["txtPassword"]
        
        txtEmail.tap()
        txtEmail.typeText("sbkakoty@gmail.com")
        
        txtPassword.tap()
        txtPassword.typeText("123456")
        
        app.buttons["btnLogin"].tap()
        
        XCTAssertTrue(app.tabBars.firstMatch.waitForExistence(timeout: 5))
    }
    
    func testCreateRuleWorkflow() {
        
        let navCreateRule = app.buttons["navCreateRule"]
        let txtName = app.textFields["txtRuleName"]
        let txtField = app.textFields["txtField"]
        let txtValue = app.textFields["txtValue"]
        let txtAction = app.textFields["txtAction"]
        let btnSave = app.buttons["btnSave"]
        
        navCreateRule.tap()
        
        txtName.tap()
        txtName.typeText("Expense Approval")
        
        txtField.tap()
        txtField.typeText("amount")
        
        txtValue.tap()
        txtValue.typeText("9000")
        
        txtAction.tap()
        txtAction.typeText("Require Manager Approval")
        
        btnSave.tap()
        
        XCTAssertTrue(
            app.staticTexts["Expense Approval"].waitForExistence(timeout: 5)
        )
    }
    
    func testExecuteRule() {
        
        let tabExecute = app.tabBars.buttons["Execute"]
        tabExecute.tap()
        
        let textEditorPayload = app.textViews["textEditorPayload"]
        textEditorPayload.tap()
        
        textEditorPayload.typeText(
            #"""
            {
              "amount": 7000
            }
            """#
        )
        
        app.buttons["btnExecute"].tap()
        
        app.scrollViews["scrollViewExecute"].tap()
        
        XCTAssertTrue(
            app.staticTexts["• Expense Approval"].waitForExistence(timeout: 15)
        )
    }
    
    func testExecutionHistory() {
        
        app.tabBars.buttons["History"].tap()
        
        XCTAssertTrue(app.navigationBars["Execution History"].exists)
    }
    
    func testLogoutWorkflow() {
        
        loginIfNeeded()
        
        app.tabBars.buttons["Settings"].tap()
        
        app.buttons["btnLogout"].tap()
        
        XCTAssertTrue(app.buttons["btnLogin"].waitForExistence(timeout: 5))
    }
    
    func loginIfNeeded() {

        if app.buttons["btnLogin"].exists {

            let txtEmail = app.textFields["txtEmail"]
            let txtPassword = app.secureTextFields["txtPassword"]

            txtEmail.tap()
            txtEmail.typeText("sbkakoty@gmail.com")
            
            txtPassword.tap()
            txtPassword.typeText("123456")

            app.buttons["btnLogin"].tap()

            XCTAssertTrue(app.tabBars.firstMatch.waitForExistence(timeout: 5))
        }
    }
}

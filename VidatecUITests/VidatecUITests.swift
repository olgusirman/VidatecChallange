//
//  VidatecUITests.swift
//  VidatecUITests
//
//  Created by Olgu SIRMAN on 09/01/2021.
//

import XCTest
import SnapshotTesting
import SwiftUI
//import VidatecServiceManager
//@testable import Vidatec


class VidatecUITests: XCTestCase {

    override func setUpWithError() throws {
        // Put setup code here. This method is called before the invocation of each test method in the class.

        // In UI tests it is usually best to stop immediately when a failure occurs.
        continueAfterFailure = false

        // In UI tests it’s important to set the initial state - such as interface orientation - required for your tests before they run. The setUp method is a good place to do this.
    }

    override func tearDownWithError() throws {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }

    func testExample() throws {
        // UI tests must launch the application that they test.
        let app = XCUIApplication()
        app.launch()

        // Use recording to get started writing UI tests.
        // Use XCTAssert and related functions to verify your tests produce the correct results.
    }
    
    func testSearchJan() throws {
        
        let app = XCUIApplication()
        app.launch()
        
        let elementsQuery = app.scrollViews.otherElements
        elementsQuery.searchFields["Search People"].tap()
        
        let jKey = app.keyboards.keys["J"]
        jKey.tap()
        
        let aKey = app.keyboards.keys["a"]
        aKey.tap()
        
        let nKey = app.keyboards.keys["n"]
        nKey.tap()
        elementsQuery.buttons["Jan  Thompson, Job Title"].tap()
        
    }
    

    func testPersonRowView() throws {

//        let mockPerson = Person.mockPeople.first!
//        let personRowView = PersonRow(person: mockPerson)
//        let personRowViewUpdatedWithReferenceFrame = personRowView.referenceFrame()
        //assertSnapshot(matching: personRowViewUpdatedWithReferenceFrame, as: .image(size: referenceSize))
        // Something wrong about types that framework didn't worked for me :/
    }
    
    func testPersonRowViewRightToLeft() throws {
        
//        let mockPerson = Person.mockPeople.first!
//        let personRowView = PersonRow(person: mockPerson)
//            .environment(\.layoutDirection, .rightToLeft)
//        let personRowViewUpdatedWithReferenceFrame = personRowView.referenceFrame()
//        assertSnapshot(matching: personRowViewUpdatedWithReferenceFrame, as: .image(size: referenceSize))
    }

    func testLaunchPerformance() throws {
        if #available(macOS 10.15, iOS 13.0, tvOS 13.0, *) {
            // This measures how long it takes to launch your application.
            measure(metrics: [XCTApplicationLaunchMetric()]) {
                XCUIApplication().launch()
            }
        }
    }
}

let referenceSize = CGSize(width: 375, height: 100)

extension SwiftUI.View {
    func referenceFrame() -> some View {
        self.frame(width: referenceSize.width, height: referenceSize.height)
    }
}

//
//  TapThemeManager2020Tests.swift
//  TapThemeManager2020Tests
//
//  Created by Kareem Ahmed on 3/10/20.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import XCTest
@testable import TapThemeManager2020

class TapThemeManager2020Tests: XCTestCase {

    // MARK:- Default functions
    override func setUp() {
        // Put setup code here. This method is called before the invocation of each test method in the class.
    }

    override func tearDown() {
        // Put teardown code here. This method is called after the invocation of each test method in the class.
    }
    
    // MARK:- Load JSON from file test
    func testLoadJsonFromFile() {
        guard let path = TapThemePath.themeJsonPath(fileName: "test-theme") else {
            XCTFail("TapThemeManager not able to load file 'test-theme.json'")
            return }
        
        let dectionaryResult = loadJsonFromPath(jsonPath: path)
        XCTAssertNotNil(dectionaryResult, "TapThemeManager not able to read json at: \(path)")
    }
    
    func testCustomView2BackgroundColorHex() {
        let correctBg = "#F49F05"
        
        guard let path = TapThemePath.themeJsonPath(fileName: "test-theme") else {
            XCTFail("TapThemeManager not able to load file 'test-theme.json'")
            return }
        
        guard let theme = loadJsonFromPath(jsonPath: path) else {
            XCTFail("TapThemeManager not able to load file 'test-theme.json'")
            return
        }
        
        guard let customView2 = theme["CustomView2"] as? [String: Any] else {
            XCTFail("not able to find key 'CustomView2'!")
            return
        }
        
        guard let backgroundColor = customView2["backgroundColor"] as? String else {
            XCTFail("not able to find key 'backgroundColor'!")
            return
        }
        
        guard let bgColor = try? UIColor(tap_hex: correctBg) else {
            XCTFail("bgColor not valid UIColor Type!")
            return
        }
        guard let TPbackgroundColor = try? UIColor(tap_hex: backgroundColor) else {
            XCTFail("TPbackgroundColor not valid UIColor Type!")
            return
        }
        
        XCTAssertEqual(bgColor, TPbackgroundColor, "CustomView2.backgroundColor is not matching the expected color!")
    }
    // MARK:- Helper functions
    func loadJsonFromPath(jsonPath: String) -> [String: Any]? {
        // Check if the file is correctly parsable
        guard
            let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)),
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
            let jsonDict = json as? [String: Any] else {
            print("TapThemeManager WARNING: Can't read json at: \(jsonPath)")
            return nil
        }
        return jsonDict
    }

    // MARK:- Performance test
//    func testPerformanceExample() {
//        // This is an example of a performance test case.
//        measure {
//            // Put the code you want to measure the time of here.
//        }
//    }

}

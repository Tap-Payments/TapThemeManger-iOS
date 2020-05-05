//
//  TapThemeManager.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import Foundation
import class UIKit.UIView
public let TapThemeUpdateNotification = "TapThemeUpdateNotification"

/// The brain class for managing the Tap Theme manager itself
@objc public final class TapThemeManager: NSObject {
    
    /// Defines the duration needed in transittioing between themes
    @objc public static var themeUpdateAnimationDuration = 0.3
    /// Defines the current theme object
    @objc public fileprivate(set) static var currentTheme: NSDictionary?
    /// Defines the index if the current theme
    @objc public fileprivate(set) static var currentThemeIndex: Int = 0
    /// Defines a global variable to state if the theme is already applied,hence the subviews doesn't need to reset the theme again
    @objc public var themeAlreadyApplied: Bool = false
    
    /*///// Defines the current selected theme location
     // public fileprivate(set) static var currentThemePath: TapThemePath?*/
    
}
/// An extenstion of methods that reads in the theme files and updates the theme
public extension TapThemeManager {
    
    /// This is the shared instance of the tap theme manager, this is what you  have to use to access the available methodsand variables that are shared accross the app
    @objc static let shared = TapThemeManager()
    
    /**
     - The method for setting a theme if the user provided a LIST of themes
     - Parameter atIndex: The index of the required theme
     */
    @objc class func setTapTheme(atIndex: Int) {
        currentThemeIndex = atIndex
        NotificationCenter.default.post(name: Notification.Name(rawValue: TapThemeUpdateNotification), object: nil)
    }
    
    
    /**
     - The method for setting a theme from a plist file
     - Parameter plistName: The name of the plist file that has the needed theme
     */
    
    @objc class func setTapTheme(plistName: String) {
        // Check if the file exists
        guard let plistPath = TapThemePath.themePlistPath(fileName: plistName) else {
            print("TapThemeManager WARNING: Can't find plist '\(plistName)'")
            return
        }
        // Check if the file is correctly parsable
        guard let plistDict = NSDictionary(contentsOfFile: plistPath) else {
            print("TapThemeManager WARNING: Can't read plist '\(plistName)'")
            return
        }
        // All good, now change the theme :)
        self.setTapTheme(themeDict: plistDict)
    }
    
    
    /**
     - The method for setting a theme from a JSON file
     - Parameter jsonName: The name of the JSON file that has the needed theme
     */
    @objc class func setTapTheme(jsonName: String) {
        // Check if the file exists
        guard let jsonPath = TapThemePath.themeJsonPath(fileName: jsonName) else {
            print("TapThemeManager WARNING: Can't find json '\(jsonName)'")
            return
        }
        // Check if the file is correctly parsable
        guard
            let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)),
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
            let jsonDict = json as? NSDictionary else {
                print("TapThemeManager WARNING: Can't read json '\(jsonName)' at: \(jsonPath)")
                return
        }
        // All good, now change the theme :)
        self.setTapTheme(themeDict: jsonDict)
    }
    
    /**
     - The method is responsible for actually changing the theme and informs the subviews that each needs to re design itselft
     - Parameter themeDict: The dictionary of the the theme we need to apply
     */
    @objc class func setTapTheme(themeDict: NSDictionary) {
        currentTheme = themeDict
        //currentThemePath = path
        // Inform all subscribers, Please reload yourself :)
        NotificationCenter.default.post(name: Notification.Name(rawValue: TapThemeUpdateNotification), object: nil)
    }
    
    
    
    /// This is the method that is used to apply the default Tap provided theme
    @objc class func setDefaultTapTheme() {
        // Check if the default theme is already applied from the super views
        if shared.themeAlreadyApplied { return }
         // Check if the caller passed a dark mode support then we check if need to apply it
        let themeFile:String = (UIView().traitCollection.userInterfaceStyle == .dark) ? "DefaultDarkTheme" : "DefaultLightTheme"
       
        // Check if the file exists // Based on the current display mode, we decide which default theme file we will use
        // Defensive code to make sure all is loaded correctly
        let bundle:Bundle = Bundle(for: TapThemeManager.self)
        guard let jsonPath = bundle.path(forResource: themeFile, ofType: "json") else {
            print("TapThemeManager WARNING: Can't find json 'DefaultTheme'")
            return
        }
        // Check if the file is correctly parsable
        guard
            let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)),
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
            let jsonDict = json as? NSDictionary else {
                print("TapThemeManager WARNING: Can't read json 'DefaultTheme' at: \(jsonPath)")
                return
        }
        // All good, now change the theme :)
        shared.themeAlreadyApplied = true
        self.setTapTheme(themeDict: jsonDict)
    }
    
}

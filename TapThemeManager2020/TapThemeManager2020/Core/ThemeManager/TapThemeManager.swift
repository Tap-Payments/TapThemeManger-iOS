//
//  TapThemeManager.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import Foundation

public let TapThemeUpdateNotification = "TapThemeUpdateNotification"

    /// The brain class for managing the Tap Theme manager itself
    @objc public final class TapThemeManager: NSObject {
    
    /// Defines the duration needed in transittioing between themes
    @objc public static var themeUpdateAnimationDuration = 0.3
    
    /// Defines the current theme object
    @objc public fileprivate(set) static var currentTheme: NSDictionary?
    /// Defines the index if the current theme
    @objc public fileprivate(set) static var currentThemeIndex: Int = 0
    /// Defines the current selected theme location
    public fileprivate(set) static var currentThemePath: TapThemePath?

}
/// An extenstion of methods that reads in the theme files and updates the theme
public extension TapThemeManager {
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
    - Parameter path:      The path for the required plist file
    */
    
    @objc class func setTapTheme(plistName: String, path: TapThemePath) {
       // Check if the file exists
        guard let plistPath = path.themePlistPath(fileName: plistName) else {
            print("TapThemeManager WARNING: Can't find plist '\(plistName)' at: \(path)")
            return
        }
        // Check if the file is correctly parsable
        guard let plistDict = NSDictionary(contentsOfFile: plistPath) else {
            print("TapThemeManager WARNING: Can't read plist '\(plistName)' at: \(plistPath)")
            return
        }
        // All good, now change the theme :)
        self.setTapTheme(themeDict: plistDict, path: path)
    }
    
    
    /**
    - The method for setting a theme from a JSON file
    - Parameter jsonName: The name of the JSON file that has the needed theme
    - Parameter path:      The path for the required JSON file
    */
    @objc class func setTapTheme(jsonName: String, path: TapThemePath) {
        // Check if the file exists
        guard let jsonPath = path.themeJsonPath(fileName: jsonName) else {
            print("TapThemeManager WARNING: Can't find json '\(jsonName)' at: \(path)")
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
        self.setTapTheme(themeDict: jsonDict, path: path)
    }
    
    /**
    - The method is responsible for actually changing the theme and informs the subviews that each needs to re design itselft
    - Parameter themeDict: The dictionary of the the theme we need to apply
    - Parameter path:      The path for the required theme file
    */
    @objc class func setTapTheme(themeDict: NSDictionary, path: TapThemePath) {
        currentTheme = themeDict
        currentThemePath = path
        // Inform all subscribers, Please reload yourself :)
        NotificationCenter.default.post(name: Notification.Name(rawValue: TapThemeUpdateNotification), object: nil)
    }
    
}

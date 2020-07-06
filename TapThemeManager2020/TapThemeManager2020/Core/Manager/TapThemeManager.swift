//
//  TapThemeManager.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import Foundation
import class UIKit.UIView
import enum UIKit.UIUserInterfaceStyle

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
    
    fileprivate static var lightModeTheme:NSDictionary?
    fileprivate static var darkModeTheme:NSDictionary?
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
    @objc class func setTapTheme(jsonName: String? = nil) {
        // Check if no file set
        guard let jsonName = jsonName else {
            self.loadJsonFromUrl { contentData in
                print("file path after downloading: \(contentData)")
                // Check if the file is correctly parsable
                let json = try? JSONSerialization.jsonObject(with: contentData, options: .fragmentsAllowed)
                let jsonDict = json as? NSDictionary
                print("loaded json: \(jsonDict)")
            }
            print("jsonName empty")
            return
        }
        // Check if the file exists
        guard let jsonDict = loadThemeDict(from: jsonName) else {
            print("TapThemeManager WARNING: Can't find json '\(jsonName)'")
            return
        }
       
        // All good, now change the theme :)
        self.setTapTheme(themeDict: jsonDict)
    }
    
    /**
     Converts a JSON file into a Theme Dictionary
     - Parameter jsonName: The name of the needed json file.
     - Parameter bundle:   The bundle that we will search for the json file in. Default is the main bundle
     - Returns: The theme dictionary converted from the given json file
     */
    internal class func loadThemeDict(from jsonName:String,in bundle:Bundle = Bundle.main) -> NSDictionary? {
        // Check if the file exists
        guard let jsonPath = TapThemePath.themeJsonPath(fileName: jsonName, in: bundle) else {
            print("TapThemeManager WARNING: Can't find json '\(jsonName)'")
            return nil
        }
        // Check if the file is correctly parsable
        guard
            let data = try? Data(contentsOf: URL(fileURLWithPath: jsonPath)),
            let json = try? JSONSerialization.jsonObject(with: data, options: .fragmentsAllowed),
            let jsonDict = json as? NSDictionary else {
                print("TapThemeManager WARNING: Can't read json '\(jsonName)' at: \(jsonPath)")
                return nil
        }
        return jsonDict
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
    
    /**
    - The method is responsible for setting the global theme for the whole app.
    - Parameter lightModeDictTheme: The dictionary of the the theme we need to apply in the Light display mode
    - Parameter darkModeDictTheme: The dictionary of the the theme we need to apply in the dark display mode
    */
    @objc class func setDefaultTapTheme(lightModeDictTheme:NSDictionary,darkModeDictTheme:NSDictionary) {
        self.lightModeTheme = lightModeDictTheme
        self.darkModeTheme = darkModeDictTheme
        applyThemeBasedOnDisplayMode()
    }
    
    /**
    - The method is responsible for setting the global theme for the whole app.
    - Parameter lightModeJSONTheme: The json file of the the theme we need to apply in the Light display mode
    - Parameter darkModeJSONTheme: The json file of the the theme we need to apply in the dark display mode
    - Parameter bundle:   The bundle that we will search for the json file in. Default is the main bundle
    */
    @objc class func setDefaultTapTheme(lightModeJSONTheme:String,darkModeJSONTheme:String,in bundle:Bundle = Bundle.main) {
        // Check if the file exists
        guard let lightJSONDict = loadThemeDict(from: lightModeJSONTheme, in: bundle),
              let darkJSONDict = loadThemeDict(from: darkModeJSONTheme, in: bundle) else {
                print("TapThemeManager WARNING: Can't find json files '\(lightModeJSONTheme)' and '\(darkModeJSONTheme)'")
                // As a fallback we set the default theme
                setDefaultTapTheme()
                return
        }
        
        self.lightModeTheme = lightJSONDict
        self.darkModeTheme = darkJSONDict
        applyThemeBasedOnDisplayMode()
    }
    
    /// This method is responsible for choosing which theme to apply based on the current display mode light or dark
    internal class func applyThemeBasedOnDisplayMode() {
        // Make sure all theme objects are given and set
        guard let lightJSONDict = self.lightModeTheme,
        let darkJSONDict = self.darkModeTheme else {
            // Fallback to use the default theme
           setDefaultTapTheme()
           return
        }
        
        // We decide which theme object to user based on the current userInterfaceStyle
        (UIView().traitCollection.userInterfaceStyle == .dark) ? self.setTapTheme(themeDict: darkJSONDict) : self.setTapTheme(themeDict: lightJSONDict)
    }
    
    /// This is the method that is used to apply the default Tap provided theme
    @objc class func setDefaultTapTheme() {
        let bundle:Bundle = Bundle(for: TapThemeManager.self)
        setDefaultTapTheme(lightModeJSONTheme:"DefaultLightTheme",darkModeJSONTheme:"DefaultDarkTheme",in: bundle)
    }
    
    
    /**
     Call this method when a change in userInterfaceStyle has been detected to apply the correct theme object accordingly
     - Parameter mode: The new value of the userInterfaceStyle
     */
    @objc class func changeThemeDisplay(for mode:UIUserInterfaceStyle) {
        // Check if we are not already applying the correct theme for theh new display mode, this will prevent duplication setting the same theme muultiple times when different views are active and firing this method
        if ( lightModeTheme == self.currentTheme && mode == .light ) ||
            ( darkModeTheme == self.currentTheme && mode == .dark ) { return }
        
        // Here, we need to update the theme
        applyThemeBasedOnDisplayMode()
    }
    
    // MARK: Load from URL
    internal class func loadJsonFromUrl(completion: ((Data) -> ())?) {
        let downloader = FileDownloader(fileUrl: "https://sdk-assets.b-cdn.net/theme/theme.json")
        downloader.completion = completion
        downloader.startDownloading()
    }
}

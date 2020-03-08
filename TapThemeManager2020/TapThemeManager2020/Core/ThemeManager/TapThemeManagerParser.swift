//
//  TapThemeManagerParser.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//
import UIKit


/// All the methods required to parse String values provided in the theme file into readable iOS values like UIColor, UIFont, etc.
@objc extension TapThemeManager {
    
    /**
    - The method for getting a certain value in the current theme dictrionary
    - Parameter keyPath: The key of the value needed
    - Returns: The value of the key, could be another object, String, Number, etc.
    */
    public class func value(for keyPath: String) -> Any? {
        return currentTheme?.value(forKeyPath: keyPath)
    }
    
    /**
    - The method for getting a STRING value from the current theme dictionary
    - Parameter keyPath: The key of the string needed
    - Returns: The STRING value of the key, and nil if doesn't exist
    */
    public class func stringValue(for keyPath: String) -> String? {
        guard let parsedString = currentTheme?.value(forKeyPath: keyPath) as? String else {
            print("TapThemeManager WARNING: Not found string key path: \(keyPath)")
            return nil
        }
        return parsedString
    }
    
    
    
}

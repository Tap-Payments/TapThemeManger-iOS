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


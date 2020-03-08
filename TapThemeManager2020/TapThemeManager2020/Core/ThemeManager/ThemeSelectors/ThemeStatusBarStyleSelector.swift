//
//  ThemeStatusBarStyleSelecttor.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import UIKit

@objc public final class ThemeStatusBarStyleSelector: ThemeSelector {
    
    var animated = true
    
    public convenience init(keyPath: String) {
        self.init(value: { ThemeStatusBarStyleSelector.statusBarStyle(from: TapThemeManager.stringValue(for: keyPath) ?? "") })
    }
    
    public convenience init(keyPath: String, map: @escaping (Any?) -> UIStatusBarStyle?) {
        self.init(value: { map(TapThemeManager.value(for: keyPath)) })
    }
    
    public convenience init(styles: UIStatusBarStyle...) {
        self.init(value: { TapThemeManager.element(for: styles) })
    }
    
    public required convenience init(arrayLiteral elements: UIStatusBarStyle...) {
        self.init(value: { TapThemeManager.element(for: elements) })
    }
    
    public required convenience init(stringLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(unicodeScalarLiteral value: String) {
        self.init(keyPath: value)
    }
    
    public required convenience init(extendedGraphemeClusterLiteral value: String) {
        self.init(keyPath: value)
    }
    
    class func statusBarStyle(from stringStyle: String) -> UIStatusBarStyle {
        switch stringStyle.lowercased() {
        case "default"      : return .default
        case "lightcontent" : return .lightContent
        case "darkcontent"  : if #available(iOS 13.0, *) { return .darkContent } else { return .default }
        default: return .default
        }
    }
    
}

public extension ThemeStatusBarStyleSelector {
    
    class func selectorWithKeyPath(_ keyPath: String, map: @escaping (Any?) -> UIStatusBarStyle?) -> ThemeStatusBarStyleSelector {
        return ThemeStatusBarStyleSelector(keyPath: keyPath, map: map)
    }
    
    class func selectorWithStyles(_ styles: [UIStatusBarStyle]) -> ThemeStatusBarStyleSelector {
        return ThemeStatusBarStyleSelector(value: { TapThemeManager.element(for: styles) })
    }
    
}

// MARK:- Objective C interface
@objc public extension ThemeStatusBarStyleSelector {
    
    class func selectorWithKeyPath(_ keyPath: String) -> ThemeStatusBarStyleSelector {
        return ThemeStatusBarStyleSelector(keyPath: keyPath)
    }
    
    class func selectorWithStringStyles(_ styles: [String]) -> ThemeStatusBarStyleSelector {
        return ThemeStatusBarStyleSelector(value: { TapThemeManager.element(for: styles.map(statusBarStyle(from:))) })
    }
    
}

extension ThemeStatusBarStyleSelector: ExpressibleByArrayLiteral {}
extension ThemeStatusBarStyleSelector: ExpressibleByStringLiteral {}

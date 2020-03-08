//
//  TapThemePath.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import Foundation

/// The enum to decide if we are loading the theme from JSON, PLIST or online
public enum TapThemePath {
    
    /// Loads from the main bundle
    case mainBundle
    /// Loads from the Foundation url
    case sandbox(Foundation.URL)
    
    public var URL: Foundation.URL? {
        switch self {
        case .mainBundle        : return nil
        case .sandbox(let path) : return path
        }
    }
    
    public func plistPath(name: String) -> String? {
        return filePath(fileName: name, ofType: "plist")
    }
    
    public func jsonPath(fileName: String) -> String? {
        return filePath(fileName: fileName, ofType: "json")
    }
    
    private func filePath(fileName: String, ofType type: String) -> String? {
        switch self {
        case .mainBundle:
            return Bundle.main.path(forResource: fileName, ofType: type)
        case .sandbox(let path):
            let name = fileName.hasSuffix(".\(type)") ? fileName : "\(fileName).\(type)"
            let url = path.appendingPathComponent(name)
            return url.path
        }
    }
}

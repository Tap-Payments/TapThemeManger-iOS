//
//  SelectorEnum.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 09/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

/// Typealiases for the performed selectors for easier and unified access
internal enum SelectorEnum : String
{
    case alpha = "setAlpha:"
    case backgroundColor = "setBackgroundColor:"
    case tintColor = "setTintColor:"
    
    
    
    internal func selectorName() -> String
    {
        return self.rawValue
    }
}

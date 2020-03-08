//
//  UIHexColor.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import UIKit

/// Defines set of init methods to provide a UIColor from different values of provided #RGBA hex values. #RGB, #RGBA, #RRGGBB, #RRGGBBAA
@objc extension UIColor {
    
    /**
     #RGB input --> #RRGGBBAA output.
     
     - parameter hex3: #RGB hexadecimal value.
     - parameter alpha: 0.0 - 1.0. The default is 1.0.
     */
    public convenience init(hex3: UInt16, alpha: CGFloat = 1) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex3 & 0xF00) >> 8) / divisor
        let green   = CGFloat((hex3 & 0x0F0) >> 4) / divisor
        let blue    = CGFloat( hex3 & 0x00F      ) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
    /**
     #RGBA input --> #RRGGBBAA output.
     
     - parameter hex4: #RGBA hexadecimal value.
     */
    public convenience init(hex4: UInt16) {
        let divisor = CGFloat(15)
        let red     = CGFloat((hex4 & 0xF000) >> 12) / divisor
        let green   = CGFloat((hex4 & 0x0F00) >>  8) / divisor
        let blue    = CGFloat((hex4 & 0x00F0) >>  4) / divisor
        let alpha   = CGFloat( hex4 & 0x000F       ) / divisor

        self.init(red: red, green: green, blue: blue, alpha: alpha)
    }
    
}

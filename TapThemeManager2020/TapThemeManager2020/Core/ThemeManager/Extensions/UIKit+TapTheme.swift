//
//  UIKit+TapTheme.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 09/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import class UIKit.UIView
/// This class provides extensions needed to SubViews to apply different types of theming using a nice shorthanded way. For example, instead of UIView.performSelector("setAlpha:",0) UIView.tap_alpha(0)



// MARK:- UIView

@objc public extension UIView
{
    var tap_theme_alpha: ThemeCGFloatSelector? {
        get { return self.themeSelector(for: SelectorEnum.alpha.selectorName()) as? ThemeCGFloatSelector }
        set { self.setThemeSelector(with:  SelectorEnum.alpha.selectorName(), for: newValue)}
    }
    var tap_theme_backgroundColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for: SelectorEnum.backgroundColor.selectorName()) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with: SelectorEnum.backgroundColor.selectorName(), for: newValue) }
    }
    var tap_theme_tintColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for: SelectorEnum.tintColor.selectorName()) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with: SelectorEnum.tintColor.selectorName(), for: newValue) }
    }
}




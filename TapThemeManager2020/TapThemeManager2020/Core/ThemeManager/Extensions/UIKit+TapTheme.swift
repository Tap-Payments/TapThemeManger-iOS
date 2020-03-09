//
//  UIKit+TapTheme.swift
//  TapThemeManager2020
//
//  Created by Osama Rabie on 09/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import class UIKit.UIView
import class UIKit.UIApplication
import class UIKit.UIBarItem
import class UIKit.UIControl
import class UIKit.UIBarButtonItem
import class UIKit.UILabel
/// This class provides extensions needed to SubViews to apply different types of theming using a nice shorthanded way. For example, instead of UIView.performSelector("setAlpha:",0) UIView.tap_alpha(0)

// MARK:- UIView

@objc public extension UIView
{
    var tap_theme_alpha: ThemeCGFloatSelector? {
        get { return self.themeSelector(for: SelectorsConstants.setAlphaSelector) as? ThemeCGFloatSelector }
        set { self.setThemeSelector(with: SelectorsConstants.setAlphaSelector, for: newValue)}
    }
    var tap_theme_backgroundColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for: SelectorsConstants.setBackgroundColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with: SelectorsConstants.setBackgroundColorSelector, for: newValue) }
    }
    var tap_theme_tintColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for: SelectorsConstants.setTintColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setTintColorSelector, for: newValue) }
    }
}

// MARK:- UIApplication
@objc public extension UIApplication
{
    func tap_theme_setStatusBarStyle(themeSelector: ThemeStatusBarStyleSelector, animated: Bool) {
        themeSelector.animated = animated
        self.setThemeSelector(with: SelectorsConstants.setStatusBarStyleAnimatedSelector, for: themeSelector)
    }
}

// MARK:- UIBarItem
@objc public extension UIBarItem
{
    var tap_theme_image: ThemeImageSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setImageSelector) as? ThemeImageSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setImageSelector, for: newValue) }
    }
    func tap_theme_setTitleTextAttributes(_ picker: ThemeStringAttributesSelector?, forState state: UIControl.State) {
        let stateSelector = self.stateSelector(with:  SelectorsConstants.setTitleTextAttributesForStateSelector, for: picker, to: state)
        self.setThemeSelector(with:  SelectorsConstants.setTitleTextAttributesForStateSelector, for: stateSelector)
    }
}


// MARK:- UIBarButtonItem
@objc public extension UIBarButtonItem
{
    var tap_theme_tintColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setTintColorSelector) as? ThemeUIColorSelector }
        set {self.setThemeSelector(with:  SelectorsConstants.setTintColorSelector, for: newValue) }
    }
}

// MARK:- UILabel
@objc public extension UILabel
{
    var tap_theme_font: ThemeFontSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setFontSelector) as? ThemeFontSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setFontSelector, for: newValue) }
    }
    var tap_theme_textColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setTextColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setTextColorSelector, for: newValue) }
    }
    var tap_theme_highlightedTextColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setHighlightedTextColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setHighlightedTextColorSelector, for: newValue) }
    }
    var tap_theme_shadowColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setShadowColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setShadowColorSelector, for: newValue) }
    }
    var tap_theme_textAttributes: ThemeStringAttributesSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.tap_setTextAttributesSelector) as? ThemeStringAttributesSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.tap_setTextAttributesSelector, for: newValue) }
    }
}







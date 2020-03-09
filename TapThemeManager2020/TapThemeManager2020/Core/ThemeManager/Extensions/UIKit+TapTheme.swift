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
import class UIKit.UINavigationBar
import class UIKit.UITabBar
import class UIKit.UITableView
import class UIKit.UITabBarItem
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


// MARK:- UINavigationBar
@objc public extension UINavigationBar
{
    var tap_theme_barStyle: ThemeBarStyleSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setBarStyleSelector) as? ThemeBarStyleSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setBarStyleSelector, for: newValue) }
    }
    
    var tap_theme_barTintColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setBarTintColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setBarTintColorSelector, for: newValue) }
    }
    var tap_theme_titleTextAttributes: ThemeStringAttributesSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setTitleTextAttributesSelector) as? ThemeStringAttributesSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setTitleTextAttributesSelector, for: newValue) }
    }
    var tap_theme_largeTitleTextAttributes: ThemeStringAttributesSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setLargeTitleTextAttributesSelector) as? ThemeStringAttributesSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setLargeTitleTextAttributesSelector, for: newValue) }
    }
    @available(iOS 13.0, *)
    var tap_theme_standardAppearance: ThemeNavigationBarAppearanceSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setStandardAppearanceSelector) as? ThemeNavigationBarAppearanceSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setStandardAppearanceSelector, for: newValue) }
    }
    @available(iOS 13.0, *)
    var tap_theme_compactAppearance: ThemeNavigationBarAppearanceSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setCompactAppearanceSelector) as? ThemeNavigationBarAppearanceSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setCompactAppearanceSelector, for: newValue) }
    }
    @available(iOS 13.0, *)
    var tap_theme_scrollEdgeAppearance: ThemeNavigationBarAppearanceSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setScrollEdgeAppearanceSelector) as? ThemeNavigationBarAppearanceSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setScrollEdgeAppearanceSelector, for: newValue) }
    }
}


// MARK:- UITabBar
@objc public extension UITabBar
{
    var tap_theme_barStyle: ThemeBarStyleSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setBarStyleSelector) as? ThemeBarStyleSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setBarStyleSelector, for: newValue) }
    }

    var tap_theme_unselectedItemTintColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setUnselectedItemTintColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setUnselectedItemTintColorSelector, for: newValue) }
    }
    var tap_theme_barTintColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setBarTintColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setBarTintColorSelector, for: newValue) }
    }
}

// MARK:- UITabBarItem
@objc public extension UITabBarItem
{
    var tap_theme_selectedImage: ThemeImageSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setSelectedImageSelector) as? ThemeImageSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setSelectedImageSelector, for: newValue) }
    }
}


// MARK:- UITableView
@objc public extension UITableView
{
    var tap_theme_separatorColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setSeparatorColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setSeparatorColorSelector, for: newValue) }
    }
    var tap_theme_sectionIndexColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setSectionIndexColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setSectionIndexColorSelector, for: newValue) }
    }
    var tap_theme_sectionIndexBackgroundColor: ThemeUIColorSelector? {
        get { return self.themeSelector(for:  SelectorsConstants.setSectionIndexBackgroundColorSelector) as? ThemeUIColorSelector }
        set { self.setThemeSelector(with:  SelectorsConstants.setSectionIndexBackgroundColorSelector, for: newValue) }
    }
}

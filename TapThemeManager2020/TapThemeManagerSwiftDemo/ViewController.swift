//
//  ViewController.swift
//  TapThemeManagerSwiftDemo
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import UIKit
import TapThemeManager2020
/// This a  template class that showcases applying theme and changing themes
class ViewController: UIViewController {

    // MARK:- Outlets
    @IBOutlet weak var customView1: UIView!
    @IBOutlet weak var customLabel1: UILabel!
    
    @IBOutlet weak var customView2: UIView!
    @IBOutlet weak var customLabel2: UILabel!
    @IBOutlet weak var customSwitch2: UISwitch!
    
    @IBOutlet weak var customView3: UIView!
    @IBOutlet weak var customImage3: UIImageView!
    @IBOutlet weak var customLabel3: UILabel!
    
    @IBOutlet weak var NextThemeButton: UIButton!
    
    
    // MARK:- Variables
    /// The list of themes you want to provide
    let jsonFiles = ["Theme1","Theme2"]
    
    /// The current chosen theme index
    lazy var currentThemeIndex = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view.
    }

    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        matchThemeAttributes()
        applyTheme()
    }
    
    /// Apply  the theme values from the theme file to the matching outlets
    private func applyTheme()
    {
        TapThemeManager.setTapTheme(jsonName: jsonFiles[(currentThemeIndex%jsonFiles.count)])
        self.setNeedsStatusBarAppearanceUpdate()
    }
    
    private func matchThemeAttributes()
    {
        NextThemeButton.layer.cornerRadius = NextThemeButton.frame.width/2
        customView1.tap_theme_backgroundColor = "CustomView1.backgroundColor"
        
        
        //customView1.tap_the
        customView1.layer.tap_theme_borderColor = "CustomView1.borderColor"
        customView1.layer.tap_theme_borderWidth = "CustomView1.borderWidth"
        customView1.layer.tap_theme_cornerRadious = "CustomView1.cornerRadius"
        
        customLabel1.tap_theme_font = "CustomLabel1.font"
        customLabel1.tap_theme_textColor = "CustomLabel1.textColor"
        
        
        customView2.tap_theme_backgroundColor = "CustomView2.backgroundColor"
        customView2.layer.tap_theme_borderColor = "CustomView2.borderColor"
        customView2.layer.tap_theme_borderWidth = "CustomView2.borderWidth"
        customView2.layer.tap_theme_cornerRadious = "CustomView2.cornerRadius"
        customLabel2.tap_theme_font = "CustomLabel2.font"
        customLabel2.tap_theme_textColor = "CustomLabel2.textColor"
        customSwitch2.tap_theme_onTintColor = "CustomSwitch2.onTint"
        customSwitch2.tap_theme_thumbTintColor = "CustomSwitch2.thumbTint"
        
        customView3.tap_theme_backgroundColor = "CustomView3.backgroundColor"
        customLabel3.tap_theme_font = "CustomLabel3.font"
        customLabel3.tap_theme_textColor = "CustomLabel3.textColor"
        customImage3.tap_theme_image = "CustomUIImageView3.image"
        
        
        NextThemeButton.tap_theme_backgroundColor = "NextThemeButton.buttonBackgroundColor"
        NextThemeButton.tap_theme_setTitleColor(selector: "NextThemeButton.buttonTitleColorNormal", forState: .normal)
        NextThemeButton.tap_theme_setTitleColor(selector: "NextThemeButton.buttonTitleColorHighlighted", forState: .highlighted)
    }
    
    
    override  var preferredStatusBarStyle: UIStatusBarStyle {
        return TapThemeManager.themeStatusBarStyle(for: "Global.UIStatusBarStyle")
    }
    
    
    
    @IBAction func nextThemeClicked(_ sender: Any) {
        currentThemeIndex += 1
        applyTheme()
    }
    
}


//
//  MyNavigationController.swift
//  TapThemeManagerSwiftDemo
//
//  Created by Osama Rabie on 09/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

import UIKit
import TapThemeManager2020

class MyNavigationController: UINavigationController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.navigationBar.tap_theme_titleTextAttributes = ThemeStringAttributesSelector(keyPath: "Global.NavigationTitle", map: { (entry) -> [NSAttributedString.Key : Any]? in
            
            return [NSAttributedString.Key.foregroundColor:TapThemeManager.colorValue(for: "Global.NavigationTitle.NavigationTitleColor")!,
                    NSAttributedString.Key.font:TapThemeManager.fontValue(for: "Global.NavigationTitle.Font")!]
        })
        self.navigationBar.tap_theme_barTintColor = "Global.NavigationTint"
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}

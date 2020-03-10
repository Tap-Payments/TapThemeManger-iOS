//
//  MyNavigatioController.m
//  TapThemeManagerObjCDemo
//
//  Created by Osama Rabie on 10/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

#import "MyNavigatioController.h"
@import TapThemeManager2020;

@interface MyNavigatioController ()

@end

@implementation MyNavigatioController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.navigationBar.tap_theme_barTintColor = [ThemeUIColorSelector selectorWithKeyPath:@"Global.NavigationTint"];
    
    self.navigationBar.tap_theme_titleTextAttributes = [ThemeStringAttributesSelector selectorWithKeyPath:@"Global.NavigationTitle" map:^NSDictionary<NSAttributedStringKey,id> * _Nullable(id entry) {
        
        NSMutableDictionary *attributesDictionary = [NSMutableDictionary dictionary];
             
        [attributesDictionary setObject:[TapThemeManager fontValueFor:@"Global.NavigationTitle.Font"] forKey:NSFontAttributeName];
        [attributesDictionary setObject:[TapThemeManager colorValueFor:@"Global.NavigationTitle.NavigationTitleColor"] forKey:NSForegroundColorAttributeName];
        return attributesDictionary;
    }];
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

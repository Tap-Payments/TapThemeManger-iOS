//
//  ViewController.m
//  TapThemeManagerObjCDemo
//
//  Created by Osama Rabie on 08/03/2020.
//  Copyright © 2020 Osama Rabie. All rights reserved.
//

#import "ViewController.h"
@import TapThemeManager2020;
#import <TapThemeManager2020/TapThemeManager2020.h>

@interface ViewController ()
@property (weak, nonatomic) IBOutlet UIView *CustomView1;
@property (weak, nonatomic) IBOutlet UIView *customView2;
@property (weak, nonatomic) IBOutlet UIView *customView3;
@property (weak, nonatomic) IBOutlet UILabel *customLabel1;
@property (weak, nonatomic) IBOutlet UILabel *customLabel2;
@property (weak, nonatomic) IBOutlet UILabel *customLabel3;
@property (weak, nonatomic) IBOutlet UIImageView *customImage3;
@property (weak, nonatomic) IBOutlet UISwitch *customSwitch2;
@property (weak, nonatomic) IBOutlet UIButton *NextThemeButton;
@end

@implementation ViewController
{
    NSArray* themes;
    int currentThemeIndex;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    themes = @[@"Theme1",@"Theme2"];
    currentThemeIndex = 0;
}

-(void)viewWillAppear:(BOOL)animated
{
    [super viewWillAppear:animated];
    _NextThemeButton.layer.cornerRadius = _NextThemeButton.frame.size.width/2;
    [self matchThemeAttributes];
}


-(void)applyTheme
{
    [TapThemeManager setTapThemeWithJsonName:[themes objectAtIndex:(currentThemeIndex%themes.count)]];
}

-(void)matchThemeAttributes
{
    _CustomView1.tap_theme_backgroundColor = [ThemeUIColorSelector selectorWithKeyPath:@"CustomView1.backgroundColor"];
    _CustomView1.layer.tap_theme_borderColor = [ThemeCgColorSelector selectorWithKeyPath:@"CustomView1.borderColor"];
    _CustomView1.layer.tap_theme_borderWidth = [ThemeCGFloatSelector selectorWithKeyPath:@"CustomView1.borderWidth"];
    _CustomView1.layer.tap_theme_cornerRadious = [ThemeCGFloatSelector selectorWithKeyPath:@"CustomView1.cornerRadius"];
    _customLabel1.tap_theme_font = [ThemeFontSelector selectorWithFonts:@[[TapThemeManager fontValueFor:@"CustomLabel1.font"]]];
    _customLabel1.tap_theme_textColor = [ThemeUIColorSelector selectorWithKeyPath:@"CustomLabel1.textColor"];
    
    
    _customView2.tap_theme_backgroundColor = [ThemeUIColorSelector selectorWithKeyPath:@"CustomView2.backgroundColor"];
    _customView2.layer.tap_theme_borderColor = [ThemeCgColorSelector selectorWithKeyPath:@"CustomView2.borderColor"];
    _customView2.layer.tap_theme_borderWidth = [ThemeCGFloatSelector selectorWithKeyPath:@"CustomView2.borderWidth"];
    _customView2.layer.tap_theme_cornerRadious = [ThemeCGFloatSelector selectorWithKeyPath:@"CustomView2.cornerRadius"];
    _customLabel2.tap_theme_font = [ThemeFontSelector selectorWithFonts:@[[TapThemeManager fontValueFor:@"CustomLabel2.font"]]];
    _customLabel2.tap_theme_textColor = [ThemeUIColorSelector selectorWithKeyPath:@"CustomLabel2.textColor"];
    _customSwitch2.tap_theme_onTintColor = [ThemeUIColorSelector selectorWithKeyPath:@"CustomSwitch2.onTint"];
    _customSwitch2.tap_theme_thumbTintColor = [ThemeUIColorSelector selectorWithKeyPath:@"CustomSwitch2.thumbTint"];
    
    
    _customView3.tap_theme_backgroundColor = [ThemeUIColorSelector selectorWithKeyPath:@"CustomView3.backgroundColor"];
    _customLabel3.tap_theme_font = [ThemeFontSelector selectorWithFonts:@[[TapThemeManager fontValueFor:@"CustomLabel2.font"]]];
    _customLabel3.tap_theme_textColor = [ThemeUIColorSelector selectorWithKeyPath:@"CustomLabel2.textColor"];
    _customImage3.tap_theme_image = [ThemeImageSelector selectorWithKeyPath:@"CustomUIImageView3.image"];
    
    
    _NextThemeButton.tap_theme_backgroundColor = [ThemeUIColorSelector selectorWithKeyPath:@"NextThemeButton.buttonBackgroundColor"];
    [_NextThemeButton tap_theme_setTitleColorWithSelector:[ThemeUIColorSelector selectorWithKeyPath:@"NextThemeButton.buttonTitleColorNormal"] forState:UIControlStateNormal];
    [_NextThemeButton tap_theme_setTitleColorWithSelector:[ThemeUIColorSelector selectorWithKeyPath:@"NextThemeButton.buttonTitleColorHighlighted"] forState:UIControlStateHighlighted];
}



- (IBAction)nextThemeClicked:(id)sender {
    currentThemeIndex++;
    [self applyTheme];
}

@end

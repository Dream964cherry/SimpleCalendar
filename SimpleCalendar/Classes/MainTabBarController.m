//
//  MainTabBarController.m
//  SimpleCalendar
//
//  Created by wmh on 16/8/11.
//  Copyright © 2016年 qingyun. All rights reserved.
//
#define QLColorWithRGB(redValue, greenValue, blueValue) ([UIColor colorWithRed:((redValue)/255.0) green:((greenValue)/255.0) blue:((blueValue)/255.0) alpha:1])
#define QLColorRandom QLColorWithRGB(arc4random_uniform(256), arc4random_uniform(256), arc4random_uniform(256))
#define QLColorFromHex(rgbValue) [UIColor colorWithRed:((float)((rgbValue & 0xFF0000) >> 16))/255.0 green:((float)((rgbValue & 0xFF00) >> 8))/255.0 blue:((float)(rgbValue & 0xFF))/255.0 alpha:1.0]

#import "MainTabBarController.h"
#import "mainCalendarViewController.h"
#import "JouneyViewController.h"
#import "MainNavigationController.h"

@interface MainTabBarController ()

@end

@implementation MainTabBarController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self shouldAutorotate];
}

- (void)loadDefaultSetting
{
    mainCalendarViewController *calendarVC = [[mainCalendarViewController alloc]init];
    [self addViewController:calendarVC ImageName:@"Calendar" title:@"日历"];
    
    JouneyViewController *jouneyVC = [[JouneyViewController alloc]init];
    [self addViewController:jouneyVC ImageName:@"Jouney" title:@"行程"];
    
}
- (void)addViewController:(UIViewController *)viewController ImageName:(NSString *)strMainTabBarIconsName title:(NSString *)strMainTitle
{
    viewController.view.backgroundColor = [UIColor whiteColor];
    viewController.tabBarItem.image = [UIImage imageNamed:strMainTabBarIconsName];
    viewController.title = strMainTitle;
    viewController.tabBarItem.titlePositionAdjustment = UIOffsetMake(0, -3);
    MainNavigationController *mainNav = [[MainNavigationController alloc]initWithRootViewController:viewController];
    [self addChildViewController:mainNav];
}
@end

//
//  AddEventViewController.m
//  FreeCalendar
//
//  Created by wmh on 16/7/21.
//  Copyright © 2016年 qingyun. All rights reserved.
//
#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height

#define IconWidth 40
#define IconHeight 50
#define IconLine 5
#define IconIntervalX (screenWidth-IconWidth * IconLine)/6
#define IconIntervalY 20


#import "AddEventViewController.h"
#import "EventIcon.h"
#import "EventDescriptionsViewController.h"
#import "Masonry.h"




@interface AddEventViewController ()
@property (nonatomic,copy) NSArray *iconArray;

@end

@implementation AddEventViewController
- (NSArray *)iconArray{
    if (!_iconArray) {
        _iconArray = [NSArray arrayWithContentsOfFile:[[NSBundle mainBundle] pathForResource:@"EventNameList" ofType:@"plist"]];
      }
    return _iconArray;
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadIconView];
    [self loadDefaultSetting];
    self.view.backgroundColor =[UIColor whiteColor];
    
}
- (void)loadIconView{
//    CGFloat viewY = 64;
//    CGFloat viewWidth = self.view.frame.size.width;
//    CGFloat viewHeight = 160;
    UIView *ICView = [[UIView alloc]init];
        //View.frame = CGRectMake(0, viewY, viewWidth, viewHeight);
    
    [self.view addSubview:ICView];
    [ICView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(self.view).offset(64);
        make.height.equalTo(@(160));
        
    }];

    for(NSInteger index = 0; index < 10; index ++) {
        CGFloat iconViewX = IconIntervalX + (index%IconLine) * (IconWidth + IconIntervalX);
        CGFloat iconViewY = IconIntervalY + (index / IconLine) * (IconHeight + IconIntervalY);
        EventIcon *iconView = [[EventIcon alloc]initWithFrame:CGRectMake(iconViewX, iconViewY, IconWidth, IconHeight) andDictionary:self.iconArray[index]];
        iconView.eventView = ^{
            EventDescriptionsViewController *eventDescriptionVC = [EventDescriptionsViewController new];
            eventDescriptionVC.dict = self.iconArray[index];
            eventDescriptionVC.type = EditTypeAdd;
            [self.navigationController pushViewController:eventDescriptionVC animated:YES];
        };
        [ICView addSubview:iconView];
    }
    
    UILabel *explainLab = [UILabel new];
    explainLab.textAlignment = NSTextAlignmentCenter;
    [explainLab setText:@"点击以上的图标进入编辑事件"];
    [explainLab setTextColor:[UIColor grayColor]];
    explainLab.alpha = 0.3;
    [self.view addSubview:explainLab];
    [explainLab mas_makeConstraints:^(MASConstraintMaker *make) {
        make.leading.trailing.equalTo(self.view);
        make.top.equalTo(ICView.mas_bottom).offset(20);
        make.height.equalTo(@(44));
    }];
}

- (void)loadDefaultSetting{
}
- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    
    
}

@end

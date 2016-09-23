//
//  CJMonthDayViewController.h
//  CJCalendar
//
//  Created by chjsun on 16/5/24.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class MonthDayViewController;
@protocol MonthAndDayControllerDelegate <NSObject>

@optional
-(void) monthAndDayController:(MonthDayViewController *)controller didSelectIndexPath:(NSIndexPath *)indexPath GregoiainCalendar:(NSString *)gregoiainCalendar chineseCalendar:(NSString *)chineseCalendar;

@end

@interface MonthDayViewController : UICollectionViewController

/** 选中状态的color */
@property (nonatomic, strong) UIColor *selectColor;

-(instancetype)initWithFrame:(CGRect)frame;

/** 代理 */
@property (nonatomic, assign) id<MonthAndDayControllerDelegate> delegate;

//根据时间更新collection
-(void)refreshControlWithYear:(NSString *)year month:(NSString *)month day:(NSString *)day;

@end

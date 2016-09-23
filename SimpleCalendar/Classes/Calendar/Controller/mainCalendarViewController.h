//
//  CJMainViewController.h
//  CJCalendar
//
//  Created by chjsun on 16/5/23.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class mainCalendarViewController;

@protocol CalendarViewControllerDelegate <NSObject>

@optional
-(void) CalendarViewController:(mainCalendarViewController *)controller didSelectActionYear:(NSString *)year month:(NSString *)month day:(NSString *)day;

@end

@interface mainCalendarViewController : UIViewController

/** 直接指定时间 */
@property (nonatomic, strong) NSDate *Date;

/** 代理 */
@property (nonatomic, assign) id<CalendarViewControllerDelegate> delegate;

// method
/** 传入年、月、日. 设置时间 */
-(void) setYear:(NSString *)year month:(NSString *)month day:(NSString *)day;


@end

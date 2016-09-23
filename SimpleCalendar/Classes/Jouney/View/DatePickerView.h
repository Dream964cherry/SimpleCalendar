//
//  DatePickerView.h
//  FreeCalendar
//
//  Created by wmh on 16/8/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@protocol DatePickerViewDelegate <NSObject>

@required
//当时间改变时触发
- (void)changeTime:(NSDate *)date;
//确定时间
- (void)determineTime:(NSDate *)date;

@end

@interface DatePickerView : UIView
//初始化方法
- (instancetype)initWithFrame:(CGRect)frame type:(UIDatePickerMode)type;
//设置初始时间
- (void)setNowTime:(NSString *)dateStr;
// NSDate --> NSString
- (NSString *)stringFromDate:(NSDate *)date;
// NSString --> NSDate
- (NSDate *)dateFromString:(NSString *)dateString;

@property (assign,nonatomic)id<DatePickerViewDelegate>delegate;
@end

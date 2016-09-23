//
//  EventIcon.h
//  FreeCalendar
//
//  Created by wmh on 16/8/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface EventIcon : UIView

@property (nonatomic,copy) void (^eventView)();

- (instancetype)initWithFrame:(CGRect)frame andDictionary:(NSDictionary *)dict;

@end

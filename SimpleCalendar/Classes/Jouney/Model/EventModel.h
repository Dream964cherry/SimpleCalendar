//
//  EventModel.h
//  SimpleCalendar
//
//  Created by wmh on 16/8/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "BQLDBModel.h"
#define EventFile @"Event.sqlite"


@interface EventModel : BQLDBModel
@property (nonatomic,strong) NSString *iconname;
@property (nonatomic,strong) NSData *iconimage;
@property (nonatomic,copy) NSString *eventname;
@property (nonatomic,copy) NSString *note;
@property (nonatomic,copy) NSString *remindtime;

@end

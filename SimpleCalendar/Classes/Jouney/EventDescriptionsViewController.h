//
//  EventDescriptionsViewController.h
//  SimpleCalendar
//
//  Created by wmh on 16/8/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>
@class EventModel;

@interface EventDescriptionsViewController : UIViewController

typedef NS_ENUM(NSInteger, EditType)
{
    EditTypeEdit = 0,   /**< 编辑备忘录    */
    EditTypeAdd         /**< 新增备忘录    */
};


@property (nonatomic,copy)NSDictionary *dict;

@property (nonatomic,strong) EventModel *model;

@property (nonatomic) EditType type;

@end

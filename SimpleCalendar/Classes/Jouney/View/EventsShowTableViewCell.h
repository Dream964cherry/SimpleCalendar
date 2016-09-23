//
//  EventsShowTableViewCell.h
//  FreeCalendar
//
//  Created by wmh on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class EventModel;

@interface EventsShowTableViewCell : UITableViewCell
@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
@property (weak, nonatomic) IBOutlet UILabel *eventNameLab;
@property (weak, nonatomic) IBOutlet UILabel *remindTimeLab;
@property(nonatomic,strong) EventModel *model;

+ (instancetype)cellWithTableView:(UITableView *)tableView;
@end

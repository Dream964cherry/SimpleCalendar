//
//  EventsShowTableViewCell.m
//  FreeCalendar
//
//  Created by wmh on 16/8/2.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "EventsShowTableViewCell.h"
#import "EventModel.h"

@interface EventsShowTableViewCell ()
//@property (weak, nonatomic) IBOutlet UIImageView *iconImage;
//@property (weak, nonatomic) IBOutlet UILabel *eventNameLab;
//@property (weak, nonatomic) IBOutlet UILabel *remindTimeLab;

@end


@implementation EventsShowTableViewCell


- (void)setModel:(EventModel *)model{
    _model = model;
//    NSData *data= UIImageJPEGRepresentation(self.iconImage.image, 1);
//    data = model.iconimage;
    _iconImage.image = [UIImage imageWithData:model.iconimage];
    self.eventNameLab.text = model.eventname;
    self.remindTimeLab.text = model.remindtime;
}
+ (instancetype)cellWithTableView:(UITableView *)tableView{
    static NSString *strIdentifier = @"EventsShowTableViewCell";
    EventsShowTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:strIdentifier];
    if (cell == nil) {
        cell = [[[NSBundle mainBundle]loadNibNamed:@"EventsShowTableViewCell" owner:nil options:nil] firstObject];
    }
    return cell;
}
- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];
    // Configure the view for the selected state
}

@end

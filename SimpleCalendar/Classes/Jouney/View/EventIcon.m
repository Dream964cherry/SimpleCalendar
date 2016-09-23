//
//  EventIcon.m
//  FreeCalendar
//
//  Created by wmh on 16/8/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "EventIcon.h"

#define Width self.frame.size.width
#define labHeight 20

@implementation EventIcon

- (instancetype)initWithFrame:(CGRect)frame andDictionary:(NSDictionary *)dict{
    if (self = [super initWithFrame:frame]) {
         UIButton *iconImg = [[UIButton alloc]initWithFrame:CGRectMake(0, 0, Width, Width)];
        UILabel *nameLab = [[UILabel alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(iconImg.frame)+2, Width, labHeight)];
        nameLab.font = [UIFont systemFontOfSize:12];
        nameLab.textAlignment = NSTextAlignmentCenter;
        [iconImg setBackgroundImage:[UIImage imageNamed:dict[@"Icon"]] forState:UIControlStateNormal];
        nameLab.text = dict[@"name"];
        [iconImg addTarget:self action:@selector(event) forControlEvents:UIControlEventTouchUpInside];
        [self addSubview:iconImg];
        [self addSubview:nameLab];
        
    }
    return self;
}
- (void)event{
    if (self.eventView) {
        self.eventView();
    }
}
@end

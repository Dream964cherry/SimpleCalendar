//
//  CJDecisionView.m
//  CJCalendar
//
//  Created by chjsun on 16/5/25.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import "DecisionView.h"

#define CJColor(r, g, b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1])

@implementation DecisionView


-(instancetype)initWithFrame:(CGRect)frame{
    if (self = [super initWithFrame:frame]) {
       
    }
    return self;
}


-(void) generateDecision{
    CGFloat width = self.frame.size.width;
    CGFloat height = self.frame.size.height;
    
    // 返回当前
    CGRect nowRect = CGRectMake(0, 0, width, height);
    [self addNow:nowRect];
}
// 返回当前
-(void) addNow:(CGRect)rect{
    
    UIButton *now = [[UIButton alloc] initWithFrame:rect];
    
    [now setImage:[UIImage imageNamed:@"Today"] forState:UIControlStateNormal];
    [now setImage:[UIImage imageNamed:@"Today_highlighted"] forState:UIControlStateHighlighted];
    [now addTarget:self action:@selector(didNow:) forControlEvents:UIControlEventTouchDown];
    
    [self addSubview:now];
}
// 返回按钮点击事件
-(void) didNow:(UIButton *)button{

    if ([self.delegate respondsToSelector:@selector(DecisionDidSelectNow:)]) {
        [self.delegate DecisionDidSelectNow:self];
    }
    
}
@end

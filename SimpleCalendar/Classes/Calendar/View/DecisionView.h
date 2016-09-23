//
//  CJDecisionView.h
//  CJCalendar
//
//  Created by chjsun on 16/5/25.
//  Copyright © 2016年 chjsun. All rights reserved.
//

#import <UIKit/UIKit.h>

@class DecisionView;
@protocol DecisionDelegate <NSObject>

@optional
-(void) DecisionDidSelectNow: (DecisionView *)decision;

-(void) DecisionDidSelectCancel: (DecisionView *)decision;

-(void) DecisionDidSelectAction: (DecisionView *)decision;

@end

@interface DecisionView : UIView

//初始化
-(void) generateDecision;

/** 代理 */
@property (nonatomic, assign) id<DecisionDelegate> delegate;

@end

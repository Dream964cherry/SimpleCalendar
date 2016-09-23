//
//  DatePickerView.m
//  FreeCalendar
//
//  Created by wmh on 16/8/1.
//  Copyright © 2016年 qingyun. All rights reserved.
//
#define screenWidth  [UIScreen mainScreen].bounds.size.width
#define screenHeight [UIScreen mainScreen].bounds.size.height
#define datePickerY screenHeight/3*2
#define datePickerHeight screenHeight/3
#define cancelBtnX 30
#define cancelBtnWidth screenWidth/6
#define chooseBtnX screenWidth - 30 - cancelBtnWidth
#define btnY datePickerY - 30
#define btnHeight 30

#import "DatePickerView.h"

@interface DatePickerView()
@property (nonatomic,strong)UIView *groundView;
@property (nonatomic,strong)UIView *topView;
@property (nonatomic,strong)UIDatePicker *datePic;
@property (nonatomic,strong)UIButton *cancelBtn;
@property (nonatomic,strong)UIButton *chooseBtn;
@property (nonatomic,assign)UIDatePickerMode type;
@end


@implementation DatePickerView
- (instancetype)initWithFrame:(CGRect)frame type:(UIDatePickerMode)type{
    self = [super initWithFrame:frame];
    if (self) {
        self.type = type;
        [self addSubview:self.groundView];
        [self addSubview:self.topView];
        [self addSubview:self.datePic];
        [self addSubview:self.cancelBtn];
        [self addSubview:self.chooseBtn];
        
                     
        
    }
    return self;
}
- (UIDatePicker *)datePic{
    if (!_datePic) {
        _datePic = [[UIDatePicker alloc]initWithFrame:CGRectMake(0, datePickerY, screenWidth, datePickerHeight)];
        _datePic.backgroundColor = [UIColor whiteColor];
        _datePic.datePickerMode = self.type;
        _datePic.locale = [[NSLocale alloc]initWithLocaleIdentifier:@"zh_cn"];
        [_datePic addTarget:self action:@selector(useDatePic:) forControlEvents:UIControlEventTouchUpInside];
        
    }
    return _datePic;
}
- (UIView *)groundView{
    if (!_groundView) {
        _groundView = [[UIView alloc]initWithFrame:self.bounds];
        _groundView.backgroundColor = [UIColor blackColor];
        _groundView.alpha = 0.5;
    }
    return _groundView;
}

- (UIButton *)cancelBtn{
    if (!_cancelBtn) {
        _cancelBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _cancelBtn.frame = CGRectMake(cancelBtnX, btnY,cancelBtnWidth, btnHeight);
        [_cancelBtn setTitle:@"取消" forState:UIControlStateNormal];
        
        [_cancelBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_cancelBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [_cancelBtn addTarget:self action:@selector(useDateCancelBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _cancelBtn;
}

- (UIButton *)chooseBtn{
    if (!_chooseBtn) {
        _chooseBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _chooseBtn.frame = CGRectMake(chooseBtnX, btnY, cancelBtnWidth, btnHeight);
        [_chooseBtn setTitle:@"确定" forState:UIControlStateNormal];
        [_chooseBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
        [_chooseBtn setTitleColor:[UIColor blueColor] forState:UIControlStateHighlighted];
        [_chooseBtn addTarget:self action:@selector(useDateChooseBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _chooseBtn;
}
- (UIView *)topView{
    if (!_topView) {
        _topView = [[UIView alloc]initWithFrame:CGRectMake(0, btnY, screenWidth, btnHeight)];
        self.topView.backgroundColor = [UIColor whiteColor];
    }
    return _topView;
}
//设置初始时间
- (void)setNowTime:(NSString *)dateStr{
    [self.datePic setDate:[self dateFromString:dateStr] animated:YES];
}

- (void)useDatePic:(NSDate *)date{
    [self.delegate changeTime:self.datePic.date];
}
- (void)useDateCancelBtn{
    [self removeFromSuperview];
}
- (void)useDateChooseBtn{
    [self.delegate determineTime:self.datePic.date];
    [self removeFromSuperview];
}

- (NSString *)stringFromDate:(NSDate *)date{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    switch (self.type) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    
    NSString *destDateString = [dateFormatter stringFromDate:date];
    return destDateString;

    
}
- (NSDate *)dateFromString:(NSString *)dateString{
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc]init];
    switch (self.type) {
        case UIDatePickerModeTime:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        case UIDatePickerModeDate:
            [dateFormatter setDateFormat:@"yyyy-MM-dd"];
            break;
        case UIDatePickerModeDateAndTime:
            [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
            break;
        case UIDatePickerModeCountDownTimer:
            [dateFormatter setDateFormat:@"HH:mm"];
            break;
        default:
            break;
    }
    NSDate *destDate = [dateFormatter dateFromString:dateString];
    return destDate;

}
@end

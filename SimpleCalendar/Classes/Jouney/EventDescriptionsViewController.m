//
//  EventDescriptionsViewController.m
//  SimpleCalendar
//
//  Created by wmh on 16/8/7.
//  Copyright © 2016年 qingyun. All rights reserved.
//
#define RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]

#import "EventDescriptionsViewController.h"
#import "DatePickerView.h"
#import "BQLDBTool.h"
#import "BQLElseTool.h"
#import "EventModel.h"
#import "JouneyViewController.h"


@interface EventDescriptionsViewController ()<DatePickerViewDelegate>
{
    UIBarButtonItem *_saveBtn;
    BQLDBTool *_tool;
}
@property (weak, nonatomic) IBOutlet UIImageView *iconImg;
@property (weak, nonatomic) IBOutlet UILabel *iconNameLab;
@property (weak, nonatomic) IBOutlet UITextField *eventNameText;
@property (weak, nonatomic) IBOutlet UIButton *remindTimeBtn;
@property (weak, nonatomic) IBOutlet UITextField *noteText;

@property (strong,nonatomic) DatePickerView *datePicker;

@end

@implementation EventDescriptionsViewController

- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event{
    [_eventNameText resignFirstResponder];
    [_noteText resignFirstResponder];
}

- (DatePickerView *)datePicker {
    if (!_datePicker) {
        self.datePicker = [[DatePickerView alloc]initWithFrame:self.view.bounds type:UIDatePickerModeDateAndTime];
        self.datePicker.delegate = self;
    }
    return _datePicker;
}


- (void)viewDidLoad {
    [super viewDidLoad];
    [self setSubviews];
    
    _saveBtn = [[UIBarButtonItem alloc]initWithTitle:@"保存" style:UIBarButtonItemStylePlain target:self  action:@selector(saveAction)];
    self.navigationItem.rightBarButtonItem = _saveBtn;
    self.navigationController.navigationBar.tintColor = RGB(28, 124, 255);
}

- (void)setSubviews{
    if (self.type == EditTypeAdd) {
        self.iconImg.image = [UIImage imageNamed:self.dict[@"Icon"]];
        self.iconNameLab.text = self.dict[@"name"];
    }else if (self.type == EditTypeEdit){
        
        self.iconImg.image = [UIImage imageWithData:self.model.iconimage];
        self.iconNameLab.text = self.model.iconname;
        self.eventNameText.text = self.model.eventname;
        self.noteText.text = self.model.note;
        self.remindTimeBtn.titleLabel.text = self.model.remindtime;
    }
}

- (IBAction)reminaTimeBtn:(UIButton *)sender {
    [self.view addSubview:self.datePicker];
    //初始化时间
    if (sender.titleLabel.text.length!=0 && ![sender.titleLabel.text isEqualToString:@"选择事件发生的时间"]) {
        [self.datePicker setNowTime:sender.titleLabel.text];
    }

}

- (void)saveAction{
     JouneyViewController* jouneyVC = nil;
    for (UIViewController * VC in self.navigationController.viewControllers) {
        if ([VC isKindOfClass:[JouneyViewController class]]) {
            jouneyVC = (JouneyViewController *)VC;
        }
    }

    if (!_tool) {
        _tool = [BQLDBTool instantiateTool];
    }
    if (!checkObjectNotNull(_eventNameText.text)) {
        [self showAlert:@"事件名称不能为空!"];
        return;
    }
    NSDictionary *add = @{@"iconimage":UIImageJPEGRepresentation(self.iconImg.image, 1),
                          @"iconname":self.iconNameLab.text,
                          @"eventname":self.eventNameText.text,
                          @"note":self.noteText.text,
                          @"remindtime":self.remindTimeBtn.titleLabel.text
                          };
    EventModel *model= [EventModel modelWithDictionary:add];
    if (self.type == EditTypeAdd) {
        
        [_tool insertDataWith:EventFile Model:model];
        
        [self.navigationController popToViewController:jouneyVC animated:YES];
        }else if (self.type == EditTypeEdit){
            [_tool modifyDataWith:EventFile Model:model Identifier:@"customid" IdentifierValue:[NSString stringWithFormat:@"%lld",self.model.customID]];
                [self.navigationController popToViewController:jouneyVC animated:YES];
       }
}
- (void)showAlert:(NSString *)message{
    UIAlertController *alertController = [UIAlertController alertControllerWithTitle:@"提示" message:message preferredStyle:UIAlertControllerStyleAlert];
    UIAlertAction *okAction = [UIAlertAction actionWithTitle:@"确定" style:UIAlertActionStyleDefault handler:^(UIAlertAction * _Nonnull action) {
    }];
    [alertController addAction:okAction];
    [self presentViewController:alertController animated:YES completion:nil];
}

#pragma mark DatePickerViewDelegate
- (void)changeTime:(NSDate *)date{
    
}
- (void)determineTime:(NSDate *)date{
    [self.remindTimeBtn setTitle:[_datePicker stringFromDate:date] forState: UIControlStateNormal];
}

@end

//
//  CJYearViewController.m
//  CJCalendar
//
//  Created by chjsun on 16/5/24.
//  Copyright © 2016年 chjsun. All rights reserved.
//
#define CJColor(r, g, b) ([UIColor colorWithRed:(r)/255.0 green:(g)/255.0 blue:(b)/255.0 alpha:1])

#import "YearViewController.h"

@interface YearViewController ()

/** indexPaht */
@property (nonatomic, assign) NSIndexPath *selectIndexPath;

@end

static NSString * const reuseIdentifier = @"yearTableViewCell";
@implementation YearViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    

}

#pragma mark - Table view data source

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return 2101-1970;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    
//    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier forIndexPath:indexPath];
    UITableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:reuseIdentifier];
    
    
    if (cell == nil) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:reuseIdentifier];
        cell.textLabel.highlightedTextColor = [UIColor whiteColor];
        
        CGRect rect = self.view.frame;
        
        CGFloat height = rect.size.height/8;
        CGFloat width = height;
        CGFloat x = (rect.size.width - height)/2;
        CGFloat y = 0;
        
        UIView *selectView = [[UIView alloc] initWithFrame:CGRectMake(x, y, width, height)];
        
        selectView.backgroundColor = CJColor(38, 124, 255);
        selectView.layer.cornerRadius = height/2;
        selectView.layer.masksToBounds = YES;
        
        UIView *selectBgView = [[UIView alloc] initWithFrame:cell.frame];
        [selectBgView addSubview:selectView];
        
        cell.selectedBackgroundView = selectBgView;
    }
    
    cell.textLabel.text = [NSString stringWithFormat:@"%ld", indexPath.row + 1970];
    cell.textLabel.font = [UIFont systemFontOfSize:22];
    cell.textLabel.textAlignment = NSTextAlignmentCenter;
    
    return cell;
}

-(CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return self.view.frame.size.height/8;
}

-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell = [tableView cellForRowAtIndexPath:indexPath];
    self.selectIndexPath  = indexPath;
    [self.tableView selectRowAtIndexPath:indexPath animated:YES scrollPosition:UITableViewScrollPositionMiddle];

    if ([self.delegate respondsToSelector:@selector(yearTableView:didSelectRowAtIndexPath:cellText:)]) {

        [self.delegate yearTableView:tableView didSelectRowAtIndexPath:indexPath cellText:cell.textLabel.text];
    }
}


-(void)refreshControlWithCellText:(NSString *)year{
    NSUInteger row = [year integerValue] - 1970;
    NSIndexPath *indexPath = [self.tableView indexPathForRowAtPoint:CGPointMake(10, row * self.view.frame.size.height/4+1)];
    
    [self.tableView selectRowAtIndexPath:indexPath animated:NO scrollPosition:UITableViewScrollPositionMiddle];
}

@end
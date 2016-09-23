//
//  JouneyViewController.m
//  FreeCalendar
//
//  Created by wmh on 16/7/8.
//  Copyright © 2016年 qingyun. All rights reserved.
//

#import "JouneyViewController.h"
#import "UITableView+EmptyData.h"
#import "AddEventViewController.h"
#import "EventsShowTableViewCell.h"
#import "BQLDBTool.h"
#import "EventModel.h"
#import "EventDescriptionsViewController.h"


@interface JouneyViewController ()<UITableViewDelegate, UITableViewDataSource>
{
    UITableView *_jounTab;
    BQLDBTool *_tool;
}
@property (nonatomic,strong)NSMutableArray *dataSourse;

@end

@implementation JouneyViewController

- (NSMutableArray *)dataSourse{
    if (!_dataSourse) {
        _dataSourse = [NSMutableArray arrayWithCapacity:1];
    }
    return _dataSourse;
}

- (void)initialEvent{
    [_dataSourse removeAllObjects];
    if (!_tool) {
        _tool = [BQLDBTool instantiateTool];
    }
    NSDictionary *event = @{@"iconimage":@"",
                            @"iconname":@"",
                            @"eventname":@"",
                            @"note":@"",
                            @"remindtime":@""
                            };
    EventModel *model = [EventModel modelWithDictionary:event];
    [_tool openDBWith:EventFile Model:model];
    NSArray *array = [_tool queryDataWith:EventFile];
    for (NSDictionary *dict in array) {
        EventModel *dataModel = [ EventModel modelWithDictionary:dict];
        [self.dataSourse addObject:dataModel];
    }
    if (_jounTab) [_jounTab reloadData];
}
- (void)viewWillAppear:(BOOL)animated{
    [super viewWillAppear:animated];
    [self initialEvent];
}
- (void)viewDidLoad {
    [super viewDidLoad];
    [self loadDefaultSetting];
    [self loadNavigationBarSetting];
    
}
- (void)loadNavigationBarSetting{
    //添加按钮
    CGFloat btnW = 20;
    CGFloat btnH = 20;
    UIButton *addBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    addBtn.bounds = CGRectMake(0, 0, btnW, btnH);
    [addBtn setImage:[UIImage imageNamed:@"Add"] forState:UIControlStateNormal];
    [addBtn setImage:[UIImage imageNamed:@"Add_highlighted"] forState:UIControlStateHighlighted];
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:addBtn];
    [addBtn addTarget:self action:@selector(addEvent) forControlEvents:UIControlEventTouchUpInside];
    //删除按钮
    UIButton *deleteBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    deleteBtn.bounds = CGRectMake(H);
    [deleteBtn setImage:[UIImage imageNamed:@"Delete"] forState:UIControlStateNormal];
    [deleteBtn setImage:[UIImage imageNamed:@"Delete_highlighted"] forState:UIControlStateHighlighted];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc]initWithCustomView:deleteBtn];
    [deleteBtn addTarget:self action:@selector(deleteEvent:) forControlEvents:UIControlEventTouchUpInside];
}
- (void)loadDefaultSetting{
    _jounTab= [[UITableView alloc]init];
    _jounTab.frame = self.view.bounds;
    [self.view addSubview:_jounTab];
    _jounTab.delegate = self;
    _jounTab.dataSource = self;
    //[_jounTab setRowHeight:80];
    _jounTab.estimatedRowHeight = 40;
    _jounTab.separatorStyle = NO;
}
//section中有几个cell
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{
    //return 100;
    [tableView tableViewDisplayWitMsg:@"没有事件,点击上面的➕添加" ifNecessaryForRowCount:self.dataSourse.count];
    return self.dataSourse.count;
}
//每行要展示的数据
- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    EventsShowTableViewCell *cell = [EventsShowTableViewCell cellWithTableView:tableView];
    cell.model = self.dataSourse[indexPath.row];
    return cell;
}
//cell的点击事件
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    EventDescriptionsViewController *edit = [[EventDescriptionsViewController alloc]init];
    edit.type = EditTypeEdit;
    edit.model = self.dataSourse[indexPath.row];
    [self.navigationController pushViewController:edit animated:YES];
}
//
- (void)deleteEvent:(UIButton *)button{
    button.selected = !button.isSelected;
    if (button.isSelected == YES) {
        [_jounTab setEditing:YES animated:YES];
    } else {
        [_jounTab setEditing:NO animated:YES];
    }

}
//是否进入编辑模式
- (BOOL)tableView:(UITableView *)tableView canEditRowAtIndexPath:(NSIndexPath *)indexPath{
    return YES;
}
//编辑模式时删除
- (UITableViewCellEditingStyle)tableView:(UITableView *)tableView editingStyleForRowAtIndexPath:(NSIndexPath *)indexPath{
    return UITableViewCellEditingStyleDelete;
}
//删除数据
- (void)tableView:(UITableView *)tableView commitEditingStyle:(UITableViewCellEditingStyle)editingStyle forRowAtIndexPath:(NSIndexPath *)indexPath{
    if (editingStyle == UITableViewCellEditingStyleDelete) {
        EventModel *model = self.dataSourse[indexPath.row];
        if ([_tool deleteDataWith:EventFile Identifier:@"customid" IdentifierValue:[NSString stringWithFormat:@"%lld",model.customID]]) {
            [self.dataSourse removeObjectAtIndex:indexPath.row];
        }
    }
    [_jounTab reloadData];
}

- (void)addEvent{
    AddEventViewController *addEventVC = [[AddEventViewController alloc]init];
    [self.navigationController pushViewController:addEventVC animated:YES];
}


@end

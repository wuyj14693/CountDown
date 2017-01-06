//
//  ViewController.m
//  WyjCountDownDemo
//
//  Created by wuyj on 17/1/6.
//  Copyright © 2017年 WYJ. All rights reserved.
//  说明：本Demo列举了三种倒计时方案。KVO方案最优
//  第一种：通过定时器每隔1秒刷新表格（每秒刷新tableview还是比较耗性能）
//  第二种：通过KVO监听TimeCenter的timeInterval变量（每秒+1），监听到就刷新cell一次
//  第三种：通过GCD定时器每隔1秒刷新cell（会出现误差）

#import "ViewController.h"
#import "TableViewCell.h"
#import "TimeModel.h"
#import "TimeCenter.h"
@interface ViewController ()<UITableViewDelegate,UITableViewDataSource>
@property (weak, nonatomic)  UITableView *tableView;
@property (nonatomic, strong) NSArray *timeArray;
@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    [self createTableView];
    
    [[TimeCenter  shareCenter] start];
    
    //第一种：每隔一秒刷新tableview一次
//    [TimeCenter  shareCenter].blockTimeEvent=^{   
//        [self.tableView reloadData];
//    };

}

//模拟数据
- (NSArray *)timeArray {
    if (_timeArray == nil) {
        //当前时间戳
        NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];       
        NSInteger timeInterval = [date timeIntervalSince1970];
                
        NSMutableArray *array = [NSMutableArray array];
        for (NSInteger i=0; i<100; i++) {
            TimeModel *model = [[TimeModel alloc]init];
            model.time = [NSString stringWithFormat: @"%ld", timeInterval+i*1000];
            [array addObject:model];
        }
        _timeArray =array;
    }
    return _timeArray;
}
- (void)createTableView
{
    UITableView *table=[[UITableView alloc]init];
    table.frame=CGRectMake(0, 0, [UIScreen mainScreen].bounds.size.width, [UIScreen mainScreen].bounds.size.height);
    self.tableView= table;
    self.tableView.dataSource = self;
    self.tableView.delegate= self;
    [self.view addSubview: self.tableView];
    self.tableView.rowHeight=80;

}
#pragma mark - 数据源方法
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.timeArray.count;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath
{
    TableViewCell *cell = [TableViewCell cellWithTableView:tableView];
    cell.timeModel=self.timeArray[indexPath.row];
    cell.detailTextLabel.text=[NSString stringWithFormat:@"第%ld行",(long)indexPath.row];
    return cell;
}


@end

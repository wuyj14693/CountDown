//
//  TableViewCell.h
//  WyjCountDownDemo
//
//  Created by wuyj on 17/1/6.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <UIKit/UIKit.h>
@class TimeModel;
@interface TableViewCell : UITableViewCell
+ (instancetype)cellWithTableView:(UITableView *)tableView;
@property(nonatomic,strong)TimeModel *timeModel;
@end

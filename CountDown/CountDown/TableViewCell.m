//
//  TableViewCell.m
//  WyjCountDownDemo
//
//  Created by wuyj on 17/1/6.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "TableViewCell.h"
#import "TimeModel.h"
#import "TimeCenter.h"
@interface TableViewCell ()

@property (nonatomic, strong)dispatch_source_t timer;
@end

@implementation TableViewCell


+ (instancetype)cellWithTableView:(UITableView *)tableView
{    
    static NSString *ID = @"tableViewCell";
    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:ID];
    if (cell == nil) {
        cell = [[TableViewCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:ID];
    }
    
    return cell;
}

- (id)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
    //第二种：KVO监听
    [[TimeCenter shareCenter] addObserver:self
                               forKeyPath:@"timeInterval"
                                  options:NSKeyValueObservingOptionOld
     |NSKeyValueObservingOptionNew context:nil];
        
        
        
         //第三种：GCD定时器
//        uint64_t interval = 1 * NSEC_PER_SEC;
//        //创建一个专门执行timer回调的GCD队列
//        dispatch_queue_t queue = dispatch_queue_create("my queue", 0);
//        //创建Timer
//        _timer = dispatch_source_create(DISPATCH_SOURCE_TYPE_TIMER, 0, 0, queue);
//        //使用dispatch_source_set_timer函数设置timer参数
//        dispatch_source_set_timer(_timer, dispatch_time(DISPATCH_TIME_NOW, 0), interval, 0);
//        dispatch_source_set_event_handler(_timer, ^{
//            
//            dispatch_async(dispatch_get_main_queue(), ^{
//                [self reloadCell];
//                
//            });
//            
//        });
//        
//        dispatch_resume(_timer);
    }
    return self;
}


- (void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context
{
    if ([keyPath isEqual:@"timeInterval"]) {
       [self reloadCell];
    }
}

- (void)setTimeModel:(TimeModel *)timeModel
{
    _timeModel=timeModel;
    [self reloadCell];
}

- (void)reloadCell
{
    NSDate *date = [NSDate dateWithTimeIntervalSinceNow:0];
    NSInteger time = [date timeIntervalSince1970];
    NSInteger leftTime = [self.timeModel.time integerValue] - time;
    
    if (leftTime <0)
    {
        self.textLabel.text =@"已结束";
    }
    else
    {
        self.textLabel.text = [NSString stringWithFormat:@"剩余%ld天%02ld:%02ld:%02ld",  leftTime/(60*60*24),(leftTime/3600)%24, (leftTime/60)%60, leftTime%60];
    }
}

@end

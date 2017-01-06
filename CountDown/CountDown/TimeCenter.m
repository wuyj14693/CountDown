//
//  TimeCenter.m
//  WyjCountDownDemo
//
//  Created by wuyj on 17/1/6.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import "TimeCenter.h"
@interface TimeCenter ()
@property (nonatomic, assign) NSInteger timeInterval;// 累计时间
@property (nonatomic, strong) NSTimer *timer;

@end
@implementation TimeCenter
+ (instancetype)shareCenter {
    static TimeCenter *center = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        center = [[TimeCenter alloc]init];
    });
   
    return center;
}
//启动
- (void)start {
   NSTimer  *timer = [NSTimer scheduledTimerWithTimeInterval:1 target:self selector:@selector(timerEvent) userInfo:nil repeats:YES];
    self.timer=timer;
    [[NSRunLoop mainRunLoop] addTimer:timer forMode:NSRunLoopCommonModes];
}
//停止
- (void)stop
{
     if (_timer != nil) {
         [self.timer invalidate];
     }
}

//事件
- (void)timerEvent
{
    if (_timer != nil) {
        self.timeInterval++;
        if (self.blockTimeEvent) {
            self.blockTimeEvent();
        }
    }

}



@end

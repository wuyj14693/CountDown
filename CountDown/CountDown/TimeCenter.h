//
//  TimeCenter.h
//  WyjCountDownDemo
//
//  Created by wuyj on 17/1/6.
//  Copyright © 2017年 WYJ. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface TimeCenter : NSObject


@property (nonatomic, copy) void (^blockTimeEvent)();

+ (instancetype)shareCenter;

- (void)start;

@end

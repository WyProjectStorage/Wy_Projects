//
//  NSTimer+Convenience.h
//  Animation
//
//  Created by 汪洋 on 16/3/28.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void (^VoidBlock)();

@interface NSTimer (Convenience)

/**
 *  创建Timer---Block版本(可重复)
 *
 *  @param interval 回调时间间隔
 *  @param repeats  是否重复
 *  @param callback 回调block
 *
 *  @return NSTimer对象
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    repeats:(BOOL)repeats
                                   callback:(VoidBlock)callback;


/**
 *  创建Timer---Block版本(可定次数)
 *
 *  @param interval 回调时间间隔
 *  @param count    回调多少次后自动暂停，如果count <= 0，则表示无限次，否则表示具体的次数
 *  @param callback 回调block
 *
 *  @return NSTimer对象
 */
+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      count:(NSInteger)count
                                   callback:(VoidBlock)callback;

/**
 *  开始启动定时器
 */
- (void)fireTimer;

/**
 *  暂停定时器
 */
- (void)unfireTimer;

@end

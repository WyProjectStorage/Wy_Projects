//
//  NSTimer+Convenience.m
//  Animation
//
//  Created by 汪洋 on 16/3/28.
//  Copyright © 2016年 汪洋. All rights reserved.
//

#import "NSTimer+Convenience.h"

@implementation NSTimer (Convenience)

+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                    repeats:(BOOL)repeats
                                   callback:(VoidBlock)callback {
    
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(onTimerUpdateBlock:)
                                          userInfo:[callback copy]
                                           repeats:repeats];
}


+ (NSTimer *)scheduledTimerWithTimeInterval:(NSTimeInterval)interval
                                      count:(NSInteger)count
                                   callback:(VoidBlock)callback{
    
    NSDictionary *userInfo = @{@"callback" : [callback copy],
                               @"count"    : @(count)};
    
    return [NSTimer scheduledTimerWithTimeInterval:interval
                                            target:self
                                          selector:@selector(onTimerUpdateCountBlock:)
                                          userInfo:userInfo
                                           repeats:YES];
}


//计时器方法(启动回调)
+ (void)onTimerUpdateBlock:(NSTimer *)timer {
    VoidBlock block = timer.userInfo;
    if (block) {
        block();
    }
}

+ (void)onTimerUpdateCountBlock:(NSTimer *)timer {
    
    static NSUInteger currentCount = 0;
    
    NSDictionary *userinfo = timer.userInfo;
    VoidBlock callback = userinfo[@"callback"];
    NSNumber *count = userinfo[@"count"];
    
    if (count.integerValue <= 0) {
        if (callback) {
            callback();
        }
    }else {
        if (currentCount < count.integerValue) {
            currentCount ++;
            if (callback) {
                callback();
            }
        }else {
            currentCount = 0;
            
            [timer unfireTimer];
            [timer invalidate];
            timer = nil;
        }
    }
    
}


- (void)fireTimer {
    [self setFireDate:[NSDate distantPast]];
}


- (void)unfireTimer {
    [self setFireDate:[NSDate distantFuture]];
}
@end

//
//  NSTimer+JadeTimer.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/22.
//

#import "NSTimer+JadeTimer.h"

@implementation NSTimer (JadeTimer)

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void (^)(NSTimer * _Nonnull))block {
    NSTimer *timer = [NSTimer scheduledTimerWithTimeInterval:interval target:self selector:@selector(trigger:) userInfo:[block copy] repeats:repeats];
    return timer;
}

+ (void)trigger:(NSTimer *)timer {
    void(^block)(NSTimer *timer) = [timer userInfo];
    if (block) {
        block(timer);
    }
}

@end

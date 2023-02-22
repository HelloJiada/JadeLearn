//
//  NSTimer+JadeTimer.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/22.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface NSTimer (JadeTimer)

+ (instancetype)scheduledTimerWithTimeInterval:(NSTimeInterval)interval repeats:(BOOL)repeats block:(void(^)(NSTimer *timer))block;
@end

NS_ASSUME_NONNULL_END

//
//  JadeTimeAxisValueFormatter.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/3/2.
//

#import <Foundation/Foundation.h>
@import Charts.Swift;
NS_ASSUME_NONNULL_BEGIN

@interface JadeTimeAxisValueFormatter : NSObject<IChartAxisValueFormatter>
- (id)initForChart:(BarLineChartViewBase *)chart;

@property (nonatomic, strong) NSMutableArray *timeArray;
@property (nonatomic, assign) NSInteger endTime;
@property (nonatomic, assign) NSInteger startTime;
@property (nonatomic, assign) int labelCount;
@end

NS_ASSUME_NONNULL_END

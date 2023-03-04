//
//  JadeCentrakIndexLineViewController.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/3/3.
//

#import "JadeViewController.h"
@import Charts.Swift;
NS_ASSUME_NONNULL_BEGIN

@interface JadeCentrakIndexLineViewController : JadeViewController<ChartViewDelegate>
@property (nonatomic, strong) LineChartView *lineChartView;

@end

NS_ASSUME_NONNULL_END

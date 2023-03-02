//
//  JadeTimeAxisValueFormatter.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/3/2.
//

#import "JadeTimeAxisValueFormatter.h"

@implementation JadeTimeAxisValueFormatter
{
    __weak BarLineChartViewBase *_chart;
}

- (id)initForChart:(BarLineChartViewBase *)chart
{
    self = [super init];
    if (self)
    {
        self->_chart = chart;

    }
    return self;
}

- (NSString *)stringForValue:(double)value
                        axis:(ChartAxisBase *)axis
{
    for (int i = 0; i < self.labelCount; i++) {
        if (i * 60 * 60 * 2 == value) {
            int hourInDay = (int) (((value + self.startTime) > 24 * 60 * 60 ? value + self.startTime - (24 * 60 * 60) : value + self.startTime) / (60 * 60));
            return hourInDay == 12 ? @"12:00" : hourInDay == 24 ? @"00:00" : hourInDay > 12 ? [NSString stringWithFormat:@"%d:00",hourInDay % 12 + 12] : [NSString stringWithFormat:@"%d:00",hourInDay==0?hourInDay=12:hourInDay];
        }
    }
    return @"";
}


@end

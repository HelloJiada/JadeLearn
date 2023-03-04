//
//  JadeCentrakIndexLineViewController.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/3/3.
//

#import "JadeCentrakIndexLineViewController.h"

@interface JadeCentrakIndexLineViewController ()
@property (nonatomic, strong) NSDictionary *dataDict;
@end

@implementation JadeCentrakIndexLineViewController
- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.lineChartView];
    [self.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.top.mas_equalTo(self.view.mas_top).offset(kTabBarHeight + 100);
        make.height.mas_equalTo(200);
        make.left.right.mas_equalTo(self.view);
    }];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 0.1 * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self requestData];
    });
    
}

- (NSDictionary *)dataDict {
    if (!_dataDict) {
        _dataDict = [[NSDictionary alloc] init];
        _dataDict = [JadeTools readLocalFileWithName:@"CentrakIndexLine"];
    }
    return _dataDict;
}

- (void)requestData {
    ChartXAxis *xAxis = self.lineChartView.xAxis;
    ChartYAxis *yAxis = self.lineChartView.leftAxis;
    
    yAxis.axisMaximum = [self.dataDict[@"max"] doubleValue];
    yAxis.axisMinimum = [self.dataDict[@"min"] doubleValue];
    [yAxis setLabelCount:5 force:YES];
    xAxis.axisMinimum = 0;
    xAxis.axisMaximum = 24;
    NSMutableArray *lineArray = [[NSMutableArray alloc] init];
    NSMutableArray *array = [[NSMutableArray alloc] init];
    NSArray *dataArray = self.dataDict[@"list"];
    [dataArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        [array addObject:@""];
        [array addObject:obj[@"xplotFlag"]];
    }];
    xAxis.valueFormatter =  [ChartIndexAxisValueFormatter withValues:array];
    [xAxis setLabelCount:24 force:NO];

    
    NSMutableArray *low = [NSMutableArray array];
    NSMutableArray *high = [NSMutableArray array];
    for (NSDictionary *model in dataArray) {
        if ([model[@"baselineLow"] integerValue]>0) {
            [low addObject: [NSNumber numberWithFloat:[model[@"baselineLow"] integerValue]]];
        }
        [high addObject: [NSNumber numberWithFloat:[model[@"baselineHigh"] integerValue]]];
    }
    CGFloat minLow = [[low valueForKeyPath:@"@min.floatValue"] floatValue];
    CGFloat maxhigh = [[high valueForKeyPath:@"@max.floatValue"] floatValue];
    CGFloat averageRes = (maxhigh + minLow) / 2;
    int num = 12.0 - low.count;
    if (num<12) {
        for (int i = 0; i< num; i++) {
            [low addObject:[NSNumber numberWithFloat:minLow]];
        }
    }
    
    LineChartDataSet *set1 = nil;
    LineChartDataSet *set2 = nil;
    
    NSMutableArray *values = [[NSMutableArray alloc] init];
    NSMutableArray *values1 = [[NSMutableArray alloc] init];
    
    for (int i = 0; i < 24; i++)
    {
        NSDictionary *model = dataArray[i/2];
        if ([model[@"baselineStatus"] integerValue]==1) {
            if (i%2==0) {
                [values addObject:[[ChartDataEntry alloc] initWithX:i==0?0:i+1 y:[high[i/2] doubleValue] averageSize:averageRes]];
                [values1 addObject:[[ChartDataEntry alloc] initWithX:i==0?0:i+1 y:[low[i/2] doubleValue] averageSize:averageRes]];
            }else{
                [values addObject:[[ChartDataEntry alloc] initWithX:i==0?0:i y:[high[i/2] doubleValue] averageSize:averageRes]];
                [values1 addObject:[[ChartDataEntry alloc] initWithX:i==0?0:i y:[low[i/2] doubleValue] averageSize:averageRes]];
            }
        }
    }
    [values addObject:[[ChartDataEntry alloc] initWithX:25 y:[dataArray.lastObject[@"baselineHigh"] doubleValue] averageSize:averageRes]];
    [values1 addObject:[[ChartDataEntry alloc] initWithX:25 y:[dataArray.lastObject[@"baselineLow"] doubleValue] averageSize:averageRes]];
    
    set1 = [[LineChartDataSet alloc] initWithEntries:values label:@"DataSet 1"];
    
    set1.drawIconsEnabled = NO;
    
    [set1 setColor:UIColor.clearColor];
    [set1 setCircleColor:UIColor.clearColor];
    set1.lineWidth = 1.0;
    
    set1.drawCircleHoleEnabled = NO;
    
    set1.drawValuesEnabled = NO;
    set1.drawHorizontalHighlightIndicatorEnabled = NO;
    set1.drawVerticalHighlightIndicatorEnabled = NO;
    
    set2 = [[LineChartDataSet alloc] initWithEntries:values1 label:@"DataSet 1"];
    
    set2.drawIconsEnabled = NO;
    
    [set2 setColor:UIColor.clearColor];
    [set2 setCircleColor:UIColor.clearColor];
    set2.lineWidth = 1.0;
    set2.drawCircleHoleEnabled = NO;
    
    set2.drawValuesEnabled = NO;
    set2.drawHorizontalHighlightIndicatorEnabled = NO;
    set2.drawVerticalHighlightIndicatorEnabled = NO;
    
    NSArray *gradientColors = @[
        (id)[UIColor colorWithRed:73/255.0f green:160/255.0f blue:227/255.0f alpha:0.3].CGColor,
        (id)[UIColor colorWithRed:73/255.0f green:160/255.0f blue:227/255.0f alpha:0.3].CGColor
    ];
    CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
    
    set1.fillAlpha = 1.f;
    set1.fill = [[ChartFill alloc] initWithLinearGradient:gradient angle:90.0f];
    set1.drawFilledEnabled = YES;
    
    set2.fillAlpha = 1.f;
    set2.fill = [[ChartFill alloc] initWithLinearGradient:gradient angle:90.0f];
    set2.drawFilledEnabled = YES;
    
    CGGradientRelease(gradient);
    [lineArray addObject:set1];
    [lineArray addObject:set2];
    
    LineChartData *lineData = [[LineChartData alloc] initWithDataSets:lineArray];
    
    self.lineChartView.data = lineData;
}

- (LineChartView *)lineChartView {
    if (!_lineChartView) {
        _lineChartView = [[LineChartView alloc] init];
        _lineChartView.delegate = self;
        _lineChartView.chartDescription.enabled = NO;
        _lineChartView.noDataText = Local(@"暂无数据");//没有数据时的文字提示
        //x y轴是否支持拖拽
        _lineChartView.scaleXEnabled = NO;
        _lineChartView.scaleYEnabled = NO;
        //是否支持xy轴同时缩放
        _lineChartView.pinchZoomEnabled = NO;
        //是否支持双击缩放
        _lineChartView.doubleTapToZoomEnabled = NO;
        //高亮点击
        _lineChartView.highlightPerTapEnabled = YES;
        //高亮拖拽
        _lineChartView.highlightPerDragEnabled = NO;
        //自动缩放
        _lineChartView.autoScaleMinMaxEnabled  = NO;
        //启用拖拽
        _lineChartView.dragEnabled = NO;
        [_lineChartView setScaleEnabled:NO];//是否拓展
        _lineChartView.pinchZoomEnabled = NO;
        _lineChartView.legend.enabled = NO;//不显示图例说明
        
        ChartXAxis *xAxis = _lineChartView.xAxis;
        xAxis.centerAxisLabelsEnabled = NO;
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        NSArray *array = @[];
        xAxis.valueFormatter =  [ChartIndexAxisValueFormatter withValues:array];
        xAxis.drawGridLinesEnabled = NO;//不绘制网格线
        xAxis.forceLabelsEnabled = YES;
        xAxis.labelTextColor = UIColor.blackColor;
        xAxis.labelFont = PingFangRegularFont(12);
        xAxis.drawLabelsEnabled = YES;
        xAxis.spaceMin = 0.5;
        xAxis.spaceMax = 0.5;
        
        ChartYAxis *leftAxis = _lineChartView.leftAxis;
        [leftAxis removeAllLimitLines];
        leftAxis.axisMaximum = 100;
        leftAxis.axisMinimum = 0;
        leftAxis.drawZeroLineEnabled = NO;
        leftAxis.drawLimitLinesBehindDataEnabled = YES;
        leftAxis.drawGridLinesEnabled = YES;
        leftAxis.axisLineColor = UIColor.whiteColor;//Y轴颜色
        leftAxis.labelCount = 2;
        
        _lineChartView.rightAxis.enabled = NO;
        
        [_lineChartView setExtraOffsetsWithLeft:16 top:8 right:20 bottom:0];
        
        _lineChartView.legend.form = ChartLegendFormLine;
//        [_lineChartView animateWithYAxisDuration:1.5];//不添加动画效果了
        
    }
    return _lineChartView;
}

@end

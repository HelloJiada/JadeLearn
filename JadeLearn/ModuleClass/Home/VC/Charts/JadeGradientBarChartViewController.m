//
//  JadeGradientBarChartViewController.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/3/3.
//

#import "JadeGradientBarChartViewController.h"

@interface JadeGradientBarChartViewController ()
@property (nonatomic, strong) NSDictionary *dataDict;
@end

@implementation JadeGradientBarChartViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.lineChartView];
    [self.lineChartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
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
        _dataDict = [JadeTools readLocalFileWithName:@"GradientBarChart"];
    }
    return _dataDict;
}

- (void)requestData {
    
    ChartXAxis *xAxis = self.lineChartView.xAxis;
    
    NSMutableArray *array = [[NSMutableArray alloc] init];
    for (int i = 0; i<14; i++) {
        if (i%2==0) {
            NSDictionary *model = self.dataDict[@"weekVO"][@"list"][i/2];
            [array addObject:[NSString stringWithFormat:@"\t%@",model[@"xplotFlag"]]];
        }else{
            [array addObject:@""];
        }
    }
    
    xAxis.axisMinimum = 0;
    xAxis.axisMaximum = 14;//修改
    xAxis.granularity = 1;  
    xAxis.valueFormatter =  [ChartIndexAxisValueFormatter withValues:array];
    xAxis.labelCount = 7;//修改
    xAxis.forceLabelsEnabled = NO;
    
    ChartYAxis *leftAxis = self.lineChartView.leftAxis;
    leftAxis.axisMaximum = [self.dataDict[@"weekVO"][@"yaxis"] doubleValue];
    leftAxis.labelCount = [self.dataDict[@"weekVO"][@"yaxis"] doubleValue]/50+1;
    leftAxis.forceLabelsEnabled = YES;
    
    NSMutableArray *dataSets = [[NSMutableArray alloc] init];
    NSArray *weakArray = self.dataDict[@"weekVO"][@"list"];
    int n = 0;
    for (int i = 0; i < weakArray.count; i++) {
        
        LineChartDataSet *set1 = nil;
        NSMutableArray *yVals1 = [[NSMutableArray alloc] init];
        NSDictionary *param = weakArray[i];
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:i+n y:[param[@"avg"] doubleValue]]];
        n = i+1;
        [yVals1 addObject:[[ChartDataEntry alloc] initWithX:n*2-1 y:[param[@"avg"] doubleValue]]];
        set1 = [[LineChartDataSet alloc] initWithEntries:yVals1 label:@"DataSet 1"];
        set1.axisDependency = AxisDependencyLeft;
        set1.mode = LineChartModeCubicBezier;
        set1.cubicIntensity = 0.2;
        set1.drawCirclesEnabled = NO;
        set1.lineWidth = 1.8;
        set1.circleRadius = 4.0;
        [set1 setCircleColor:UIColor.redColor];
        set1.highlightColor = UIColor.redColor;
        [set1 setColor:UIColor.redColor];
        set1.drawHorizontalHighlightIndicatorEnabled = NO;
        set1.drawHorizontalHighlightIndicatorEnabled = NO;
        set1.drawVerticalHighlightIndicatorEnabled = NO;
        
        NSArray *gradientColors = [[NSArray alloc] init];
        [set1 setCircleColor:UIColor.clearColor];//点颜色
        [set1 setColor:UIColor.clearColor];
        set1.mode = LineChartModeCubicBezier;
        
        gradientColors = @[
            (id)kRGBRandom.CGColor,
            (id)kRGBRandom.CGColor,
            (id)kRGBRandom.CGColor,
        ];
        
        CGGradientRef gradient = CGGradientCreateWithColors(nil, (CFArrayRef)gradientColors, nil);
        set1.fill = [[ChartFill alloc] initWithLinearGradient:gradient angle:90.0f];
        set1.drawFilledEnabled = YES;
        set1.fillAlpha = 1;
        CGGradientRelease(gradient);
        
        [dataSets addObject:set1];
        
    }
    
    LineChartData *data = [[LineChartData alloc] initWithDataSets:dataSets];
    [data setDrawValues:NO];
    
    self.lineChartView.data = data;
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
        [_lineChartView animateWithYAxisDuration:1.5];
        
    }
    return _lineChartView;
}

@end

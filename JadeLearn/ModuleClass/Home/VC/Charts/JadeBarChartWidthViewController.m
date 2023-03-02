//
//  JadeBarChartWidthViewController.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/3/2.
//

#import "JadeBarChartWidthViewController.h"
#import "JadeTimeAxisValueFormatter.h"
@interface JadeBarChartWidthViewController ()
@property (nonatomic, strong) NSDictionary *dataDict;
@end

@implementation JadeBarChartWidthViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self.view addSubview:self.chartView];
    [self.chartView mas_makeConstraints:^(MASConstraintMaker *make) {
        make.centerX.mas_equalTo(self.view.mas_centerX);
        make.centerY.mas_equalTo(self.view.mas_centerY);
        make.height.mas_equalTo(200);
        make.left.right.mas_equalTo(self.view);
    }];
    
    dispatch_time_t time = dispatch_time(DISPATCH_TIME_NOW, 1.5 * NSEC_PER_SEC);
    dispatch_after(time, dispatch_get_main_queue(), ^{
        [self requestData];
    });
}

- (NSDictionary *)dataDict {
    if (!_dataDict) {
        _dataDict = [[NSDictionary alloc] init];
        _dataDict = [JadeTools readLocalFileWithName:@"BarChartWidth"];
    }
    return _dataDict;
}

- (void)requestData {
    
    //6点
    //12点
    NSInteger endTime = [self.dataDict[@"endTime"] integerValue];
    NSInteger startTime = [self.dataDict[@"startTime"] integerValue];
    
    ChartXAxis *xAxis = self.chartView.xAxis;
    double timeRange = endTime + 24*60*60 - startTime;
    int labelCount = (int)(timeRange / 60 / 60 / 2)+1;
    xAxis.axisMinimum = 0;
    xAxis.axisMaximum = timeRange;
    xAxis.granularity = 60*60;
    xAxis.labelCount = 19;
    xAxis.forceLabelsEnabled = NO;
    JadeTimeAxisValueFormatter *timeFormatter = [[JadeTimeAxisValueFormatter alloc] initForChart:self.chartView];
    timeFormatter.labelCount = labelCount;
    timeFormatter.startTime = startTime;
    timeFormatter.endTime = endTime;
    xAxis.valueFormatter = timeFormatter;
    
    NSMutableArray *dataMutableArray = [[NSMutableArray alloc] init];
    NSMutableArray *dataArray = [[NSMutableArray alloc] init];
    dataMutableArray = self.dataDict[@"list"];
    __block double barw = [self.dataDict[@"list"][0][@"start"] integerValue]- [self.dataDict[@"startTime"] integerValue];
    [dataMutableArray enumerateObjectsUsingBlock:^(NSDictionary * _Nonnull obj, NSUInteger idx, BOOL * _Nonnull stop) {
        
        NSMutableArray *yValues = [NSMutableArray array];
        double endTime = [obj[@"end"] doubleValue];
        double startTime = [obj[@"start"] doubleValue];
        if (startTime>endTime) {
            endTime = endTime + 24 * 60 * 60 - startTime;
        }else{
            endTime = endTime - startTime;
        }
        double w = endTime;
        BarChartDataEntry *yEntry;
        if ([obj[@"type"] integerValue]==5) {
            yEntry = [[BarChartDataEntry alloc] initWithX:barw y:100 barWidthSize:w];
        }else if ([obj[@"type"] integerValue]==0){
            yEntry = [[BarChartDataEntry alloc] initWithX:barw y:110 icon:[UIImage imageNamed:@"iconBedExits"] barWidthSize:w];
        }else{
            yEntry = [[BarChartDataEntry alloc] initWithX:barw y:[obj[@"type"] integerValue]*25.0 barWidthSize:w];
        }
        
        [yValues addObject:yEntry];
        
        BarChartDataSet *set = [[BarChartDataSet alloc] initWithEntries:yValues];
        set.axisDependency = AxisDependencyLeft;
        //圆柱边宽。默认0.0
        set.barBorderWidth = 0.1;
        //圆柱边色。默认black
        if ([obj[@"type"] integerValue]==0 || [obj[@"type"] integerValue]==5) {
            [set setColor:RGBA(120, 37, 254, 1)];
            set.barBorderColor = RGBA(120, 37, 254, 1);
        }else {
            set.barBorderColor = RGBA(227, 227, 227, 1);
            [set setColor:RGBA(227, 227, 227, 1)];
        }
        //不在面板上直接显示数值
        set.drawValuesEnabled = NO;
        set.highlightEnabled = NO;
        
        [dataArray addObject:set];
        barw = barw + w;
    }];
    
    // 赋值数据
    BarChartData *data = [[BarChartData alloc] initWithDataSets:dataArray];
    data.barWidth = 1;
    self.chartView.data = data;
    [self.chartView setVisibleXRangeWithMinXRange:60*60*2 maxXRange:60*60*8];
    
}

- (BarChartView *)chartView {
    if (!_chartView) {
        _chartView = [[BarChartView alloc] init];
        [_chartView setExtraOffsetsWithLeft:20 top:8 right:20 bottom:0];
        _chartView.backgroundColor = UIColor.whiteColor;
        _chartView.dragEnabled = YES;//平移拖动。默认 true
        _chartView.noDataText = Local(@"暂无数据");//没有数据时的文字提示
        _chartView.drawValueAboveBarEnabled = NO;//数值显示在柱形的上面还是下面
        _chartView.drawBarShadowEnabled = NO;//是否绘制柱形的阴影背景
        _chartView.scaleYEnabled = NO;//取消Y轴缩放
        _chartView.doubleTapToZoomEnabled = NO;//取消双击缩放
        _chartView.dragDecelerationEnabled = YES;//拖拽后是否有惯性效果
        _chartView.dragDecelerationFrictionCoef = 0.9;//拖拽后惯性效果的摩擦系数(0~1)，数值越小，惯性越不明显

        //x y轴是否支持拖拽
        _chartView.scaleXEnabled = NO;
        _chartView.scaleYEnabled = NO;
        //是否支持xy轴同时缩放
        _chartView.pinchZoomEnabled = NO;
        //是否支持双击缩放
        _chartView.doubleTapToZoomEnabled = NO;
        //高亮点击
        _chartView.highlightPerTapEnabled = NO;
        //高亮拖拽
        _chartView.highlightPerDragEnabled = NO;
        //自动缩放
        _chartView.autoScaleMinMaxEnabled  = NO;
        //启用拖拽
        _chartView.dragEnabled = YES;
        
        ChartXAxis *xAxis = _chartView.xAxis;
        xAxis.drawLabelsEnabled = true;
        xAxis.centerAxisLabelsEnabled = false;
        xAxis.axisLineWidth = 1;//设置X轴线宽
        xAxis.labelPosition = XAxisLabelPositionBottom;//X轴的显示位置，默认是显示在上面的
        xAxis.drawGridLinesEnabled = NO;//不绘制网格线
        xAxis.labelTextColor = UIColor.blackColor;//label文字颜色
        xAxis.labelFont = PingFangRegularFont(12);

        ChartYAxis *leftAxis = _chartView.leftAxis;//获取左边Y轴
        leftAxis.inverted = NO;//是否将Y轴进行上下翻转
        leftAxis.axisLineWidth = 0.5;//Y轴线宽
        leftAxis.axisLineColor = UIColor.whiteColor;//Y轴颜色
        leftAxis.labelTextColor = UIColor.blackColor;
        leftAxis.labelFont = PingFangRegularFont(12);
        leftAxis.gridColor = [UIColor colorWithRed:198/255.0f green:198/255.0f blue:198/255.0f alpha:1];//网格线颜色
        leftAxis.gridAntialiasEnabled = YES;//开启抗锯齿 .
        leftAxis.axisMinimum = 0.0;
        leftAxis.axisMaximum = 125.0;
        [leftAxis setLabelCount:6 force:YES];
        _chartView.rightAxis.enabled = NO;
        leftAxis.drawLabelsEnabled = NO;
        
        _chartView.legend.enabled = NO;//不显示图例说明
    }
    return _chartView;
}

@end

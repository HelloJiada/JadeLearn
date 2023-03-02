//
//  JadeChartsListViewController.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/3/2.
//

#import "JadeChartsListViewController.h"
#import "JadeHomeTopTableViewCell.h"
#import "JadeBarChartWidthViewController.h"
@interface JadeChartsListViewController ()

@end

@implementation JadeChartsListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"动态实现柱状图的宽度 / 根据时间区间设定是否2屏展示并实现拖拽"];
    [self.tableView registerClass:[JadeHomeTopTableViewCell class] forCellReuseIdentifier:@"JadeHomeTopTableViewCell"];
    
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView {
    return 1;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    return self.titleArr.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath {
    return 60;
}

- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath {
    JadeHomeTopTableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"JadeHomeTopTableViewCell"];
    cell.titleLabel.text = [NSString stringWithFormat:@"%@",self.titleArr[indexPath.row]];
    return cell;
}

- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    switch (indexPath.row) {
        case 0:{
            JadeBarChartWidthViewController *vc = [[JadeBarChartWidthViewController alloc] init];
            [[JadeTools getCurrentVC].navigationController pushViewController:vc animated:YES];
        }
            break;
            
        default:
            break;
    }
}


@end

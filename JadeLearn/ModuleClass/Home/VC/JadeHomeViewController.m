//
//  JadeHomeViewController.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/22.
//

#import "JadeHomeViewController.h"
#import "JadeHomeTopTableViewCell.h"
#import "JadeGCDViewController.h"
#import "JadeGCDViewController.h"
#import "JadeChartsListViewController.h"
@interface JadeHomeViewController ()

@end

@implementation JadeHomeViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    self.titleArr = @[@"GCD",@"Charts 之 奇巧淫技"];
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
            JadeGCDViewController *vc = [[JadeGCDViewController alloc] init];
            [[JadeTools getCurrentVC].navigationController pushViewController:vc animated:YES];
        }
            break;
        case 1:{
            JadeChartsListViewController *vc = [[JadeChartsListViewController alloc] init];
            [[JadeTools getCurrentVC].navigationController pushViewController:vc animated:YES];
        }
        default:
            break;
    }
}








@end

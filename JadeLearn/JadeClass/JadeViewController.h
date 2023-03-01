//
//  JadeViewController.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface JadeViewController : UIViewController<UITableViewDelegate, UITableViewDataSource>
@property (nonatomic, strong) UITableView *tableView;
@property (nonatomic, strong) NSArray *titleArr;
- (void)changeTimeLabel;
@end

NS_ASSUME_NONNULL_END

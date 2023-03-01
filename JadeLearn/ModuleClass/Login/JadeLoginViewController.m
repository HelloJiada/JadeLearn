//
//  JadeLoginViewController.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import "JadeLoginViewController.h"
#import "JadeHomeViewController.h"
@interface JadeLoginViewController ()

@end

@implementation JadeLoginViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    
    [self initView];
}

- (void)changeTimeLabel {
    NSLog(@"改变了时间");
    NSInteger timeInteger = [[JadeTools getCurrentTimeWith:JadeGetCurrentTimeStyleH] integerValue];
    NSString *timeStr;
    if (timeInteger >= 1 && timeInteger < 6) {
        timeStr = Local(@"凌晨好!");
    } else if (timeInteger >= 6 && timeInteger < 12){
        timeStr = Local(@"早上好!");
    }else if (timeInteger >= 11 && timeInteger < 14) {
        timeStr = Local(@"中午好!");
    }else if (timeInteger >= 13 && timeInteger < 16) {
        timeStr = Local(@"下午好!");
    }else if (timeInteger >= 16 && timeInteger < 20) {
        timeStr = Local(@"下午好!");
    }else if (timeInteger >= 20 && timeInteger < 24) {
        timeStr = Local(@"晚上好!");
    }
    self.topTimeLabel.text = [NSString stringWithFormat:@"%@\n%@",timeStr,[JadeTools getCurrentTimeWith:JadeGetCurrentTimeStyleYMD]];
}

- (void)initView {
    [self.view addSubview:self.topTimeLabel];
    [self.view addSubview:self.topTitleLabel];
    [self.view addSubview:self.loginBtn];
    
    [self.topTimeLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.centerY.mas_equalTo(self.view.mas_centerY).offset(-kTabBarHeight-150);
    }];
    
    [self.topTitleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset(20);
        make.top.mas_equalTo(self.topTimeLabel.mas_bottom).offset(12);
    }]; 
    
    [self.loginBtn mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.view.mas_left).offset (20);
        make.right.mas_equalTo(self.view.mas_right).offset(-20);
        make.top.mas_equalTo(self.topTitleLabel.mas_bottom).offset(55);
        make.height.mas_equalTo(@45);
    }];
}

#pragma mark - 懒加载
- (UILabel *)topTimeLabel {
    if (!_topTimeLabel){
        _topTimeLabel = [UILabel labelWithTitle:Local(@"") color:UIColor.blackColor font:PingFangBoldFont(24) TextAlignment:NSTextAlignmentLeft NumberOfLines:0];
    }
    return _topTimeLabel;
}

- (UILabel *)topTitleLabel {
    if (!_topTitleLabel){
        _topTitleLabel = [UILabel labelWithTitle:Local(@"欢迎欢迎👏🏻") color:UIColor.blackColor font:PingFangBoldFont(17) TextAlignment:NSTextAlignmentLeft NumberOfLines:0];
    }
    return _topTitleLabel;
}

- (UIButton *)loginBtn {
    if(!_loginBtn) {
        _loginBtn = [UIButton allocButtonWithType:UIButtonTypeCustom buttonNormalStr:Local(@"进入") buttonSelectedStr:Local(@"进入") buttonNormalColor:UIColor.whiteColor buttonSelectedColor:UIColor.whiteColor buttonBackgroundColor:kThemeBackgroundColor buttonFont:PingFangRegularFont(17) cornerRadius:(45/2.f)];
        [_loginBtn addTarget:self action:@selector(clickLoginBtn) forControlEvents:UIControlEventTouchUpInside];
    }
    return _loginBtn;
}

- (void)clickLoginBtn {
    JadeHomeViewController *vc = [[JadeHomeViewController alloc] init];
    [[JadeTools getCurrentVC].navigationController pushViewController:vc animated:YES];
}



@end

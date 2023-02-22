//
//  AppDelegate.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import "AppDelegate.h"
#import "JadeLoginViewController.h"
#import "JadeTabbarController.h"
@interface AppDelegate ()

@end

@implementation AppDelegate


- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // 延迟1秒钟
    [NSThread sleepForTimeInterval:1.0f];
    
    // 获取所有字体
//    [JadeTools getFontNames];
    // 检测网络状态
    [JadeTools openAFNetWorking];
    
    self.window = [[UIWindow alloc] initWithFrame:[UIScreen mainScreen].bounds];
    
    // 添加判断 是否有登陆信息
    if ([[JadeGlobal shareInstance] isLogin]) {
        JadeTabbarController *rootVc = [[JadeTabbarController alloc] init];
        self.window.rootViewController = rootVc;
    }else{
        JadeLoginViewController *rootVc = [[JadeLoginViewController alloc]init];
        JadeNavigationController *rootNav = [[JadeNavigationController alloc] initWithRootViewController:rootVc];
        [self.window setRootViewController:rootNav];
    }
    
    [self.window makeKeyAndVisible];
    return YES;
}


@end

//
//  UIDevice+JadeAddition.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/21.
//

#import "UIDevice+JadeAddition.h"

@implementation UIDevice (JadeAddition)

/// 获取顶部安全区高度
+ (CGFloat)getSafeDistanceTop {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.top;
    } else if (@available(iOS 11.0, *)) {
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return  window.safeAreaInsets.top;
    }
    return 0;
}

/// 获取底部安全区高度
+ (CGFloat)getSafeDistanceBottm {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIWindow *window = windowScene.windows.firstObject;
        return window.safeAreaInsets.bottom;
    } else if (@available(iOS 11.0, *)){
        UIWindow *window = [UIApplication sharedApplication].windows.firstObject;
        return window.safeAreaInsets.bottom;
    }
    return 0;
}

/// 获取顶部状态栏高度 (包括安全区)
+ (CGFloat)getStatusBarHeight {
    if (@available(iOS 13.0, *)) {
        NSSet *set = [UIApplication sharedApplication].connectedScenes;
        UIWindowScene *windowScene = [set anyObject];
        UIStatusBarManager *statusbarManager = windowScene.statusBarManager;
        return statusbarManager.statusBarFrame.size.height;
    } else {
        return  [UIApplication sharedApplication].statusBarFrame.size.height;
    }
}

/// 获取导航栏高度
+ (CGFloat)getNavigationFullHeight {
    return 44.f;
}

/// 获取状态栏 + 导航栏高度
+ (CGFloat)getTabBarHeight {
    return [UIDevice getStatusBarHeight] + [UIDevice getNavigationFullHeight];
}

/// 获取底部导航栏高度 (包括安全区)
+ (CGFloat)getTabBarFullHeight {
    return [UIDevice getTabBarHeight] + [UIDevice getSafeDistanceBottm];
}

@end

//
//  UIDevice+JadeAddition.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/21.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIDevice (JadeAddition)

/// 获取顶部安全区高度
+ (CGFloat)getSafeDistanceTop;

/// 获取底部安全区高度
+ (CGFloat)getSafeDistanceBottm;

/// 获取顶部状态栏高度 (包括安全区)
+ (CGFloat)getStatusBarHeight;

/// 获取导航栏高度
+ (CGFloat)getNavigationFullHeight;

/// 获取状态栏 + 导航栏高度
+ (CGFloat)getTabBarHeight;

/// 获取底部导航栏高度 (包括安全区)
+ (CGFloat)getTabBarFullHeight;
@end

NS_ASSUME_NONNULL_END

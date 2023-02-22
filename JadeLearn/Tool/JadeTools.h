//
//  JadeTools.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import <Foundation/Foundation.h>
#import <UIKit/UIKit.h>
#import <objc/runtime.h>
NS_ASSUME_NONNULL_BEGIN

@interface JadeTools : NSObject

/// 获取SSID信息
+ (id)fetchSSIDInfo;

///  获取当前屏幕展示的vc
+ (UIViewController *)getCurrentVC;

/// 获取所有字体信息
+ (void)getFontNames;

/// 开启网络检测
+ (void)openAFNetWorking;

///
/// - Parameter params:  万能控制器跳转
+ (void)push:(NSDictionary *)params;
@end

NS_ASSUME_NONNULL_END

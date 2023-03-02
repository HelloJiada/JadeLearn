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

typedef NS_ENUM(NSInteger, JadeGetCurrentTimeStyle){//需要了再加吧
    JadeGetCurrentTimeStyleDeflue = 0,
    JadeGetCurrentTimeStyleYMD,
    JadeGetCurrentTimeStyleHHMMSS,
    JadeGetCurrentTimeStyleH,
};

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


/// 获取时间
/// - Parameter styleStr: YYYY - MM - dd HH : mm : ss
+ (NSString *)getCurrentTimeWith:(JadeGetCurrentTimeStyle)styleStr;

// 读取本地Json文件
+ (NSDictionary *)readLocalFileWithName:(NSString *)name;
@end

NS_ASSUME_NONNULL_END

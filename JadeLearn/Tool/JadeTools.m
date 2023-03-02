//
//  JadeTools.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import "JadeTools.h"

#import <SystemConfiguration/SystemConfiguration.h>
#import <SystemConfiguration/CaptiveNetwork.h>
#include <inttypes.h>
#define CRC8INIT 0x00
#define CRC8POLY 0x31 // = X^8+X^5+X^4+X^0

@implementation JadeTools


/// 获取SSID信息
+ (id)fetchSSIDInfo {
    NSArray *ifs = (__bridge_transfer id)CNCopySupportedInterfaces();
    id info = nil;
    for (NSString *ifnam in ifs) {
        info = (__bridge_transfer id)CNCopyCurrentNetworkInfo((__bridge CFStringRef)ifnam);
        
        if (info && [info count]) {
            break;
        }
    }
    return info;
}


///  获取当前屏幕展示的vc
+ (UIViewController *)getCurrentVC{
    UIWindow *window = [[UIApplication sharedApplication] keyWindow];
    if (window.windowLevel != UIWindowLevelNormal) {
        NSArray *windows = [[UIApplication sharedApplication] windows];
        for (UIWindow *tmpWin in windows) {
            if (tmpWin.windowLevel == UIWindowLevelNormal) {
                window = tmpWin;
                break;
            }
        }
    }
    
    UIViewController *result = window.rootViewController;
    while (result.presentedViewController) {
        result = result.presentedViewController;
    }
    
    if ([result isKindOfClass:[UITabBarController class]]) {
        result  = [(UITabBarController *)result selectedViewController];
    }
    
    if ([result isKindOfClass:[UINavigationController class]]) {
        result = [(UINavigationController *)result topViewController];
    }
    return result;
}

/// 获取所有字体信息
+ (void)getFontNames {
    NSArray *familyNames = [UIFont familyNames];
    
    for (NSString *familyName in familyNames) {
        printf("familyNames = %s\n",[familyName UTF8String]);
        
        NSArray *fontNames = [UIFont fontNamesForFamilyName:familyName];
        
        for (NSString *fontName in fontNames) {
            printf("\tfontName = %s\n",[fontName UTF8String]);
        }
    }
}

/// 开启网络检测
+ (void)openAFNetWorking {
    [[AFNetworkReachabilityManager sharedManager] setReachabilityStatusChangeBlock:^(AFNetworkReachabilityStatus status) {
        switch (status) {
            case AFNetworkReachabilityStatusUnknown:
                NSLog(@"未识别的网络");
                break;
            case AFNetworkReachabilityStatusNotReachable:
                NSLog(@"网络未连接");
                break;
            case AFNetworkReachabilityStatusReachableViaWWAN:
                NSLog(@"流量上网");
                break;
            case AFNetworkReachabilityStatusReachableViaWiFi:
                NSLog(@"wifi网络");
                break;
            default:
                break;
        }
    }];
    // 开启监听
    [[AFNetworkReachabilityManager sharedManager] startMonitoring];
}

///
/// - Parameter params:  万能控制器跳转
+ (void)push:(NSDictionary *)params {
    //获取类名
    NSString *class = [NSString stringWithFormat:@"%@",params[@"class"]];
    //把OC的字符串转换成C语言处理的字符
    const char *className = [class cStringUsingEncoding:NSASCIIStringEncoding];
    

    // 把字符名称转换成一个类
    Class newClass = objc_getClass(className);
    if (!newClass) {
        // 创建一个类
        Class superzClass = [NSObject class];
        newClass = objc_allocateClassPair(superzClass, className, 0);// 相当于把一个类,转换成一个对象,这个类相当于这个对象对底层的基类
        // 注册你创建的这个类
        objc_registerClassPair(newClass);
    }
    
    //创建对象
    id instance = [[newClass alloc] init];
    
    NSDictionary *propertys = params[@"property"];
    [propertys enumerateKeysAndObjectsUsingBlock:^(id  _Nonnull key, id  _Nonnull obj, BOOL * _Nonnull stop) {
        if ([self checkIsExistPropertyWithInstance:instance verifyPropertyName:key]) {
            // 利用kvc赋值
            [instance setValue:obj forKey:key];
        }
    }];
    
    [[JadeTools getCurrentVC].navigationController pushViewController:instance animated:YES];
}

+ (BOOL)checkIsExistPropertyWithInstance:(id)instance verifyPropertyName:(NSString *)veriftyPropertyName {
    
    unsigned int outCount, i;
    // class_copyPropertyList 是C语言的api 用来获取协议 或者 类的属性
    // 获取对象的属性列表 objc_property_t这个是C语言 存储数据类的数据(存:字符串,数组,数字都可以) OC语言的字符串是NSArray
    objc_property_t *properties = class_copyPropertyList([instance class], &outCount);
    
    for (i = 0; i < outCount; i++) {
        objc_property_t property = properties[i];
        // 属性名转成字符串 把C语言的字符串数据 转换成OC的字符串
        NSString *propertyName = [[NSString alloc] initWithCString:property_getName(property) encoding:NSUTF8StringEncoding];
        // 判断该属性是否存在
        if ([propertyName isEqualToString:veriftyPropertyName]) {
            free(properties);// 释放内存 C语言Api
            return YES;
        }
    }
    
    return NO;
}

+ (NSString *)getCurrentTimeWith:(JadeGetCurrentTimeStyle)styleStr {
    NSDate *currentDate = [NSDate date];
    NSDateFormatter *dateFromatter = [[NSDateFormatter alloc] init];
    
    switch (styleStr) {
        case JadeGetCurrentTimeStyleDeflue:
            [dateFromatter setDateFormat:@"YYYY - MM - dd HH : mm : ss"];
            break;
        case JadeGetCurrentTimeStyleYMD:
            [dateFromatter setDateFormat:@"YYYY - MM - dd"];
            break;
        case JadeGetCurrentTimeStyleH:
            [dateFromatter setDateFormat:@"HH"];
            break;
        case JadeGetCurrentTimeStyleHHMMSS:
            [dateFromatter setDateFormat:@"HH : mm : ss"];
            break;
        default:
            break;
    }
    NSString *dateStr = [dateFromatter stringFromDate:currentDate];
    return dateStr;
}

+ (NSDictionary *)readLocalFileWithName:(NSString *)name {
    NSString *path = [[NSBundle mainBundle] pathForResource:name ofType:@"json"];
    NSData *data = [[NSData alloc] initWithContentsOfFile:path];
    return  [NSJSONSerialization JSONObjectWithData:data options:kNilOptions error:nil];
}
@end

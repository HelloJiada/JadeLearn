//
//  JadeLocalizationManager.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JadeLocalizationManager : NSObject

/// 获取当前资源文件
+ (NSBundle *)bundle;

/// 初始化语言文件
+ (void)initUserLanguage;

/// 获取应用当前语言
+ (NSString *)getUserLanguage;

///
/// - Parameter language: 设置当前语言
+ (void)setUserLanguage:(NSString *)language;

///
/// - Parameter key: 通过key获取对应的string
+ (NSString *)getStringByKey:(NSString *)key;

/// 获取当前系统语言
+ (NSString *)getSystemLanguage;

///
/// - Parameter language: 语言和语言对应的.lproj的文件夹前缀不一致时在这里做处理
+ (NSString *)languageFormat:(NSString*)language;
@end

NS_ASSUME_NONNULL_END

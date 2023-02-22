//
//  JadeLocalizationManager.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import "JadeLocalizationManager.h"
#import "AppDelegate.h"

@implementation JadeLocalizationManager

static NSBundle *bundle = nil;
static NSString *UserLanguage = @"UserLanguage";

+ (NSBundle *)bundle {
    if (!bundle) {
        [self initUserLanguage];
    }
    return bundle;
}

+ (void)initUserLanguage {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *langStr = [user valueForKey:UserLanguage];
    
    // 获取系统当前语言版本
    NSArray *langArr = [NSLocale preferredLanguages];
    NSString *currentStr = [langArr objectAtIndex:0];
    langStr = [self languageFormat:currentStr];
    
//    //默认设置中文
//    if (![langStr isEqualToString:@"zh-Hans"] && ![string isEqualToString:@"en"]) {
//        langStr = @"zh-Hans";
//    }
    
    [user setValue:langStr forKey:UserLanguage];
    [user synchronize];
    
    // 获取文件路径
    NSString *path = [[NSBundle mainBundle] pathForResource:[self languageFormat:langStr] ofType:@"lproj"];
    // 生成bundle
    bundle = [NSBundle bundleWithPath:path];
}

///
/// - Parameter language: 设置当前语言
+ (void)setUserLanguage:(NSString *)language {
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    NSString *path = [[NSBundle mainBundle] pathForResource:[self languageFormat:language] ofType:@"lproj"];
    bundle = [NSBundle bundleWithPath:path];
    [user setValue:language forKey:UserLanguage];
    [user synchronize];
    
}

/// 语言和语言对应的.lproj的文件夹前缀不一致时在这里做处理
+ (NSString *)getUserLanguage {
    NSString *userlanguage = [[NSUserDefaults standardUserDefaults] objectForKey:UserLanguage];
    return  [self languageFormat:userlanguage];
}


///
/// - Parameter language: 语言和语言对应的.lpro的文件夹前缀不一致时在这里处理
+ (NSString *)languageFormat:(NSString *)language {
    if ([language rangeOfString:@"zh-Hans"].location != NSNotFound) {
        return @"zh-Hans";
    } else if ([language rangeOfString:@"zh-Hant"].location != NSNotFound){
        return @"zh-Hant";
    } else {
        // 字符串查找
        if ([language rangeOfString:@"-"].location != NSNotFound) {
            // 除了中文意外的其他语言 统一处理@"ru_RU" @"ko_KR" 取前面一部分
            NSArray *array = [language componentsSeparatedByString:@"-"];
            if (array.count > 1) {
                NSString *str = array[0];
                return str;
            }
        }
    }
    return language;
}

+ (NSString *)getStringByKey:(NSString *)key {
    if(![[JadeLocalizationManager bundle] localizedStringForKey:key value:@"" table:nil]) {
        return  [[NSBundle mainBundle] localizedStringForKey:key value:@"" table:nil];;
    }
    return [[JadeLocalizationManager bundle] localizedStringForKey:key value:@"" table:nil];;
}

+ (NSString *)getSystemLanguage {
    NSArray *appLanguages = [[NSUserDefaults standardUserDefaults] objectForKey:@"AppleLanguages"];
    NSString *languageName = [appLanguages objectAtIndex:0];
    return languageName;
}



@end

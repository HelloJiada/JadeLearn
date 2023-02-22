//
//  JadeGlobal.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import "JadeGlobal.h"
#import <objc/runtime.h>

@implementation JadeGlobal

@dynamic phone,pwd;

+ (instancetype)shareInstance {
    static JadeGlobal *_instance = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        _instance = [[JadeGlobal alloc] init];
    });
    return _instance;
}

+ (BOOL)resolveInstacenMethod:(SEL)selector {
    NSString *selectorString = NSStringFromSelector(selector);
    if ([selectorString hasPrefix:@"set"]) {
        class_addMethod(self, selector, (IMP)autoDictionarySetter, "v@:@");
    }else{
        class_addMethod(self, selector, (IMP)autoDictionaryGetter, "@@:");
    }
    return YES;
}

id autoDictionaryGetter(id self,SEL _cmd) {
    NSString *key = NSStringFromSelector(_cmd);
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    return [user objectForKey:key];
}

void autoDictionarySetter(id self, SEL _cmd, id value) {
    NSString *selectorString = NSStringFromSelector(_cmd);
    NSMutableString *key = [selectorString mutableCopy];
    
    [key deleteCharactersInRange:NSMakeRange(key.length-1, 1)];
    [key deleteCharactersInRange:NSMakeRange(0, 3)];
    
    NSString *lowercaseFirstChar = [[key substringToIndex:1] lowercaseString];
    [key replaceCharactersInRange:NSMakeRange(0, 1) withString:lowercaseFirstChar];
    
    NSUserDefaults *user = [NSUserDefaults standardUserDefaults];
    if (value) {
        [user setObject:value forKey:key];
    }else{
        [user setObject:value forKey:key];
    }
}
@end

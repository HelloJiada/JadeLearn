//
//  JadeGlobal.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import <Foundation/Foundation.h>

NS_ASSUME_NONNULL_BEGIN

@interface JadeGlobal : NSObject

+ (instancetype)shareInstance;

@property (nonatomic, assign) BOOL isLogin;

@property (nonatomic, copy) NSString *phone;

@property (nonatomic, copy) NSString *pwd;

@end

NS_ASSUME_NONNULL_END

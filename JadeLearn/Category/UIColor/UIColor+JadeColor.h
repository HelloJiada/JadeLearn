//
//  UIColor+JadeColor.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIColor (JadeColor)

+ (instancetype)colorFromHexString:(NSString *)hexString;

@end

NS_ASSUME_NONNULL_END

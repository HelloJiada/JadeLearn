//
//  UIButton+JadeButton.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UIButton (JadeButton)
+ (UIButton *)allocButtonWithType:(UIButtonType)buttonType buttonNormalStr:(NSString *)buttonNormalStr buttonSelectedStr:(NSString *)buttonSelectedStr buttonNormalColor:(UIColor *)buttonNormalColor buttonSelectedColor:(UIColor *)buttonSelectedColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor buttonFont:(UIFont *)buttonFont cornerRadius:(NSInteger)cornerRadius;
@end

NS_ASSUME_NONNULL_END

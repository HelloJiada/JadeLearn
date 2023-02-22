//
//  UIButton+JadeButton.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import "UIButton+JadeButton.h"

@implementation UIButton (JadeButton)
+ (UIButton *)allocButtonWithType:(UIButtonType)buttonType buttonNormalStr:(NSString *)buttonNormalStr buttonSelectedStr:(NSString *)buttonSelectedStr buttonNormalColor:(UIColor *)buttonNormalColor buttonSelectedColor:(UIColor *)buttonSelectedColor buttonBackgroundColor:(UIColor *)buttonBackgroundColor buttonFont:(UIFont *)buttonFont cornerRadius:(NSInteger)cornerRadius {
    UIButton *button = [UIButton buttonWithType:buttonType];
    button.adjustsImageWhenHighlighted = NO;
    [button setTitle:buttonNormalStr forState:UIControlStateNormal];
    [button setTitle:buttonSelectedStr forState:UIControlStateSelected];
    [button setTitleColor:buttonNormalColor forState:UIControlStateNormal];
    [button setTitleColor:buttonSelectedColor forState:UIControlStateSelected];
    button.backgroundColor = buttonBackgroundColor;
    button.titleLabel.font = buttonFont;
    if (cornerRadius > 0) {
        button.layer.cornerRadius = cornerRadius;
        button.layer.masksToBounds = YES;
    }
    return button;
}
@end

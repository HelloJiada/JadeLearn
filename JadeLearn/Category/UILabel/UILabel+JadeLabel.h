//
//  UILabel+JadeLabel.h
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import <UIKit/UIKit.h>

NS_ASSUME_NONNULL_BEGIN

@interface UILabel (JadeLabel)

///
/// - Parameters:
///   - title: 内容
///   - color: 字体颜色
///   - font: 字体大小
///   - textAlignment: 字体
///   - numberOfLines: 字体换行
+ (UILabel *)labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font TextAlignment:(NSTextAlignment)textAlignment NumberOfLines:(NSInteger)numberOfLines;

///
/// - Parameters:
///   - textArr: 内容数组
///   - textColor: 不同颜色
///   - textFont: 不同字体大小
+ (NSAttributedString *)jade_getAttStr:(NSArray *)textArr textColor:(NSArray *)textColor textFont:(NSArray *)textFont;



@end

NS_ASSUME_NONNULL_END

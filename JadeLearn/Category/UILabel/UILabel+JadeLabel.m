//
//  UILabel+JadeLabel.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/17.
//

#import "UILabel+JadeLabel.h"

@implementation UILabel (JadeLabel)

+ (UILabel *)labelWithTitle:(NSString *)title color:(UIColor *)color font:(UIFont *)font TextAlignment:(NSTextAlignment)textAlignment NumberOfLines:(NSInteger)numberOfLines {
    UILabel *label = [[UILabel alloc] init];
    label.textColor = color;
    label.text = title;
    label.font = font;
    label.numberOfLines = numberOfLines;
    label.textAlignment = textAlignment;
    return label;
}

+(NSAttributedString *)jade_getAttStr:(NSArray *)textArr textColor:(NSArray *)textColor textFont:(NSArray *)textFont{
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc]init];
    
    for (int i = 0; i < textArr.count; i ++) {
        UIColor *color = textColor[i];
        if ([textColor[i] isKindOfClass:[NSString class]]) {
            color = JadeColor(textColor[i]);
        }
        
        UIFont *font = textFont[i];
        if (![textFont[i] isKindOfClass:[UIFont class]]){
            font = [UIFont systemFontOfSize:[textFont[i] floatValue]];
        }
        
        NSAttributedString *att = [[NSAttributedString alloc]initWithString:textArr[i] attributes:@{NSForegroundColorAttributeName:color,NSFontAttributeName:font}];
        [attStr appendAttributedString:att];
    }
    
    
    return attStr;
}

@end

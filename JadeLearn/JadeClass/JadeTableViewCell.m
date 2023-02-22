//
//  JadeTableViewCell.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/22.
//

#import "JadeTableViewCell.h"

@implementation JadeTableViewCell

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier {
    if (self = [super initWithStyle:style reuseIdentifier:reuseIdentifier]) {
        self.selectionStyle = UITableViewCellStyleDefault;
        self.backgroundColor = UIColor.whiteColor;
    }
    return self;
}

@end

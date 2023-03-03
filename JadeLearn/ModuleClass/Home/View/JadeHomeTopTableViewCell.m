//
//  JadeHomeTopTableViewCell.m
//  JadeLearn
//
//  Created by 陈佳达 on 2023/2/22.
//

#import "JadeHomeTopTableViewCell.h"

@implementation JadeHomeTopTableViewCell

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
        [self initView];
    }
    return self;
}

- (void)initView {
    
    [self.contentView addSubview:self.titleLabel];
    
    [self.titleLabel mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.centerY.mas_equalTo(self.contentView.mas_centerY);
    }];
    
    [self.contentView addSubview:self.bottomLine];
    [self.bottomLine mas_makeConstraints:^(MASConstraintMaker *make) {
        make.left.mas_equalTo(self.contentView.mas_left).offset(20);
        make.height.mas_equalTo(0.5);
        make.right.mas_equalTo(self.contentView.mas_right).offset(-20);
        make.bottom.mas_equalTo(self.contentView.mas_bottom);
    }];
    
}

- (UILabel *)titleLabel {
    if (!_titleLabel) {
        _titleLabel = [UILabel labelWithTitle:@"" color:UIColor.blackColor font:PingFangRegularFont(14) TextAlignment:NSTextAlignmentLeft NumberOfLines:0];
    }
    return _titleLabel;
}

- (UIView *)bottomLine {
    if (!_bottomLine) {
        _bottomLine = [UIView new];
        _bottomLine.backgroundColor = UIColor.lightGrayColor;
    }
    return _bottomLine;
}

@end

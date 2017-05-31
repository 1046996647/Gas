//
//  UserIDCell.m
//  Gas
//
//  Created by 张伟良 on 17/5/22.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "UserIDCell.h"

@implementation UserIDCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _delBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _delBtn.frame = CGRectMake(self.contentView.width-10, 0, 40, 40);
        [_delBtn setTitleColor:[UIColor colorWithHexString:@"#efeff4"] forState:UIControlStateNormal];
//        _delBtn.backgroundColor = [UIColor cyanColor];
        [_delBtn setTitle:@"x" forState:UIControlStateNormal];
        [self.contentView addSubview:_delBtn];
    }
    return self;
}

- (void)awakeFromNib {
    [super awakeFromNib];
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

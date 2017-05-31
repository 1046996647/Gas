//
//  PayWayCell.m
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "PayWayCell.h"

@implementation PayWayCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(12, 15, 30, 30)];
        [self.contentView addSubview:_imgView];
        
        _payBtn = [UIButton buttonWithType:UIButtonTypeCustom];
        _payBtn.frame = CGRectMake(kScreen_Width-30-20, 15, 30, 30);
        [_payBtn setImage:[UIImage imageNamed:@"1-3"] forState:UIControlStateNormal];
        [_payBtn setImage:[UIImage imageNamed:@"1-7"] forState:UIControlStateSelected];
        [self.contentView addSubview:_payBtn];

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

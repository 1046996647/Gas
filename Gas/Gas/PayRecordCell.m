//
//  PayRecordCell.m
//  Gas
//
//  Created by 张伟良 on 17/5/25.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "PayRecordCell.h"
#import "NSStringExt.h"

@implementation PayRecordCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 20, 50, 20)];
//        _lab1.font = [UIFont systemFontOfSize:15];
        _lab1.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab1];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(12, _lab1.bottom+5, 50, 14)];
        _lab2.font = [UIFont systemFontOfSize:13];
        _lab2.textColor = [UIColor grayColor];
        [self.contentView addSubview:_lab2];
        
        _imgView = [[UIImageView alloc] initWithFrame:CGRectMake(_lab2.right+10, 0, 30, 80)];
        _imgView.image = [UIImage imageNamed:@"0-1"];
        _imgView.contentMode = UIViewContentModeScaleAspectFit;
        [self.contentView addSubview:_imgView];
        
        _lab3 = [[UILabel alloc] initWithFrame:CGRectMake(_imgView.right+30, 15, 200, 20)];
//        _lab3.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_lab3];
        
        _lab4 = [[UILabel alloc] initWithFrame:CGRectMake(_lab3.left, _lab3.bottom, kScreen_Width-_lab3.left-20, 35)];
        _lab4.font = [UIFont systemFontOfSize:13];
        _lab4.numberOfLines = 2;
        _lab4.textColor = [UIColor grayColor];
//        _lab2.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lab4];
        
        
    }
    return self;
}

- (void)setModel:(PayRecordModel *)model
{
    _model = model;
    
    _lab1.text = [NSString dateToWeek:model.fullPayTime];
    _lab2.text = [model.fullPayTime substringFromIndex:5];

    _lab3.text = model.payableAmount;
    _lab4.text = [NSString stringWithFormat:@"交易流水号 : %@",model.payId];
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

//
//  UsageDetailCell.m
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "UsageDetailCell.h"
#import "NSStringExt.h"

@implementation UsageDetailCell

- (instancetype)initWithStyle:(UITableViewCellStyle)style reuseIdentifier:(NSString *)reuseIdentifier
{
    self = [super initWithStyle:style reuseIdentifier:reuseIdentifier];
    if (self) {
        
        _lab1 = [[UILabel alloc] initWithFrame:CGRectMake(12, 15, kScreen_Width-24, 16)];
        _lab1.font = [UIFont systemFontOfSize:15];
        [self.contentView addSubview:_lab1];
        
        _lab2 = [[UILabel alloc] initWithFrame:CGRectMake(14, _lab1.bottom+5, kScreen_Width-28, 16)];
        _lab2.font = [UIFont systemFontOfSize:15];
        _lab2.textAlignment = NSTextAlignmentRight;
        [self.contentView addSubview:_lab2];
        
        _slider = [[ZwlSlider alloc] initWithFrame:CGRectMake(12, _lab2.bottom+15, kScreen_Width-24, 0)];
        //设置轨道的图片
//        [_slider setMinimumTrackImage:[UIImage imageNamed:@"maxImg"] forState:UIControlStateNormal];
//        [_slider setMaximumTrackImage:[UIImage imageNamed:@"maxImg"] forState:UIControlStateNormal];
        [self.contentView addSubview:_slider];
        
    }
    return self;
}

- (void)setModel:(UsageDetailModel *)model
{
    _model = model;
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"第%@阶梯  单价 : %@元/方",[NSString translationArabicNum:model.ladderNo.integerValue], model.price]];
    NSRange range1 = {6,[attStr length]-6};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#EF9B39"] range:range1];
    _lab1.attributedText = attStr;
    
    NSString *str1 = model.currentVolume;
    NSString *str2 = model.maxVolume;
    NSMutableAttributedString *attStr1 = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"余量%@方/总计%@方",str1, str2]];
    // 数字部分是汉子长度
    NSRange range2 = {2,[str1 length]};
    NSRange range3 = {[str1 length]+6,[str2 length]};
    [attStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#35742C"] range:range2];
    [attStr1 addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#35742C"] range:range3];
    _lab2.attributedText = attStr1;
    
    float per = model.currentVolume.floatValue/model.maxVolume.floatValue;
    _slider.value = per;
    
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

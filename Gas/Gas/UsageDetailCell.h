//
//  UsageDetailCell.h
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "UsageDetailModel.h"
#import "ZwlSlider.h"

@interface UsageDetailCell : UITableViewCell

@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) ZwlSlider *slider;
@property(nonatomic,strong) UsageDetailModel *model;

@end

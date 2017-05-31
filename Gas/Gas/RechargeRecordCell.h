//
//  RechargeRecordCell.h
//  Gas
//
//  Created by ZhangWeiLiang on 2017/5/31.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeModel.h"


@interface RechargeRecordCell : UITableViewCell

@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab4;
@property(nonatomic,strong) UILabel *lab5;
@property(nonatomic,strong) RechageRecordModel *model;

@end

//
//  PayRecordCell.h
//  Gas
//
//  Created by 张伟良 on 17/5/25.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TimeModel.h"


@interface PayRecordCell : UITableViewCell

@property(nonatomic,strong) UILabel *lab1;
@property(nonatomic,strong) UILabel *lab2;
@property(nonatomic,strong) UIImageView *imgView;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab4;
@property(nonatomic,strong) PayRecordModel *model;

@end

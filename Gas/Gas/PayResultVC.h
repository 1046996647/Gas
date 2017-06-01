//
//  PayResultVC.h
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "ViewController.h"
#import "UserInfoModel.h"


@interface PayResultVC : ViewController

// 后、预付费标记
@property(nonatomic,assign) NSInteger mark;

// 缴费方式
@property(nonatomic,copy) NSString *type;

@property(nonatomic,strong) PaymentModel *payModel;

@end

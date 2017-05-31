//
//  ICUsageDetailVC.h
//  Gas
//
//  Created by ZhangWeiLiang on 2017/5/26.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "ViewController.h"

typedef void (^CalculateBlock)(NSString *volume, NSString *money);
@interface ICUsageDetailVC : ViewController

@property(nonatomic,strong) NSString *volume;
@property(nonatomic,copy) CalculateBlock calculateBlock;


@end

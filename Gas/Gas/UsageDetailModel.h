//
//  UsageDetailModel.h
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "BaseModel.h"

@interface UsageDetailModel : BaseModel

/*
CustomerNo 客户编号
CustomerName 客户名称
fluidNo 价格编号
ladderNo 阶梯号（1-5）
price单价
customerNo 用户编号
customerName用户名称
maxVolume 本阶梯最大用量
currentVolume本阶梯剩余用量
StartTime 周期起始时间
EndTime 周期结束时间
 
 
 currentVolume = 0;
 customerNo = 0000000624;
 endTime = "2017-11-16T11:14:58";
 fluidNo = 0000000001;
 ladderNo = 1;
 maxVolume = "1234.000";
 price = "1.100";
 startTime = "2016-11-16T11:14:58";
*/

@property(nonatomic,copy) NSString *price;
@property(nonatomic,copy) NSString *endTime;
@property(nonatomic,copy) NSString *startTime;
@property(nonatomic,copy) NSString *maxVolume;
@property(nonatomic,copy) NSString *currentVolume;
@property(nonatomic,strong) NSNumber *ladderNo;

@end

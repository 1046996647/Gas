//
//  PayRecordModel.m
//  Gas
//
//  Created by 张伟良 on 17/5/25.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "TimeModel.h"

@implementation TimeModel



- (instancetype)init
{
    self = [super init];
    if (self) {
        self.headCellArray = [NSMutableArray array];
    }
    return self;
}

@end

@implementation PayRecordModel



- (instancetype)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self) {
        
        self.fullPayTime = dic[@"payTime"];
        self.fullPayTime = [self.fullPayTime substringToIndex:10];
        self.payTime = dic[@"payTime"];
        self.payTime = [self.fullPayTime substringToIndex:7];
    }
    return self;
}

@end

@implementation RechageRecordModel



- (instancetype)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self) {
        
        self.fullPayTime = dic[@"chargeTime"];
        self.fullPayTime = [self.fullPayTime substringToIndex:10];
        self.chargeTime = dic[@"chargeTime"];
        self.chargeTime = [self.fullPayTime substringToIndex:7];
    }
    return self;
}

@end

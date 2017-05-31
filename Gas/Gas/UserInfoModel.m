//
//  PaymentModel.m
//  Gas
//
//  Created by 张伟良 on 17/5/23.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "UserInfoModel.h"

@implementation UserInfoModel

@end

@implementation PaymentModel

- (instancetype)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self) {
        self.cameraId = dic[@"copyId"];
    }
    return self;
}

@end

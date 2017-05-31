//
//  UsageDetailModel.m
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "UsageDetailModel.h"

@implementation UsageDetailModel

- (instancetype)initWithContentsOfDic:(NSDictionary *)dic
{
    self = [super initWithContentsOfDic:dic];
    if (self) {
        self.startTime = dic[@"startTime"];
        self.startTime = [self.startTime substringToIndex:10];
        self.startTime = [self tranlationDate:self.startTime];
        
        self.endTime = dic[@"endTime"];
        self.endTime = [self.endTime substringToIndex:10];
        self.endTime = [self tranlationDate:self.endTime];

    }
    return self;
}

- (NSString *)tranlationDate:(NSString *)string
{
    NSDateFormatter *inputFormatter = [[NSDateFormatter alloc] init];
    [inputFormatter setDateFormat:@"yyyy-MM-dd"];
    NSDate *inputDate = [inputFormatter dateFromString:string];
    
    NSDateFormatter *outputFormatter = [[NSDateFormatter alloc] init];
    [outputFormatter setDateFormat:@"yyyy年MM月dd日"];
    string = [outputFormatter stringFromDate:inputDate];
    return string;
}

@end

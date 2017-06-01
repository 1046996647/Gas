//
//  UrlHelp.h
//  Gas
//
//  Created by 张伟良 on 17/5/23.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import <Foundation/Foundation.h>

#define BaseURL @"http://61.164.45.100:666/"


// ---------------------后付费部分-------------------------

// 通过通讯编号查询用户基本信息
#define GetUserList @"GetUserList"

// 通过通讯编号查询用户需缴费情况
#define GetListByCommunicateNo @"GetListByCommunicateNo"

// 通过ID查询对应的摄像表历史记录(获取图片路径)
#define GetCameGetImageNameById @"GetCameGetImageNameById"

// 通过通讯编号查询用户当前阶梯使用量明细
#define GetLVAllByCommunicateNo @"GetLVAllByCommunicateNo"

// 用户缴费
#define Recharge @"Recharge"

// 通过通讯编号查询缴费记录
#define GetPayByCommunicateNo @"GetPayByCommunicateNo"


// ---------------------预付费部分-------------------------
// 通过表计编号查询用户基本信息
#define GetICUserList @"GetICUserList"

// 通过表计编号查询用户当前阶梯剩余量信息
#define GetLVAllByMeterNo @"GetLVAllByMeterNo"

// 根据输入购气量计算金额
#define ToMoney @"ToMoney"

// 查询IC卡用户充值记录
#define GetICPayByMeterNo @"GetICPayByMeterNo"

@interface UrlHelp : NSObject

@end

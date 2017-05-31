//
//  PaymentModel.h
//  Gas
//
//  Created by 张伟良 on 17/5/23.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "BaseModel.h"

@interface UserInfoModel : BaseModel

/*
 customerNo 客户编号
 customerType 客户类型(0-民用,1-公建,2-工业)
 customerName 客户名称
 telNo 固定电话号码
 mobileNo 移动电话号码
 certNo 证件号码(默认为身份证号)
 Address 详细地址
 meterTypeNo 表具类型(05-无线表、10-摄像表）
 factoryNo表计厂家编号
 
 
 UsersList =                 {
 address = "\U91d1\U8272\U6c34\U5cb85-2-401";
 customerName = "\U6d4b\U8bd5\U7528\U623701";
 customerNo = 0000000624;
 customerType = 0;
 factoryNo = 03;
 meterTypeNo = 10;
 };
 */

@property(nonatomic,copy) NSString *address;
@property(nonatomic,copy) NSString *customerName;
@property(nonatomic,strong) NSNumber *customerNo;
@property(nonatomic,strong) NSNumber *customerType;
@property(nonatomic,strong) NSNumber *factoryNo;
@property(nonatomic,strong) NSNumber *meterTypeNo;


@end

@interface PaymentModel : BaseModel

/*
 Id 结算id
 accPeriod 帐期
 meterNo 表计编号
 customerNo 客户编号
 lastRead 上次抄表读数
 currentRead 本次抄表读数
 currentVolume 本次实用气量 （即本次消费量）
 unitPrice 单价
 payableAmount 应缴金额
 payableDate 应缴日期 （缴费期限）
 lateFeeEnable 是否计算滞纳金(0不计算1计算)
 lateRate 滞纳金利率
 bonusDays 滞纳金优惠天数
 calcType 计算方式0-不计算复利 1-计算复利
 limitType 上限类型0-无上限1-本金的倍数 2-自定义
 ratio 本金的倍数系数
 defLimit 自定义的滞纳金上限值
 lateDays 已滞纳天数
 lateFee 滞纳金
 actualAmount 实付金额
 payState 支付状态(0未付 1已付 2部分支付)
 payWay 支付方式(0现金支付 1银行扣款2一户通扣款 5-支付宝支付 6-微信支付)
 copyWay 抄表方式(S无线抄表 M人工输入抄表 G估抄)
 withholdingState 银行扣款状态
 balanceOperator 结算操作员
 balanceTime 操作时间
 payOperator 付款操作员
 payTime 付款时间
 payBranchNo 付款营业厅编号
 payPosNo 付款终端编号
 ReceiptNo 收款明细单流水号、Remark 备注
 copyTime 抄表时间、copyMan 抄表员姓名
 copyId 对应抄表历史数据表中ID （即接口3的CameraId）

 */

@property(nonatomic,copy) NSString *currentRead;
@property(nonatomic,copy) NSString *payableAmount;
@property(nonatomic,strong) NSNumber *cameraId;
//@property(nonatomic,strong) NSNumber *cameraId;
//@property(nonatomic,strong) NSNumber *customerType;
//@property(nonatomic,strong) NSNumber *factoryNo;
//@property(nonatomic,strong) NSNumber *meterTypeNo;


@end

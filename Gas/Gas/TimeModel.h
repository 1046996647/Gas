//
//  PayRecordModel.h
//  Gas
//
//  Created by 张伟良 on 17/5/25.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "BaseModel.h"

@interface TimeModel : BaseModel


@property(nonatomic,copy) NSString *timeStr;
@property(nonatomic,strong) NSMutableArray *headCellArray;



@end

@interface PayRecordModel : BaseModel

/*
ReceiptNo = 70;
Remark = 12345678901234567890;
actualAmount = "2162.600";
balanceTime = "2017-04-12T16:07:44.567";
bonusDays = 0;
calcType = 0;
copyId = 3431;
copyWay = S;
copytime = "2017-04-05T03:17:44";
currentRead = "732.000";
currentVolume = "732.000";
customerNo = 0000000676;
defLimit = "0.00000";
lastRead = "0.000";
lateDays = 0;
lateFee = "0.000";
lateFeeEnable = 0;
lateRate = "0.00000";
limitType = 0;
meterNo = 0000000358;
payId = 12345678901234567890;
payOperator = "\U624b\U673a\U652f\U4ed8\U5b9d\U652f\U4ed8";
payState = 1;
payTime = "2017-04-13T10:31:36";
payWay = 5;
payableAmount = "2162.600";
payableDate = "2017-04-12T23:59:59";
ratio = "0.00000";
unitPrice = "1.100";
withholdingState = 0;
*/

// 后付费
@property(nonatomic,copy) NSString *payTime;
@property(nonatomic,copy) NSString *fullPayTime;
@property(nonatomic,copy) NSString *payableAmount;
@property(nonatomic,copy) NSString *payId;



@end


// 预付费
@interface RechageRecordModel : BaseModel


@property(nonatomic,copy) NSString *chargeVolume;
@property(nonatomic,copy) NSString *chargeMoney;
@property(nonatomic,copy) NSString *chargeTime;
@property(nonatomic,copy) NSString *fullPayTime;
@property(nonatomic,copy) NSString *payId;



@end

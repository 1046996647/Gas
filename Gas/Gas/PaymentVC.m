//
//  PaymentVC.m
//  Gas
//
//  Created by 张伟良 on 17/5/23.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "PaymentVC.h"
#import "ImmediatelyPayVC.h"
#import "UsageDetailVC.h"
#import "PayRecordVC.h"


@interface PaymentVC ()
{
    MBProgressHUD *_hud;
}

@property(nonatomic,strong) PaymentModel *payModel;
@property(nonatomic,strong) UIImageView *meterType;
@property(nonatomic,strong) UILabel *lab5;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab4;
@property(nonatomic,strong) UIButton *btn2;
@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UIView *view1;
@property(nonatomic,strong) UIScrollView *scrView;


@end

@implementation PaymentVC

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"XX在线燃气费用";

    
    [self initSubviews];
    [self initRightItem];

    [self requestData];

}

- (void)initRightItem
{
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 70, 30);
    [btn2 addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"缴费记录" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn2 setTitleColor:[UIColor colorWithHexString:@"#0D60FA"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
}

- (void)recordAction
{
    PayRecordVC *vc = [[PayRecordVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 请求网络
- (void)requestData
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *userID = [InfoCache getUserID];
    NSArray *array = @[@{@"communicateNo":userID}];
    [HttpTools postWithURL:BaseURL arrays:array method:GetListByCommunicateNo success:^(id JSON) {
        
        _hud.hidden = YES;
        
        id obj = JSON[@"soap:Body"][@"GetListByCommunicateNoResponse"][@"GetListByCommunicateNoResult"][@"BalanceFee"];
        
        if (obj) {
            
            // 可能返回数据的问题，加个判断
            if ([obj isKindOfClass:[NSArray class]]) {
                obj = [obj firstObject];
            }
            
            PaymentModel *model = [[PaymentModel alloc] initWithContentsOfDic:obj];
            _payModel = model;
            
            // 燃气费显示
            NSString *str1 = self.payModel.currentRead;
            NSString *str2 = self.payModel.payableAmount;
            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"本期燃气消费量%@立方,燃气费%@元",str1, str2]];
            // 数字部分是汉子长度
            NSRange range1 = {7,[str1 length]};
            NSRange range2 = {[str1 length]+13,[str2 length]};
            [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#EF9B39"] range:range1];
            [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#EF9B39"] range:range2];
            self.lab5.attributedText = attStr;
            
            
            // 获取图片路径
            [self getCamera];
        }
        else {
            // 不欠费
            self.lab4.hidden = YES;
            self.meterType.hidden = YES;
            self.lab5.hidden = YES;
            self.view1.top = self.lab3.bottom+20;
            self.baseView.height = self.view1.bottom+20;
            self.scrView.contentSize = CGSizeMake(kScreen_Width, self.baseView.height+64);

            
            self.btn2.userInteractionEnabled = NO;
            self.btn2.backgroundColor = [UIColor clearColor];
            [self.btn2 setTitle:@"暂无欠费记录" forState:UIControlStateNormal];
            [self.btn2 setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }

        
    } failure:^(NSError *error) {
        _hud.hidden = YES;
    }];
    
}

- (void)getCamera
{
    NSArray *array = @[@{@"CameraId":_payModel.cameraId}];
    [HttpTools postWithURL:BaseURL arrays:array method:GetCameGetImageNameById success:^(id JSON) {
        
        NSString *imgStr = JSON[@"soap:Body"][@"GetCameGetImageNameByIdResponse"][@"GetCameGetImageNameByIdResult"][@"imageName"];
        imgStr = [NSString stringWithFormat:@"%@/%@",BaseURL, imgStr];
        [_meterType sd_setImageWithURL:[NSURL URLWithString:imgStr]];
        
    } failure:^(NSError *error) {
        _hud.hidden = YES;
    }];
}

- (void)initSubviews
{
    UIScrollView *scrView = [[UIScrollView alloc] initWithFrame:self.view.bounds];
    [self.view addSubview:scrView];
    self.scrView = scrView;
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    view.backgroundColor = [UIColor whiteColor];
    [scrView addSubview:view];
    self.baseView = view;
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(20, 30, 30, 30)];
    imgView.image = [UIImage imageNamed:@"0-1"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:imgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(imgView.right+10, 30, 100, 30)];
    lab.text = @"燃气费";
    lab.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view addSubview:lab];
    
    UIButton *setBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    setBtn.frame = CGRectMake(kScreen_Width-50, lab.center.y-10, 20, 20);
    [setBtn setImage:[UIImage imageNamed:@"1-1"] forState:UIControlStateNormal];
    [view addSubview:setBtn];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, imgView.bottom+30, kScreen_Width, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view addSubview:line1];
    
    UILabel *lab1 = [[UILabel alloc] initWithFrame:CGRectMake(12, line1.bottom+20, kScreen_Width-24, 16)];
    lab1.text = [NSString stringWithFormat:@"用户编号 : %@",self.model.customerNo];
    lab1.font = [UIFont systemFontOfSize:15];
    lab1.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view addSubview:lab1];
    
    UILabel *lab2 = [[UILabel alloc] initWithFrame:CGRectMake(12, lab1.bottom+20, kScreen_Width-24, 16)];
    lab2.text = [NSString stringWithFormat:@"用户名称 : %@",self.model.customerName];
    lab2.font = [UIFont systemFontOfSize:15];
    lab2.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view addSubview:lab2];
    
    UILabel *lab3 = [[UILabel alloc] initWithFrame:CGRectMake(12, lab2.bottom+20, kScreen_Width-24, 16)];
    lab3.text = [NSString stringWithFormat:@"用户地址 : %@",self.model.address];
    lab3.font = [UIFont systemFontOfSize:15];
    lab3.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view addSubview:lab3];
    self.lab3 = lab3;
    
    
    // meterTypeNo 表具类型(05-无线表、10-摄像表）
    UILabel *lab4 = [[UILabel alloc] initWithFrame:CGRectMake(12, lab3.bottom+20, kScreen_Width-24, 16)];
    lab4.text = @"本次抄表图片 : ";
    lab4.font = [UIFont systemFontOfSize:15];
    lab4.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view addSubview:lab4];
    self.lab3 = lab3;

    
    UIImageView *meterType = [[UIImageView alloc] initWithFrame:CGRectMake(0, lab4.bottom+20, kScreen_Width, 40)];
    //    meterType.image = [UIImage imageNamed:@"0-1"];
//    meterType.backgroundColor = [UIColor redColor];
    meterType.contentMode = UIViewContentModeScaleAspectFit;
    [view addSubview:meterType];
    self.meterType = meterType;
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(12, meterType.bottom+20, kScreen_Width-24, 16)];
    lab5.font = [UIFont systemFontOfSize:15];
    lab5.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view addSubview:lab5];
    self.lab5 = lab5;
    
    // 表具类型
    if (10 != self.model.meterTypeNo.integerValue) {
        lab4.hidden = YES;
        meterType.hidden = YES;
        lab5.top = lab3.bottom+20;
    }
//    else {
//        
//    }
    
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, lab5.bottom+20, kScreen_Width, 0)];
    view1.backgroundColor = [UIColor whiteColor];
    [view addSubview:view1];
    self.view1 = view1;

    
    UILabel *payCompany = [[UILabel alloc] initWithFrame:CGRectMake(12, 0, kScreen_Width-24, 16)];
    payCompany.text = @"缴费单位";
    payCompany.font = [UIFont systemFontOfSize:15];
    payCompany.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view1 addSubview:payCompany];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(50, payCompany.bottom+40, kScreen_Width-100, 40);
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds = YES;
    [btn2 addTarget:self action:@selector(payAction) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"立即缴费" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor colorWithHexString:@"#55B810"];
    [view1 addSubview:btn2];
    self.btn2 = btn2;
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, btn2.bottom+40, kScreen_Width, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view1 addSubview:line2];
    
    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(12, line2.bottom+20, kScreen_Width-24, 50)];
    lab6.text = @"提示 ：请在15天内缴纳燃气费，如已缴纳或已办理支付托收手续，敬请忽略。贵户当前用气处于第一档，剩余。";
    lab6.numberOfLines = 2;
    lab6.font = [UIFont systemFontOfSize:13];
    lab6.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view1 addSubview:lab6];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(12, lab6.bottom+15, 130, 16);
    [btn3 addTarget:self action:@selector(checkAction) forControlEvents:UIControlEventTouchUpInside];
    //    [btn3 setTitleColor:[UIColor colorWithHexString:@"#0D60FA"] forState:UIControlStateNormal];
    btn3.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn3 setTitle:@"查询阶梯使用明细" forState:UIControlStateNormal];
    //    btn3.titleLabel.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:btn3];
    NSMutableAttributedString *str = [[NSMutableAttributedString alloc] initWithString:@"查询阶梯使用明细"];
    NSRange strRange = {0,[str length]};
    [str addAttribute:NSUnderlineStyleAttributeName value:[NSNumber numberWithInteger:NSUnderlineStyleSingle] range:strRange];
    [str addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#0D60FA"] range:strRange];
    [btn3 setAttributedTitle:str forState:UIControlStateNormal];
    
    view1.height = btn3.bottom;
    view.height = view1.bottom+20;
    
    self.scrView.contentSize = CGSizeMake(kScreen_Width, self.baseView.height+64);
    
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 查询阶梯使用明细
- (void)checkAction
{
    UsageDetailVC *vc = [[UsageDetailVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
}

// 缴费
- (void)payAction
{
    ImmediatelyPayVC *vc = [[ImmediatelyPayVC alloc] init];
    vc.model = self.payModel;
    [self.navigationController pushViewController:vc animated:YES];
}

@end

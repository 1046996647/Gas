//
//  CardRechargeVC.m
//  Gas
//
//  Created by 张伟良 on 17/5/26.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "CardRechargeVC.h"
#import "ICUsageDetailVC.h"
#import "ImmediatelyPayVC.h"
#import "RechargeRecordVC.h"

@interface CardRechargeVC ()

@property(nonatomic,strong) UILabel *lab5;
@property(nonatomic,strong) UILabel *lab3;
@property(nonatomic,strong) UILabel *lab6;
@property(nonatomic,strong) UIButton *btn2;
@property(nonatomic,strong) UIView *baseView;
@property(nonatomic,strong) UIView *view1;
@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UIButton *btn3;
@property(nonatomic,strong) UILabel *payLab;
@property(nonatomic,strong) UIButton *btn4;
@property(nonatomic,strong) UIView *line3;
@property(nonatomic,strong) UIScrollView *scrView;


@property(nonatomic,strong) NSString *money;

@end

@implementation CardRechargeVC



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"XX燃气IC卡自助充值";
    
    [self initSubviews];
    
    [self initRightItem];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)initRightItem
{
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(0, 0, 70, 30);
    [btn2 addTarget:self action:@selector(recordAction) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"充值记录" forState:UIControlStateNormal];
    btn2.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn2 setTitleColor:[UIColor colorWithHexString:@"#0D60FA"] forState:UIControlStateNormal];
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:btn2];
}

- (void)recordAction
{
    RechargeRecordVC *vc= [[RechargeRecordVC alloc] init];
    [self.navigationController pushViewController:vc animated:YES];
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
    
    
    UILabel *lab5 = [[UILabel alloc] initWithFrame:CGRectMake(12, lab3.bottom+20, kScreen_Width-24, 16)];
    lab5.font = [UIFont systemFontOfSize:15];
    lab5.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
//    lab5.text = [NSString stringWithFormat:@"卡内金额:"];
    [view addSubview:lab5];
    self.lab5 = lab5;
    
    // 燃气费显示
    NSString *str1 = @"1200";
    NSString *str2 = @"223";
    NSString *str3 = @"23";
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"卡内金额:%@ 卡内气量:%@ 充值次数:%@",str1, str2, str3]];
    // 数字部分是汉子长度
    NSRange range1 = {5,[str1 length]};
    NSRange range2 = {[str1 length]+11,[str2 length]};
    NSRange range3 = {[str1 length]+17+[str2 length],[str3 length]};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#EF9B39"] range:range1];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#EF9B39"] range:range2];    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#EF9B39"] range:range2];
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#EF9B39"] range:range3];    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#EF9B39"] range:range3];
    self.lab5.attributedText = attStr;
    
    
    UILabel *payCompany = [[UILabel alloc] initWithFrame:CGRectMake(12, lab5.bottom+20, kScreen_Width-24, 16)];
    payCompany.text = @"缴费单位";
    payCompany.font = [UIFont systemFontOfSize:15];
    payCompany.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view addSubview:payCompany];
    
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(50, payCompany.bottom+30, kScreen_Width-100, 40);
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds = YES;
    [btn2 addTarget:self action:@selector(readerCard) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"读卡" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor colorWithHexString:@"#55B810"];
    [view addSubview:btn2];
    self.btn2 = btn2;
    
    UIView *line3 = [[UIView alloc] initWithFrame:CGRectMake(0, btn2.bottom+30, kScreen_Width, 1)];
    line3.backgroundColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view addSubview:line3];
    self.line3 = line3;
    
    [self initRechargeViews];
    
    ////////////
//    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(12, view1.bottom+10, kScreen_Width-24, 70)];
    UILabel *lab6 = [[UILabel alloc] initWithFrame:CGRectMake(12, line3.bottom+10, kScreen_Width-24, 70)];
    lab6.text = @"提示 ：充值期间请勿将IC卡拔出读卡器，请保持读卡器在手机3米范围内。如遇到充值问题或需退款，请至营业厅办理。";
    lab6.numberOfLines = 3;
    lab6.font = [UIFont systemFontOfSize:14];
    lab6.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [view addSubview:lab6];
    self.lab6 = lab6;
    

//    view1.height = btn3.bottom;
    view.height = lab6.bottom+10;
}


// 读卡
- (void)readerCard
{
    
    [self.view endEditing:YES];

    self.view1.hidden = NO;
    self.view1.height = 100;
    self.payLab.hidden = YES;
    self.btn4.hidden = YES;
    self.lab6.top = self.view1.bottom+10;
    self.baseView.height = self.lab6.bottom+10;

    self.scrView.contentSize = CGSizeMake(kScreen_Width, self.baseView.height+64);

}


- (void)initRechargeViews
{
    /////////////
    UIView *view1 = [[UIView alloc] initWithFrame:CGRectMake(0, self.btn2.bottom+30-1, kScreen_Width, 100+40)];
    //    view1.backgroundColor = [UIColor whiteColor];
    view1.layer.borderWidth = 1;
    view1.layer.borderColor = [UIColor colorWithHexString:@"#A1A2A4"].CGColor;
//    view1.clipsToBounds = YES;
    view1.hidden = YES;
    [self.baseView addSubview:view1];
    self.view1 = view1;
    
    // 灰条
    UIView *grayView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 20)];
    grayView.backgroundColor = [UIColor colorWithHexString:@"#F2F4F8"];
    [view1 addSubview:grayView];
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(12, grayView.bottom+30, 230, 16)];
    numLab.font = [UIFont systemFontOfSize:15];
    numLab.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    numLab.text = [NSString stringWithFormat:@"充值数量 :                        方"];
    [view1 addSubview:numLab];
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(90, grayView.bottom+20, 80, 40)];
    //    view1.backgroundColor = [UIColor whiteColor];
    tf.layer.borderWidth = 1;
    tf.layer.borderColor = [UIColor colorWithHexString:@"#A1A2A4"].CGColor;
    tf.layer.cornerRadius = 5;
    tf.layer.masksToBounds = YES;
    [tf addTarget:self action:@selector(valueChangeAction:) forControlEvents:UIControlEventEditingChanged];

    tf.keyboardType = UIKeyboardTypeDecimalPad;
    [view1 addSubview:tf];
    self.tf = tf;
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(kScreen_Width-130-12, numLab.center.y-15, 130, 30);
    [btn3 addTarget:self action:@selector(calculateAction:) forControlEvents:UIControlEventTouchUpInside];
    //    [btn3 setTitleColor:[UIColor colorWithHexString:@"#0D60FA"] forState:UIControlStateNormal];
    btn3.layer.cornerRadius = 5;
    btn3.layer.masksToBounds = YES;
    btn3.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn3 setTitle:@"计算金额" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor colorWithHexString:@"#E97827"];
    //    btn3.titleLabel.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:btn3];
    self.btn3 = btn3;
    
    UILabel *payLab = [[UILabel alloc] initWithFrame:CGRectMake(12, tf.bottom+20, 200, 16)];
    payLab.font = [UIFont systemFontOfSize:15];
    payLab.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    payLab.text = [NSString stringWithFormat:@"应缴金额 :                 元"];
    [view1 addSubview:payLab];
    self.payLab = payLab;
    
    UIButton *btn4 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn4.frame = CGRectMake(kScreen_Width-130-12, payLab.center.y-15, 130, 30);
    [btn4 addTarget:self action:@selector(rechargeAction) forControlEvents:UIControlEventTouchUpInside];
    //    [btn3 setTitleColor:[UIColor colorWithHexString:@"#0D60FA"] forState:UIControlStateNormal];
    btn4.layer.cornerRadius = 5;
    btn4.layer.masksToBounds = YES;
    btn4.titleLabel.font = [UIFont systemFontOfSize:15];
    [btn4 setTitle:@"立即充值" forState:UIControlStateNormal];
    btn4.backgroundColor = [UIColor colorWithHexString:@"#154C9A"];
    //    btn3.titleLabel.textAlignment = NSTextAlignmentLeft;
    [view1 addSubview:btn4];
    self.btn4 = btn4;
}

// 监听文本框变化
- (void)valueChangeAction:(UITextField *)tf
{
    self.view1.height = 100;
    self.payLab.hidden = YES;
    self.btn4.hidden = YES;
    self.lab6.top = self.view1.bottom+10;
    self.baseView.height = self.lab6.bottom+10;
    self.scrView.contentSize = CGSizeMake(kScreen_Width, self.baseView.height+64);

}

// 立即充值
- (void)rechargeAction
{
    PaymentModel *model = [[PaymentModel alloc] init];
    model.payableAmount = self.money;
    
    ImmediatelyPayVC *vc = [[ImmediatelyPayVC alloc] init];
    vc.model = model;
    vc.mark = 1;
    [self.navigationController pushViewController:vc animated:YES];
}

// 计算金额
- (void)calculateAction:(UIButton *)btn
{
    
    if (self.tf.text.length ==0) {
        [self.view makeToast:@"请输入数量值"];
        return;
    }
    
    [self.view endEditing:YES];
    [btn setTitle:@"重新计算" forState:UIControlStateNormal];

    ICUsageDetailVC *vc = [[ICUsageDetailVC alloc] init];
    vc.volume = self.tf.text;
    vc.calculateBlock = ^(NSString *volume, NSString *money) {
        
        self.tf.text = volume;
        self.money = money;
        
        NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"应缴金额 : %@元",money]];
        NSRange range1 = {[attStr length]-[money length]-1,[money length]};
        [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FC0400"] range:range1];
        self.payLab.attributedText = attStr;
        
        self.view1.height = 100+40;
        self.payLab.hidden = NO;
        self.btn4.hidden = NO;
        self.lab6.top = self.view1.bottom+10;
        self.baseView.height = self.lab6.bottom+10;
        self.scrView.contentSize = CGSizeMake(kScreen_Width, self.baseView.height+64);


    };
    [self.navigationController pushViewController:vc animated:YES];
}



@end

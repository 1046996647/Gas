//
//  InstancePayVC.m
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "ImmediatelyPayVC.h"
#import "PayWayCell.h"
#import "PayResultVC.h"

@interface ImmediatelyPayVC ()<UITableViewDelegate,UITableViewDataSource>

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *line2;
@property(nonatomic,strong) UIButton *lastBtn;


@end

@implementation ImmediatelyPayVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, self.line2.bottom, kScreen_Width, 120)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.scrollEnabled = NO;
//        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"立即缴费";
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    baseView.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:baseView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 60)];
    imgView.image = [UIImage imageNamed:@"0-1"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [baseView addSubview:imgView];
    
    UIView *line1 = [[UIView alloc] initWithFrame:CGRectMake(0, imgView.bottom, kScreen_Width, 1)];
    line1.backgroundColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [baseView addSubview:line1];
    
    UIImageView *imgView1 = [[UIImageView alloc] initWithFrame:CGRectMake(20, line1.bottom+30, 30, 30)];
    imgView1.image = [UIImage imageNamed:@"0-1"];
    imgView1.contentMode = UIViewContentModeScaleAspectFit;
    [baseView addSubview:imgView1];
    
    NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"燃气费  ￥%@",self.model.payableAmount]];
    // 数字部分是汉子长度
    NSRange range1 = {5,[attStr length]-5};
    [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#EF9B39"] range:range1];
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(imgView1.right+10, line1.bottom+30, kScreen_Width-50, 30)];
    lab.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    lab.attributedText = attStr;
    [baseView addSubview:lab];
    
    UIView *line2 = [[UIView alloc] initWithFrame:CGRectMake(0, lab.bottom+30, kScreen_Width, 1)];
    line2.backgroundColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [baseView addSubview:line2];
    self.line2 = line2;
    
    [baseView addSubview:self.tableView];
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(50, self.tableView.bottom+30, kScreen_Width-100, 40);
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds = YES;
    [btn2 addTarget:self action:@selector(confirmPayAction) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:[NSString stringWithFormat:@"确认支付 ￥%@",self.model.payableAmount] forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor colorWithHexString:@"#55B810"];
    [baseView addSubview:btn2];
    
    baseView.height = btn2.bottom+30;
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 60;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return 2;
    //    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PayWayCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[PayWayCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }

    cell.payBtn.tag = indexPath.row;
    [cell.payBtn addTarget:self action:@selector(payAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.detailTextLabel.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    
    if (indexPath.row == 0) {
        cell.imgView.image = [UIImage imageNamed:@"1-5"];
        cell.textLabel.text = @"           微信支付";
        cell.detailTextLabel.text = @"              推荐安装微信5.0及以上版本的用户使用";
        cell.payBtn.selected = YES;
        _lastBtn = cell.payBtn;
    }
    else {
        cell.imgView.image = [UIImage imageNamed:@"1-6"];
        cell.textLabel.text = @"           支付宝支付";
        cell.detailTextLabel.text = @"              推荐有支付宝账号的用户使用";
    }

    return cell;
}

- (void)payAction:(UIButton *)btn
{
    btn.selected = YES;
    if (btn.tag != _lastBtn.tag) {
        _lastBtn.selected = NO;
    }
    _lastBtn = btn;
}

// 确认支付
- (void)confirmPayAction
{
    PayResultVC *vc = [[PayResultVC alloc] init];
    vc.mark = self.mark;
    [self.navigationController pushViewController:vc animated:YES];
}


@end

//
//  ViewController.m
//  Gas
//
//  Created by 张伟良 on 17/5/22.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "HomeViewController.h"
#import "UserIDCell.h"
#import "PaymentVC.h"
#import "UserInfoModel.h"
#import "CardRechargeVC.h"
#import "lhScanQCodeViewController.h"


#define Path [[NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES) firstObject] stringByAppendingPathComponent:@"userID.plist"]

@interface HomeViewController ()<UITableViewDelegate,UITableViewDataSource,UITextFieldDelegate>
{
    MBProgressHUD *_hud;
}

@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UIButton *upBtn;
@property(nonatomic,strong) UIButton *btn1;



@end

@implementation HomeViewController

- (NSMutableArray *)dataArray
{
    
    NSArray *resultArray = [NSArray arrayWithContentsOfFile:Path];
    if (!resultArray) {
        _dataArray = [NSMutableArray array];
    }
    else {
        _dataArray = resultArray.mutableCopy;
    }
    return _dataArray;
}

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(12, self.tf.bottom, kScreen_Width-24, 0)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        _tableView.alpha = 0;
//        _tableView.backgroundColor = [UIColor redColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    self.title = @"XX在线燃气费用";
    self.view.backgroundColor = [UIColor colorWithHexString:@"#efeff4"];
    
    
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake((kScreen_Width-70)/2, 30, 70, 70)];
    view.layer.cornerRadius = 35;
    view.layer.masksToBounds = YES;
    view.backgroundColor = [UIColor whiteColor];
    [self.view addSubview:view];

    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake((70-50)/2, (70-50)/2, 50, 50)];
    imgView.image = [UIImage imageNamed:@"0-1"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    imgView.backgroundColor = [UIColor whiteColor];
    [view addSubview:imgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(12, view.bottom+30, kScreen_Width-24, 50)];
    lab.layer.cornerRadius = 5;
    lab.layer.masksToBounds = YES;
    lab.backgroundColor = [UIColor yellowColor];
    lab.text = @"   XX燃气费";
    lab.backgroundColor = [UIColor colorWithHexString:@"#F3F4FA"];
    lab.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    [self.view addSubview:lab];

    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(12, lab.bottom+30, kScreen_Width-24, 50)];
    tf.layer.cornerRadius = 5;
//    tf.delegate = self;
    [tf addTarget:self action:@selector(changeAction:) forControlEvents:UIControlEventEditingChanged];
    tf.layer.masksToBounds = YES;
    tf.placeholder = @"请输入10位用户编号";
    tf.font = [UIFont systemFontOfSize:14];
    tf.keyboardType = UIKeyboardTypeNumberPad;
    tf.backgroundColor = [UIColor whiteColor];
    tf.leftViewMode = UITextFieldViewModeAlways;
    tf.tintColor = [UIColor blueColor];
    [self.view addSubview:tf];
    self.tf = tf;
    
    // UITextField左视图
    UIView *leftView = [[UIView alloc] initWithFrame:CGRectMake(0, 0, 10, tf.height)];
    tf.leftView = leftView;
    
    // 扫描
    UIButton *btn1 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn1.frame = CGRectMake(kScreen_Width-30-12-20, tf.top+10, 30, 30);
    [btn1 setImage:[UIImage imageNamed:@"0-3"] forState:UIControlStateNormal];
    [btn1 addTarget:self action:@selector(scanneAction) forControlEvents:UIControlEventTouchUpInside];
    self.btn1 = btn1;
    
    // 下拉
    UIButton *upBtn = [UIButton buttonWithType:UIButtonTypeCustom];
    upBtn.frame = CGRectMake(kScreen_Width-30-12-20, tf.top+10, 30, 30);
    [upBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [upBtn addTarget:self action:@selector(upDownAction:) forControlEvents:UIControlEventTouchUpInside];
    self.upBtn = upBtn;
//    [self.tf addSubview:upBtn];
    
    NSString *userID = [InfoCache getUserID];
    if (userID) {
        tf.text = userID;
        tf.layer.cornerRadius = 0;
        [self.view addSubview:upBtn];

    }
    else {
        [self.view addSubview:btn1];

    }

    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(12, tf.bottom+40, kScreen_Width-24, 40);
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds = YES;
    [btn2 addTarget:self action:@selector(selectAction) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"查询" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor colorWithHexString:@"#55B810"];
    [self.view addSubview:btn2];
    
    UIButton *btn3 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn3.frame = CGRectMake(12, btn2.bottom+40, kScreen_Width-24, 40);
    btn3.layer.cornerRadius = 5;
    btn3.layer.masksToBounds = YES;
    [btn3 addTarget:self action:@selector(readCardAction) forControlEvents:UIControlEventTouchUpInside];
    [btn3 setTitle:@"读卡" forState:UIControlStateNormal];
    btn3.backgroundColor = [UIColor colorWithHexString:@"#55B810"];
    [self.view addSubview:btn3];
    
    
}

// 读卡
- (void)readCardAction
{
    [self requestBeforeData];
}


// 文本框文本输入响应
- (void)changeAction:(UITextField *)tf
{
    [_tableView removeFromSuperview];

    if (tf.text.length > 0) {
        self.tf.layer.cornerRadius = 0;
        [self.view addSubview:self.upBtn];
        [self.btn1 removeFromSuperview];
        
        self.upBtn.selected = NO;
        [self.upBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    }
    else {
        self.tf.layer.cornerRadius = 5;
        [self.view addSubview:self.btn1];
        [self.upBtn removeFromSuperview];
    }
}

// 扫描
- (void)scanneAction
{
    lhScanQCodeViewController * sqVC = [[lhScanQCodeViewController alloc]init];
    [self.navigationController pushViewController:sqVC animated:YES];
}

// 下拉列表
- (void)upDownAction:(UIButton *)btn
{
    btn.selected = !btn.selected;
    if (btn.selected) {
        [btn setImage:[UIImage imageNamed:@"up"] forState:UIControlStateNormal];
        [self.view addSubview:self.tableView];
        
        if (self.dataArray.count > 0) {
            
            if (self.dataArray.count > 5) {
                _tableView.height = 200;

            }
            else {
                _tableView.height = 40 * self.dataArray.count;

            }
            [UIView animateWithDuration:0.35 animations:^{
                _tableView.alpha = 1;
            }];
            [self.tableView reloadData];
        }

        
    }
    else {
        [btn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
        [UIView animateWithDuration:0.35 animations:^{
            _tableView.alpha = 0;
        }];
        [_tableView removeFromSuperview];
    }
}

// 查询
- (void)selectAction
{
    if (self.tf.text.length < 10 || self.tf.text.length > 10) {
        [self.view makeToast:@"请输入10位表号"];
        return;
    }
    [self requestAfterData];
}

// 请求后付费用户信息
- (void)requestAfterData
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSArray *array = @[@{@"communicateNo":self.tf.text}];
    [HttpTools postWithURL:BaseURL arrays:array method:GetUserList success:^(id JSON) {
        
        _hud.hidden = YES;
        
        NSDictionary *dic = JSON[@"soap:Body"][@"soap:Fault"];
        if (dic) {
            
            [self.view makeToast:@"查不到用户信息"];
            
        }
        else {
            // 成功
            [self.view endEditing:YES];
            [InfoCache saveUserID:self.tf.text];
            if ([self.dataArray containsObject:self.tf.text]) {
                [_dataArray removeObject:self.tf.text];
                [_dataArray insertObject:self.tf.text atIndex:0];
                [_dataArray writeToFile:Path atomically:YES];
            }
            else {
                [_dataArray addObject:self.tf.text];
                [_dataArray writeToFile:Path atomically:YES];
                
            }
            
            dic = JSON[@"soap:Body"][@"GetUserListResponse"][@"GetUserListResult"][@"UsersList"];
            UserInfoModel *model = [[UserInfoModel alloc] initWithContentsOfDic:dic];
            PaymentVC *vc = [[PaymentVC alloc] init];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    } failure:^(NSError *error) {
        _hud.hidden = YES;
    }];

}

// 请求预付费用户信息
- (void)requestBeforeData
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSArray *array = @[@{@"meterNo":self.tf.text}];
    [HttpTools postWithURL:BaseURL arrays:array method:GetICUserList success:^(id JSON) {
        
        _hud.hidden = YES;
        
        NSDictionary *dic = JSON[@"soap:Body"][@"soap:Fault"];
        if (dic) {
            
            [self.view makeToast:@"查不到用户信息"];
            
        }
        else {
            // 成功
            [self.view endEditing:YES];
            [InfoCache saveUserID:self.tf.text];
            if ([self.dataArray containsObject:self.tf.text]) {
                [_dataArray removeObject:self.tf.text];
                [_dataArray insertObject:self.tf.text atIndex:0];
                [_dataArray writeToFile:Path atomically:YES];
            }
            else {
                [_dataArray addObject:self.tf.text];
                [_dataArray writeToFile:Path atomically:YES];
                
            }
            
            dic = JSON[@"soap:Body"][@"GetICUserListResponse"][@"GetICUserListResult"][@"UsersList"];
            UserInfoModel *model = [[UserInfoModel alloc] initWithContentsOfDic:dic];
            CardRechargeVC *vc = [[CardRechargeVC alloc] init];
            vc.model = model;
            [self.navigationController pushViewController:vc animated:YES];
            
        }
        
    } failure:^(NSError *error) {
        _hud.hidden = YES;
    }];
    
}



#pragma mark - UITableViewDataSource
- (void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath{
    
    self.upBtn.selected = NO;
    [self.upBtn setImage:[UIImage imageNamed:@"down"] forState:UIControlStateNormal];
    [UIView animateWithDuration:0.35 animations:^{
        _tableView.alpha = 0;
    }];
    [_tableView removeFromSuperview];
    
    self.tf.text = _dataArray[indexPath.row];
    [self requestAfterData];
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 40;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return self.dataArray.count;
//    return 4;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UIView *line = [[UIView alloc] initWithFrame:CGRectMake(14, 0, self.tf.width-14, 1)];
    UserIDCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UserIDCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
    }
    if (indexPath.row == 0) {
        
        line.backgroundColor = [UIColor colorWithHexString:@"#A1A2A4"];
        [cell.contentView addSubview:line];
    }
    cell.delBtn.tag = indexPath.row;
    [cell.delBtn addTarget:self action:@selector(delAction:) forControlEvents:UIControlEventTouchUpInside];
    cell.textLabel.text = self.dataArray[indexPath.row];
    cell.textLabel.font = [UIFont systemFontOfSize:14];
    return cell;
}

- (void)delAction:(UIButton *)btn
{
    [_dataArray removeObjectAtIndex:btn.tag];
    [_dataArray writeToFile:Path atomically:YES];
    _tableView.height = 40 * _dataArray.count;
    [_tableView reloadData];
}

//- (void)touchesBegan:(NSSet<UITouch *> *)touches withEvent:(UIEvent *)event
//{
//    [self.view endEditing:YES];
//}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

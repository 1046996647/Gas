//
//  UsageDetailVC.m
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "ICUsageDetailVC.h"
#import "UsageDetailModel.h"
#import "UsageDetailCell.h"

@interface ICUsageDetailVC ()<UITableViewDelegate,UITableViewDataSource, UITextFieldDelegate>
{
    MBProgressHUD *_hud;
}
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) UIView *footerView;
@property(nonatomic,strong) UILabel *lab;
@property(nonatomic,strong) UITextField *tf;
@property(nonatomic,strong) UILabel *numLab;
@property(nonatomic,strong) NSString *money;


@end

@implementation ICUsageDetailVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
        //        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"阶梯使用量明细";
    
    [self.view addSubview:self.tableView];
    [self initFooterView];

    [self requestData];
}

// 表视图滑动到底部
- (void)viewWillAppear:(BOOL)animated {
    [super viewWillAppear:animated];
    [self.tableView setContentOffset:CGPointMake(0, CGFLOAT_MAX)];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

// 请求网络
- (void)requestData
{
    _hud = [MBProgressHUD showHUDAddedTo:self.view animated:YES];
    NSString *userID = [InfoCache getUserID];
    NSArray *array = @[@{@"meterNo":userID}];
    [HttpTools postWithURL:BaseURL arrays:array method:GetLVAllByMeterNo success:^(id JSON) {
        
        _hud.hidden = YES;
        
        NSArray *arr = JSON[@"soap:Body"][@"GetLVAllByMeterNoResponse"][@"GetLVAllByMeterNoResult"][@"LadderAll"];
        
        if (arr) {
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                UsageDetailModel *model = [[UsageDetailModel alloc] initWithContentsOfDic:dic];
                [arrM addObject:model];
            }
            _dataArray = arrM;
            UsageDetailModel *model = [_dataArray firstObject];
            self.lab.text = [NSString stringWithFormat:@"阶梯使用量周期 : %@至%@",model.startTime, model.endTime];


            [_tableView reloadData];
            
            [self requestMoneyData];
            
        }
        
        
    } failure:^(NSError *error) {
        _hud.hidden = YES;
    }];
    
}

// 请求Money数据
- (void)requestMoneyData
{
    NSString *userID = [InfoCache getUserID];
    NSArray *array = @[@{@"meterNo":userID},@{@"buyVolume":self.tf.text}];
    [HttpTools postWithURL:BaseURL arrays:array method:ToMoney success:^(id JSON) {
        
        _hud.hidden = YES;
        
        id obj = JSON[@"soap:Body"][@"ToMoneyResponse"][@"ToMoneyResult"];
        
        if (obj) {

            NSString *str1 = obj[@"buyVolume"];
            str1 = [NSString stringWithFormat:@"%.2f",str1.floatValue];
            self.money = str1;

            NSMutableAttributedString *attStr = [[NSMutableAttributedString alloc] initWithString:[NSString stringWithFormat:@"  充值数量 :                        方     需要缴费 : %@元",str1]];
            NSRange range1 = {[attStr length]-[str1 length]-1,[str1 length]};
            [attStr addAttribute:NSForegroundColorAttributeName value:[UIColor colorWithHexString:@"#FC0400"] range:range1];
            self.numLab.attributedText = attStr;

        }
        
        
    } failure:^(NSError *error) {
        _hud.hidden = YES;
    }];
}

- (void)initFooterView
{
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 0)];
    self.footerView = view;
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreen_Width, 60)];
    lab.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    lab.font = [UIFont systemFontOfSize:15];
    lab.backgroundColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    [view addSubview:lab];
    self.lab = lab;
    
    UILabel *numLab = [[UILabel alloc] initWithFrame:CGRectMake(0, lab.bottom+20, kScreen_Width-12, 80)];
    numLab.font = [UIFont systemFontOfSize:15];
    numLab.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    numLab.backgroundColor = [UIColor whiteColor];
//    numLab.text = [NSString stringWithFormat:@"充值数量 :                        方     需要缴费 : 元"];
    [view addSubview:numLab];
    self.numLab = numLab;
    
    UITextField *tf = [[UITextField alloc] initWithFrame:CGRectMake(90, numLab.center.y-20, 80, 40)];
    //    view1.backgroundColor = [UIColor whiteColor];
    tf.layer.borderWidth = 1;
    tf.layer.borderColor = [UIColor colorWithHexString:@"#A1A2A4"].CGColor;
    tf.layer.cornerRadius = 5;
    tf.text = self.volume;
//    tf.delegate = self;
    [tf addTarget:self action:@selector(valueChangeAction:) forControlEvents:UIControlEventEditingChanged];
    tf.keyboardType = UIKeyboardTypeDecimalPad;
//    [tf becomeFirstResponder];
    [view addSubview:tf];
    self.tf = tf;
//    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(.4 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
//        [tf becomeFirstResponder];
//
//    });
    
    UIButton *btn2 = [UIButton buttonWithType:UIButtonTypeCustom];
    btn2.frame = CGRectMake(50, numLab.bottom+30, kScreen_Width-100, 40);
    btn2.layer.cornerRadius = 5;
    btn2.layer.masksToBounds = YES;
    [btn2 addTarget:self action:@selector(okAction) forControlEvents:UIControlEventTouchUpInside];
    [btn2 setTitle:@"确定" forState:UIControlStateNormal];
    btn2.backgroundColor = [UIColor colorWithHexString:@"#55B810"];
    [view addSubview:btn2];
    
    view.height = btn2.bottom+20;
    
    _tableView.tableFooterView = view;
}

- (void)okAction
{
    [self.view endEditing:YES];
    if (self.calculateBlock) {
        self.calculateBlock(self.tf.text, self.money);
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

// 监听文本框变化
- (void)valueChangeAction:(UITextField *)tf
{
    [self requestMoneyData];
}



#pragma mark - UITableViewDataSource
- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 100;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    return _dataArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UsageDetailCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[UsageDetailCell alloc] initWithStyle:UITableViewCellStyleSubtitle reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    cell.model = _dataArray[indexPath.row];
    return cell;
}


@end

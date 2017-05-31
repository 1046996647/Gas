//
//  PayRecordVC.m
//  Gas
//
//  Created by 张伟良 on 17/5/25.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "PayRecordVC.h"
#import "PayRecordCell.h"
#import "NSStringExt.h"

@interface PayRecordVC ()<UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *_hud;
}

@property(nonatomic,strong) UITableView *tableView;
@property(nonatomic,strong) NSMutableArray *dataArray;



@end

@implementation PayRecordVC

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
    
    self.title = @"缴费记录";
    
    [self.view addSubview:self.tableView];
    self.tableView.tableFooterView = [[UIView alloc] init];
    
    [self requestData];
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
    NSArray *array = @[@{@"communicateNo":userID},@{@"startMonth":@"201701"},@{@"endMonth":@"201705"}];
    [HttpTools postWithURL:BaseURL arrays:array method:GetPayByCommunicateNo success:^(id JSON) {
        
        _hud.hidden = YES;
        
        id obj = JSON[@"soap:Body"][@"GetPayByCommunicateNoResponse"][@"GetPayByCommunicateNoResult"][@"BalanceFee"];
        
        if (obj) {
            
            if ([obj isKindOfClass:[NSDictionary class]]) {
                obj = @[obj];// 一条数据时返回是个字典，多条时返回一个数组，所以做处理

            }
            
            NSMutableArray *arrM = [NSMutableArray array];
            NSMutableArray *arrM1 = [NSMutableArray array];
            
            // 去掉一样日期
            for (NSDictionary *dic in obj) {
                PayRecordModel *model = [[PayRecordModel alloc] initWithContentsOfDic:dic];
                if (![arrM containsObject:model.payTime]) {
                    
                    [arrM addObject:model.payTime];

                    TimeModel *timeModel = [[TimeModel alloc] init];
                    timeModel.timeStr = model.payTime;
                    [arrM1 addObject:timeModel];
                }
            }
            _dataArray = arrM1;
            
            // 归类
            for (TimeModel *timeModel in arrM1) {
                
                for (NSDictionary *dic in obj) {
                    
                    PayRecordModel *model = [[PayRecordModel alloc] initWithContentsOfDic:dic];

                    if ([timeModel.timeStr isEqualToString:model.payTime]) {
                        [timeModel.headCellArray addObject:model];
                    }
                }
 
            }
            
            [_tableView reloadData];
        }
        
        
    } failure:^(NSError *error) {
        _hud.hidden = YES;
    }];
    
}

#pragma mark - UITableViewDataSource

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return _dataArray.count;
}

- (CGFloat)tableView:(UITableView *)tableView heightForRowAtIndexPath:(NSIndexPath *)indexPath{
    return 80;
}

- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section
{
    TimeModel *timeModel = _dataArray[section];
    return timeModel.headCellArray.count;
}


- (UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    PayRecordCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell"];
    if (cell == nil) {
        
        cell = [[PayRecordCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:@"cell"];
        cell.selectionStyle = UITableViewCellSelectionStyleNone;
    }
    
    TimeModel *timeModel = _dataArray[indexPath.section];
    cell.model = timeModel.headCellArray[indexPath.row];
    return cell;
}

- (CGFloat)tableView:(UITableView *)tableView heightForHeaderInSection:(NSInteger)section
{
    return 40;
}

- (nullable NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    TimeModel *timeModel = _dataArray[section];
    return [NSString isSameMonth:timeModel.timeStr];
}

@end

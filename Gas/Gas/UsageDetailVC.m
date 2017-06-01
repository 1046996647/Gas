//
//  UsageDetailVC.m
//  Gas
//
//  Created by 张伟良 on 17/5/24.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "UsageDetailVC.h"
#import "UsageDetailModel.h"
#import "UsageDetailCell.h"

@interface UsageDetailVC ()<UITableViewDelegate,UITableViewDataSource>
{
    MBProgressHUD *_hud;
}
@property(nonatomic,strong) NSMutableArray *dataArray;
@property(nonatomic,strong) UITableView *tableView;


@end

@implementation UsageDetailVC

- (UITableView *)tableView
{
    if (!_tableView) {
        //列表
        _tableView = [[UITableView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, kScreen_Height-64)];
        _tableView.delegate = self;
        _tableView.dataSource = self;
//        _tableView.scrollEnabled = NO;
        _tableView.backgroundColor = [UIColor clearColor];
        _tableView.tableFooterView = [[UIView alloc] init];
    }
    return _tableView;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"阶梯使用量明细";
    
    [self.view addSubview:self.tableView];
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
    NSArray *array = @[@{@"communicateNo":userID}];
    [HttpTools postWithURL:BaseURL arrays:array method:GetLVAllByCommunicateNo success:^(id JSON) {
        
        _hud.hidden = YES;
        
        NSArray *arr = JSON[@"soap:Body"][@"GetLVAllByCommunicateNoResponse"][@"GetLVAllByCommunicateNoResult"][@"LadderAll"];
        
        if (arr) {
            NSMutableArray *arrM = [NSMutableArray array];
            for (NSDictionary *dic in arr) {
                UsageDetailModel *model = [[UsageDetailModel alloc] initWithContentsOfDic:dic];
                [arrM addObject:model];
            }
            _dataArray = arrM;
            [self initFooterView];
            [_tableView reloadData];
        }

        
    } failure:^(NSError *error) {
        _hud.hidden = YES;
    }];
    
}

- (void)initFooterView
{
    UsageDetailModel *model = [_dataArray firstObject];
    UIView *view = [[UIView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 80)];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, 20, kScreen_Width, 80-20)];
    lab.textColor = [UIColor colorWithHexString:@"#A1A2A4"];
    lab.font = [UIFont systemFontOfSize:15];
    lab.backgroundColor = [UIColor whiteColor];
    lab.textAlignment = NSTextAlignmentCenter;
    lab.text = [NSString stringWithFormat:@"阶梯使用量周期 : %@至%@",model.startTime, model.endTime];
    [view addSubview:lab];
    _tableView.tableFooterView = view;
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

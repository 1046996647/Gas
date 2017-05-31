//
//  ReadCardResultVC.m
//  Gas
//
//  Created by ZhangWeiLiang on 2017/5/31.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "ReadCardResultVC.h"
#import "UIViewController+UIViewControllerExt.h"

@interface ReadCardResultVC ()

@end

@implementation ReadCardResultVC

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    self.title = @"正在写卡";
    self.view.backgroundColor = [UIColor whiteColor];
    
    UIView *baseView = [[UIView alloc] initWithFrame:CGRectMake(0, (kScreen_Height-64-150)/2, kScreen_Width, 150)];
    //    baseView.backgroundColor = [UIColor ];
    [self.view addSubview:baseView];
    
    UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, kScreen_Width, 100)];
    imgView.image = [UIImage imageNamed:@"2-6"];
    imgView.contentMode = UIViewContentModeScaleAspectFit;
    [baseView addSubview:imgView];
    
    UILabel *lab = [[UILabel alloc] initWithFrame:CGRectMake(0, imgView.bottom+30, kScreen_Width, 20)];
    lab.text = @"正在写卡...";
    lab.textAlignment = NSTextAlignmentCenter;
    [baseView addSubview:lab];
    
    dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
        
        imgView.image = [UIImage imageNamed:@"2-8"];
        lab.text = @"写卡成功!";

        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(3 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [self popViewController:@"CardRechargeVC"];
        });
    });
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

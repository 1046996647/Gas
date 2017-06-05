//
//  ViewController.m
//  Gas
//
//  Created by 张伟良 on 17/5/22.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "ViewController.h"

@interface ViewController ()



@end

@implementation ViewController



- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
//    if ([self respondsToSelector:@selector(automaticallyAdjustsScrollViewInsets)]) {
//        self.automaticallyAdjustsScrollViewInsets = NO;
//    }
    
    UIBarButtonItem *returnItem = [[UIBarButtonItem alloc] init];
    returnItem.title = @"返回";
    self.navigationItem.backBarButtonItem = returnItem;
    self.view.backgroundColor = [UIColor colorWithHexString:@"#F2F4F8"];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

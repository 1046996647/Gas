//
//  AppDelegate.m
//  Gas
//
//  Created by 张伟良 on 17/5/22.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "AppDelegate.h"
#import "IQKeyboardManager.h"
#import "Reachability.h"

@interface AppDelegate ()<UIAlertViewDelegate>

@property (nonatomic, strong) Reachability *conn;

@end

@implementation AppDelegate

- (void)dealloc
{
    [self.conn stopNotifier];
    [[NSNotificationCenter defaultCenter] removeObserver:self];
}

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions {
    // Override point for customization after application launch.
    
//    [NSThread sleepForTimeInterval:1];
    
    // 键盘遮盖处理第三方库
    IQKeyboardManager *manager = [IQKeyboardManager sharedManager];
    manager.enable = YES;
    manager.shouldResignOnTouchOutside = YES;
    manager.shouldToolbarUsesTextFieldTintColor = YES;
    manager.enableAutoToolbar = NO;
    
    // 监测网络状态
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(networkStateChange) name:kReachabilityChangedNotification object:nil];
    self.conn = [Reachability reachabilityForInternetConnection];
    // 开始监控
    [self.conn startNotifier];
    
    // 程序启动就检查网络
    [self networkStateChange];
    

    
    return YES;
}

- (void)networkStateChange
{
    [self checkNetworkState];
}

- (void)checkNetworkState
{
    // 1.检测wifi状态
    Reachability *wifi = [Reachability reachabilityForLocalWiFi];
    
    // 2.检测手机是否能上网络(WIFI\3G\2.5G)
    Reachability *conn = [Reachability reachabilityForInternetConnection];
    
    // 3.判断网络状态
    if ([wifi currentReachabilityStatus] != NotReachable) { // 有wifi
        NSLog(@"有wifi");
        
    } else if ([conn currentReachabilityStatus] != NotReachable) { // 没有使用wifi, 使用手机自带网络进行上网
        NSLog(@"使用手机自带网络进行上网");
        
    } else { // 没有网络
        
        UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"当前网络无连接" message:@"请设置您的网络!"
 delegate:self cancelButtonTitle:@"设置" otherButtonTitles:@"好", nil];
        [alert show];
        NSLog(@"没有网络");
    }
}

#pragma mark - UIAlertViewDelegate
- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    if (buttonIndex == 0) {
        // 跳转到WIFI设置
        if ([[UIApplication sharedApplication] canOpenURL:[NSURL URLWithString:@"prefs:root=WIFI"]]){
            [[UIApplication sharedApplication] openURL:[NSURL URLWithString:@"prefs:root=WIFI"]];
        }
    }

}

- (void)applicationWillResignActive:(UIApplication *)application {
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and invalidate graphics rendering callbacks. Games should use this method to pause the game.
}


- (void)applicationDidEnterBackground:(UIApplication *)application {
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
}


- (void)applicationWillEnterForeground:(UIApplication *)application {
    // Called as part of the transition from the background to the active state; here you can undo many of the changes made on entering the background.
}


- (void)applicationDidBecomeActive:(UIApplication *)application {
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}


- (void)applicationWillTerminate:(UIApplication *)application {
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
}


@end

//
//  InfoCache.m
//  Gas
//
//  Created by 张伟良 on 17/5/23.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import "InfoCache.h"

@implementation InfoCache

//
+(void)saveUserID:(NSString *)str
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    [userDefaultes setObject:str forKey:@"userID"];
    [userDefaultes synchronize];
}

+(NSString *)getUserID
{
    NSUserDefaults *userDefaultes = [NSUserDefaults standardUserDefaults];
    NSString *str = [userDefaultes  objectForKey:@"userID"];
    return str;
}

@end

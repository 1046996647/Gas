//
//  InfoCache.h
//  Gas
//
//  Created by 张伟良 on 17/5/23.
//  Copyright © 2017年 HongHu. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface InfoCache : NSObject

//
+(void)saveUserID:(NSString *)str;
+(NSString *)getUserID;


@end

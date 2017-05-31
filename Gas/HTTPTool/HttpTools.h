//
//  HttpTools.h
//  MIcroBlog
//
//  Created by zhoupengfei on 15/2/12.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import <Foundation/Foundation.h>



typedef void (^HttpFailureBlock) (NSError*error);
@interface HttpTools : NSObject
+(void)postWithURL:(NSString*)url arrays:(NSArray*)arrays  method:(NSString*)method success:(void(^)(id JSON))success failure:(void(^)(NSError *error))failure; //post请求



@end

//
//  HttpTools.m
//  MIcroBlog
//
//  Created by zhoupengfei on 15/2/12.
//  Copyright (c) 2015年 zpf. All rights reserved.
//

#import "HttpTools.h"
#define KNameSpace  @"http://tempuri.org/"

@interface HttpTools ()

@end

@implementation HttpTools
+(void)postWithURL:(NSString*)url arrays:(NSArray*)arrays  method:(NSString*)method success:(void(^)(id JSON))success failure:(void(^)(NSError *error))failure{
    
    NSString *soapMessage = [self stringWithFormatString:arrays method:method];
    NSLog(@"_______%@",soapMessage);
    NSMutableURLRequest *theRequest = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    theRequest.timeoutInterval = 30.0;
    NSString *msgLength = [NSString stringWithFormat:@"%lu", (unsigned long)[soapMessage length]];
    [theRequest addValue:@"application/soap+xml; charset=utf-8" forHTTPHeaderField:@"Content-Type"];
    [theRequest addValue:msgLength forHTTPHeaderField:@"Content-Length"];
    [theRequest setHTTPMethod:@"POST"];
    [theRequest setHTTPBody: [soapMessage dataUsingEncoding:NSUTF8StringEncoding]];
    
    NSOperationQueue * operationQueue = [NSOperationQueue mainQueue];
    [NSURLConnection sendAsynchronousRequest:theRequest queue:operationQueue completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        if (data) {
            
            NSString *xml = [[NSString alloc] initWithData:data encoding:NSUTF8StringEncoding];
            NSDictionary *xmlDoc = [NSDictionary dictionaryWithXMLString:xml];
            NSLog(@"dictionary: %@", xmlDoc);
            success(xmlDoc);
        }else if (connectionError){

        
            [[UIApplication sharedApplication].keyWindow.rootViewController.view makeToast:connectionError.localizedDescription];

            NSLog(@"error = %@",connectionError);
            failure(connectionError);
        }

    }];
    
}




//+(NSString*)defaultStringOne{
//    NSString *soapBody=@"<soapenv:Body><ns:%@ xmlns:ns=\"http://ws.apache.org/axis2\"><ns:return>";
//    return soapBody;
//}
//+(NSString*)defaultStringTwo{
//    NSString *soapBody=@"</ns:return></ns:%@></soapenv:Body></soapenv:Envelope>";
//    return soapBody;
//}

+(NSString*)stringWithFormatString:(NSArray*)params method:(NSString*)method{
    
    NSString * paramsString = [self paramsFormatString:params];
    NSString * paramsString2 = [self methName:method nameSpace:KNameSpace bodyString:paramsString];
    
    return [NSString stringWithFormat:[self defaultSoapMesage],paramsString2];
}
/*
函数名字：paramsFormatString
功能：构造 子元素文本的格式
参数：子元素和元素文本
返回值：元素和文本字符串
*/
+(NSString*)paramsFormatString:(NSArray*)params{
    NSMutableString *xml=[NSMutableString stringWithFormat:@""];
    for (NSDictionary *item in params) {
        NSString *key=[[item allKeys] objectAtIndex:0];
        [xml appendFormat:@"<%@>",key];
        [xml appendString:[item objectForKey:key]];
        [xml appendFormat:@"</%@>",key];
    }
    return xml;
}

/*
 函数名字：paramString:(NSString *)methName andString:(NSString *)nameSpace andThree:(NSString *)Body
 功能：构造 元素和属性的格式
 参数：函数名字，命名空间，子元素
 返回值：元素和属性字符串
 */
+(NSString *)methName:(NSString *)methName nameSpace:(NSString *)nameSpace bodyString:(NSString *)Body
{
    NSMutableString *xml=[NSMutableString string];
    [xml appendFormat:@"<%@ xmlns=\"%@\">",methName,nameSpace];
    [xml appendFormat:@"%@",Body];
    [xml appendFormat:@"</%@>",methName];
    return xml;
}


+(NSString*)defaultSoapMesage{
    NSString *soapBody=@"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
    "<soap12:Envelope "
    "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
    "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
    "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
    "<soap12:Body>%@</soap12:Body>\n"
    "</soap12:Envelope>\n";
//    NSString *soapMsg = [NSString stringWithFormat:
//                         @"<?xml version=\"1.0\" encoding=\"utf-8\"?>"
//                         "<soap12:Envelope "
//                         "xmlns:xsi=\"http://www.w3.org/2001/XMLSchema-instance\" "
//                         "xmlns:xsd=\"http://www.w3.org/2001/XMLSchema\" "
//                         "xmlns:soap12=\"http://www.w3.org/2003/05/soap-envelope\">"
//                         "<soap12:Body>"%@"</soap12:Body>"
//                         "</soap12:Envelope>"];
    return soapBody;
}



@end

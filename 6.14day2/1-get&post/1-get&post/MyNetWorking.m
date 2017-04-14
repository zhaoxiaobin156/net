//
//  MyNetWorking.m
//  1-get&post
//
//  Created by mac on 16/6/14.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "MyNetWorking.h"

@implementation MyNetWorking

+(void)getDataWithString:(NSString *)url andParam:(NSDictionary *)dic compliationBlock:(MyNetWorkingBlock)block{

    NSString *param = [self stringFromDic:dic];
    
    NSString *strUrl = [NSString stringWithFormat:@"%@?%@",url,param];
    
    NSURLRequest *req = [NSURLRequest requestWithURL:[NSURL URLWithString:strUrl]];
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        block(response,data,connectionError);
    }];
}

+(void)postDataWithString:(NSString *)url andParam:(NSDictionary *)dic compliationBlock:(MyNetWorkingBlock)block{
    
    NSString *param = [self stringFromDic:dic];
    
    NSMutableURLRequest *req = [NSMutableURLRequest requestWithURL:[NSURL URLWithString:url]];
    
    req.HTTPMethod = @"POST";
    
    NSData *data = [param dataUsingEncoding:NSUTF8StringEncoding];
    
    req.HTTPBody = data;
    
    [NSURLConnection sendAsynchronousRequest:req queue:[NSOperationQueue mainQueue] completionHandler:^(NSURLResponse *response, NSData *data, NSError *connectionError) {
        
        block(response,data,connectionError);
    }];
}

//辅助方法：字典转成字符串
//@{@"username":@"ios2449608306",@"password":@"123456"} -> @"username=ios2449608306&password=123456"
+(NSString *)stringFromDic:(NSDictionary *)dic{

    NSMutableArray *mutArr = [NSMutableArray array];
    
    for (NSString *key in dic.allKeys) {
        
        NSString *str = [NSString stringWithFormat:@"%@=%@",key,dic[key]];
        
        [mutArr addObject:str];
    }
    
    return [mutArr componentsJoinedByString:@"&"];
}

@end

//
//  HttpManager.m
//  iLimitFree
//
//  Created by mac on 16/6/28.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "HttpManager.h"

@implementation HttpManager

//很多个页面都需要做数据的获取，所以写成单例
+(instancetype)shareInstance{
    
    static HttpManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[HttpManager alloc] init];
        
    });
    return manager;
}

-(void)getDataByPage:(int)page AndTag:(int)tag AndSuccess:(successBlock)success AndFailure:(failureBlock)failure{

    NSString *urlStr = nil;
    
    switch (tag) {
        case 10:
        {
            //限免
            urlStr = [NSString stringWithFormat:LimitFreeURL,page];
        }
            break;
        case 11:
        {
            //降价
            urlStr = [NSString stringWithFormat:ReduceURL,page];
        }
            break;
        case 12:
        {
            //免费
            urlStr = [NSString stringWithFormat:FreeURL,page];
        }
            break;
            
        default:
            break;
    }
    
    //获取数据
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        //数据下载成功，执行成功的回调
//        NSLog(@"responseObject = %@",responseObject);
        
        //解出这个数组，返回
        NSArray *arr = responseObject[@"applications"];
        
        if (success) {
            success(arr);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        //数据下载失败，执行失败的回调
        if (failure) {
            failure(error);
        }
        
    }];
}

-(void)getAppDetailInfoById:(NSString *)applicationId AndSuccess:(successBlock)success AndFailure:(failureBlock)failure{

    NSString *urlStr = [NSString stringWithFormat:AppDetailURL,applicationId];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
//        NSLog(@"responseObject = %@",responseObject);
        
        if (success) {
            success(responseObject);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (failure) {
            failure(error);
        }
        
    }];
}

-(void)getNearByAppWithLatitude:(CGFloat)latitude AndLongitude:(CGFloat)longitude AndSuccess:(successBlock)success AndFailure:(failureBlock)failure{

    NSString *urlStr = [NSString stringWithFormat:NearByURL,longitude,latitude];
    
    AFHTTPSessionManager *manager = [AFHTTPSessionManager manager];
    
    [manager GET:urlStr parameters:nil success:^(NSURLSessionDataTask *task, id responseObject) {
        
        NSArray *arr = responseObject[@"applications"];
        
        if (success) {
            success(arr);
        }
        
    } failure:^(NSURLSessionDataTask *task, NSError *error) {
        
        if (error) {
            failure(error);
        }
        
    }];
}

@end

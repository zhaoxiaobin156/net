//
//  HttpManager.h
//  iLimitFree
//
//  Created by mac on 16/6/28.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^successBlock)(id object);//请求数据成功，带回数据
typedef void(^failureBlock)(NSError *error);//请求失败，返回错误

@interface HttpManager : NSObject

//所有的网络请求，都在这个类里面

//单例方法
+(instancetype)shareInstance;

//page代表上下拉刷新的页码
//tag：限免 10，降价 11，免费 12
-(void)getDataByPage:(int)page AndTag:(int)tag AndSuccess:(successBlock)success AndFailure:(failureBlock)failure;

//获取应用详情
-(void)getAppDetailInfoById:(NSString *)applicationId AndSuccess:(successBlock)success AndFailure:(failureBlock)failure;

//获取附近APP
-(void)getNearByAppWithLatitude:(CGFloat)latitude AndLongitude:(CGFloat)longitude AndSuccess:(successBlock)success AndFailure:(failureBlock)failure;

@end

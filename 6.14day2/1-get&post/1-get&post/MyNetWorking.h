//
//  MyNetWorking.h
//  1-get&post
//
//  Created by mac on 16/6/14.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

typedef void(^MyNetWorkingBlock)(NSURLResponse *response, NSData *data, NSError *connectionError);

@interface MyNetWorking : NSObject

+(void)getDataWithString:(NSString *)url andParam:(NSDictionary *)dic compliationBlock:(MyNetWorkingBlock)block;

+(void)postDataWithString:(NSString *)url andParam:(NSDictionary *)dic compliationBlock:(MyNetWorkingBlock)block;

@end

//
//  SQLManager.h
//  iLimitFree
//
//  Created by mac on 16/6/29.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

@interface SQLManager : NSObject

@property(nonatomic,strong)FMDatabase *dataBase;

+(instancetype)shareInstance;

//限免，降价，免费三个页面的插入
//tag：往哪张表插
//mod：插入的模型
-(void)insertDataWithTag:(int)tag AndModel:(LimitModel *)mod;

//清空表
-(void)deleteAllDataWithTag:(int)tag;

//返回表中所有数据
-(NSArray *)getDataWithTag:(int)tag;

//检查收藏表是否收藏过App
-(BOOL)isCollectWith:(NSString *)applicationId;

//新增收藏
-(void)insertCollect:(NSDictionary *)dic;

//读取收藏表
-(NSArray *)getCollectData;

//删除收藏
-(void)deleteCollectWith:(NSString *)applicationId;

@end

//
//  DataBaseManager.h
//  2-FMDB封装
//
//  Created by mac on 16/6/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "FMDB.h"
#import "Person.h"

@interface DataBaseManager : NSObject

+(instancetype)shareManager;//相当于+(DataBaseManager *)shareManager

//增加
-(BOOL)insertData:(Person *)per;

//删除
-(BOOL)deleteDataWithName:(NSString *)name;

//查找
-(NSArray *)searchAllData;

//修改
-(BOOL)updateData:(Person *)per WithName:(NSString *)name;

@end

//
//  DataBaseManager.m
//  2-FMDB封装
//
//  Created by mac on 16/6/20.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "DataBaseManager.h"

@interface DataBaseManager ()

@property(nonatomic,strong)FMDatabase *dataBase;

@end

static DataBaseManager *dbm = nil;

@implementation DataBaseManager

//第二种单例写法：GCD写法
//类方法创建单例对象
+(instancetype)shareManager{

    static dispatch_once_t onceToken;
    
    dispatch_once(&onceToken, ^{
        
        //只会执行一次，也就是说只创建一个对象
        dbm = [[DataBaseManager alloc] init];
    });
    return dbm;
}

//防止重复alloc对象
+(instancetype)allocWithZone:(struct _NSZone *)zone{

    if (dbm == nil) {
        dbm = [super allocWithZone:zone];
        
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Library/dataBase.sqlite3"];
        
        dbm.dataBase = [[FMDatabase alloc] initWithPath:path];
        
        [dbm.dataBase open];
        
        BOOL ret = [dbm.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS PersonTable (name text NOT NULL,age text);"];
        
        if (ret) {
            
            NSLog(@"创建表OK");
        }
        
        [dbm.dataBase close];
    }
    return dbm;
}

//第一种单例写法
//+(instancetype)shareManager{
//
//    if (dbm == nil) {
//        dbm = [[DataBaseManager alloc] init];
//    }
//    return dbm;
//}

-(BOOL)insertData:(Person *)per{

    [self.dataBase open];
    
    BOOL ret = [self.dataBase executeUpdate:@"INSERT INTO PersonTable (name, age) VALUES (?, ?)", per.name,per.age];
    
    [self.dataBase close];
    
    return ret;
}

-(BOOL)deleteDataWithName:(NSString *)name{

    [self.dataBase open];
    
    BOOL ret = [self.dataBase executeUpdate:@"DELETE FROM PersonTable WHERE name = ?", name];
    
    [self.dataBase close];
    
    return ret;
}

-(NSArray *)searchAllData{

    [self.dataBase open];
    
    FMResultSet *set = [self.dataBase executeQuery:@"SELECT * FROM PersonTable"];
    
    NSMutableArray *mutArr = [NSMutableArray array];
    
    while ([set next] == YES) {
        
        Person *per = [[Person alloc] init];
        per.name = [set stringForColumn:@"name"];
        per.age = [set stringForColumn:@"age"];
        
        [mutArr addObject:per];
    }
    
    [self.dataBase close];
    
    return mutArr;
}

-(BOOL)updateData:(Person *)per WithName:(NSString *)name{

    [self.dataBase open];
    
    BOOL ret = [self.dataBase executeUpdate:@"UPDATE PersonTable set age = ? WHERE name = ?", per.age, name];
    
    [self.dataBase close];
    
    return ret;
}

@end

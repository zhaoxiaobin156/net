//
//  SQLManager.m
//  iLimitFree
//
//  Created by mac on 16/6/29.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "SQLManager.h"

@implementation SQLManager

+(instancetype)shareInstance{

    static SQLManager *manager = nil;
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        
        manager = [[SQLManager alloc] init];
        
    });
    return manager;
}

- (instancetype)init
{
    self = [super init];
    if (self) {
        
        //数据库沙盒路径
        NSString *path = [NSHomeDirectory() stringByAppendingString:@"/Documents/limitFree.db"];
        
        NSLog(@"path = %@",path);
        
        //实例数据库对象
        self.dataBase = [FMDatabase databaseWithPath:path];
        
        //打开数据库
        if ([self.dataBase open]) {
            
            [self createTableLimit];
            [self createTableCollect];
            
        }else{
        
            NSLog(@"打开数据库失败");
            
        }
    }
    return self;
}

//限免 降价 免费缓存表
-(void)createTableLimit{

    NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS LimitTable (id integer primary key autoincrement,applicationId text,iconUrl text,name text,expireDatetime text,starOverall text,lastPrice text,categoryName text,shares text,favorites text,downloads text)";
    
    NSString *sqlStr2 = @"CREATE TABLE IF NOT EXISTS ReduceTable (id integer primary key autoincrement,applicationId text,iconUrl text,name text,expireDatetime text,starOverall text,lastPrice text,categoryName text,shares text,favorites text,downloads text)";
    
    NSString *sqlStr3 = @"CREATE TABLE IF NOT EXISTS FreeTable (id integer primary key autoincrement,applicationId text,iconUrl text,name text,expireDatetime text,starOverall text,lastPrice text,categoryName text,shares text,favorites text,downloads text)";
    
    if (![self.dataBase executeUpdate:sqlStr]) {
        
        NSLog(@"创建Limit表失败");
    }
    
    if (![self.dataBase executeUpdate:sqlStr2]) {
        
        NSLog(@"创建Reduce表失败");
    }
    
    if (![self.dataBase executeUpdate:sqlStr3]) {
        
        NSLog(@"创建Free表失败");
    }
}

//收藏表
-(void)createTableCollect{

    NSString *sqlStr = @"CREATE TABLE IF NOT EXISTS CollectTable (id integer primary key autoincrement,applicationId text,name text,image blob)";
    
    if (![self.dataBase executeUpdate:sqlStr]) {
        
        NSLog(@"创建Collect表失败");
    }
}

-(void)insertDataWithTag:(int)tag AndModel:(LimitModel *)mod{

    NSString *tableName = [self getTableNameByTag:tag];
    
    NSString *sqlStr = [NSString stringWithFormat:@"insert into %@  (applicationId,iconUrl,name,expireDatetime,starOverall,lastPrice,categoryName,shares,favorites,downloads) values ('%@','%@','%@','%@','%@','%@','%@','%@','%@','%@')",tableName,mod.applicationId,mod.iconUrl,mod.name,mod.expireDatetime,mod.starOverall,mod.lastPrice,mod.categoryName,mod.shares,mod.favorites,mod.downloads];
   
    if (![self.dataBase executeUpdate:sqlStr]) {
        
        NSLog(@"插入失败，表名 = %@",tableName);
    }
}

-(void)deleteAllDataWithTag:(int)tag{

    NSString *tableName = [self getTableNameByTag:tag];
    
    NSString *sqlStr = [NSString stringWithFormat:@"delete from %@",tableName];
    
    if (![self.dataBase executeUpdate:sqlStr]) {
        
        NSLog(@"清空表失败，表名 = %@",tableName);
    }
}

-(NSArray *)getDataWithTag:(int)tag{

    NSString *tableName = [self getTableNameByTag:tag];
    
    NSMutableArray *mutArr = [NSMutableArray array];
    
    NSString *sqlStr = [NSString stringWithFormat:@"select * from %@",tableName];
    
    FMResultSet *set = [self.dataBase executeQuery:sqlStr];
    
    while ([set next]) {
        
        LimitModel *mod = [[LimitModel alloc] init];
        mod.applicationId = [set stringForColumn:@"applicationId"];
        mod.iconUrl = [set stringForColumn:@"iconUrl"];
        mod.name = [set stringForColumn:@"name"];
        mod.expireDatetime = [set stringForColumn:@"expireDatetime"];
        mod.starOverall = [set stringForColumn:@"starOverall"];
        mod.lastPrice = [set stringForColumn:@"lastPrice"];
        mod.categoryName = [set stringForColumn:@"categoryName"];
        mod.shares = [set stringForColumn:@"shares"];
        mod.favorites = [set stringForColumn:@"favorites"];
        mod.downloads = [set stringForColumn:@"downloads"];
        
        [mutArr addObject:mod];
    }
    
    return mutArr;
}

//当代码需要多次拷贝的时候，就将它封装
-(NSString *)getTableNameByTag:(int)tag{

    NSString *tableName = nil;
    
    switch (tag) {
        case 10:
        {
            tableName = @"LimitTable";
        }
            break;
        case 11:
        {
            tableName = @"ReduceTable";
        }
            break;
        case 12:
        {
            tableName = @"FreeTable";
        }
            break;
            
        default:
            break;
    }
    return tableName;
}

-(BOOL)isCollectWith:(NSString *)applicationId{

    //如果查询结果只有一条的时候，可以使用快捷查询方式
    NSString *str = [self.dataBase stringForQuery:@"select applicationId from CollectTable where applicationId = ?",applicationId];
    
    if (str.length > 0) {
        return YES;
    }
    
    return NO;
}

-(void)insertCollect:(NSDictionary *)dic{

    if (![self.dataBase executeUpdate:@"insert into CollectTable(applicationId,name,image) values(?,?,?)",dic[@"applicationId"],dic[@"name"],dic[@"image"]]) {
        
        NSLog(@"收藏失败");
    }
}

-(NSArray *)getCollectData{

    NSMutableArray *mutArr = [NSMutableArray array];
    
    FMResultSet *set = [self.dataBase executeQuery:@"select *  from CollectTable"];
    
    while ([set next]) {
        
        CollectModel *mod = [[CollectModel alloc] init];
        mod.name = [set stringForColumn:@"name"];
        mod.applicationId = [set stringForColumn:@"applicationId"];
        NSData *data = [set dataForColumn:@"image"];
        mod.image = [UIImage imageWithData:data];
        
        [mutArr addObject:mod];
    }
    return mutArr;
}

-(void)deleteCollectWith:(NSString *)applicationId{

    if (![self.dataBase executeUpdate:@"delete from CollectTable where applicationId = ?",applicationId]) {
        
        NSLog(@"删除收藏失败");
    }
}

@end

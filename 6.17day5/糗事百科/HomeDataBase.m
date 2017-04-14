//
//  HomeDataBase.m
//  
//
//  Created by lgh on 16/4/5.
//
//

#import "HomeDataBase.h"

@interface HomeDataBase ()

@property (nonatomic, strong) FMDatabase *dataBase;

@end

@implementation HomeDataBase

+ (instancetype)shareDataBase
{
    static HomeDataBase *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[HomeDataBase alloc] init];
        NSLog(@"%@", NSHomeDirectory());
        
        manager.dataBase = [[FMDatabase alloc] initWithPath:[NSHomeDirectory() stringByAppendingString:@"/Library/home.sqlite3"]];
        
        [manager.dataBase open];
        
        [manager.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS HomeTable (login text,content text,comments_count text,up text,myId text PRIMARY KEY)"];
        
        [manager.dataBase close];
        
    });
    return manager;
}
// 数据插入:
- (void)insertModel:(HomeModel *)model
{
    [self.dataBase open];
    
    [self.dataBase executeUpdate:@"INSERT INTO HomeTable (login, content, comments_count, up, myId) VALUES (?, ?, ?, ?, ?)", model.login, model.content, model.comments_count, model.up, model.myId];
    
    [self.dataBase close];
}
// 删除数据:
- (void)delectAllData
{
    [self.dataBase open];
    
    [self.dataBase executeUpdate:@"DELETE FROM HomeTable"];
    
    [self.dataBase close];
}

- (NSMutableArray *)searchAllData
{
    [self.dataBase open];
    
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [self.dataBase executeQuery:@"SELECT * FROM HomeTable"];
    
    while ([set next] == YES) {
        
        HomeModel *model = [[HomeModel alloc] init];
        model.login = [set stringForColumn:@"login"];
        model.up = [set stringForColumn:@"up"];
        model.comments_count = [set stringForColumn:@"comments_count"];
        model.myId = [set stringForColumn:@"myId"];
        model.content = [set stringForColumn:@"content"];
        
        [arrM addObject:model];
    }
    
    [self.dataBase close];
    
    return arrM;
}

@end















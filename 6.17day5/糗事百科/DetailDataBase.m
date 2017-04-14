//
//  DetailDataBase.m
//  
//
//  Created by lgh on 16/4/5.
//
//

#import "DetailDataBase.h"

@interface DetailDataBase ()

@property (nonatomic, strong) FMDatabase *dataBase;

@end

@implementation DetailDataBase

+ (instancetype)shareDataBase
{
    static DetailDataBase *manager;
    
    static dispatch_once_t onceToken;
    dispatch_once(&onceToken, ^{
        manager = [[DetailDataBase alloc] init];
        NSLog(@"%@", NSHomeDirectory());
        
        manager.dataBase = [[FMDatabase alloc] initWithPath:[NSHomeDirectory() stringByAppendingString:@"/Library/detail.sqlite3"]];
        
        [manager.dataBase open];
        
        [manager.dataBase executeUpdate:@"CREATE TABLE IF NOT EXISTS DetailTable (content text,login text,floor text, myId text)"];
        
        [manager.dataBase close];
        
    });
    return manager;
}
// 数据插入:
- (void)insertModel:(DetailModel *)model andId:(NSString *)myId
{
    [self.dataBase open];
    
    [self.dataBase executeUpdate:@"INSERT INTO DetailTable (content,login,floor, myId) VALUES (?, ?, ?, ?)", model.content, model.login, model.floor, myId];
    
    [self.dataBase close];
}
// 删除数据:
- (void)delectAllDataWithId:(NSString *)myId
{
    [self.dataBase open];
    
    [self.dataBase executeUpdate:@"DELETE FROM DetailTable where myId = ?", myId];
    
    [self.dataBase close];
}

- (NSMutableArray *)searchAllDataWithId:(NSString *)myId
{
    [self.dataBase open];
    
    NSMutableArray *arrM = [[NSMutableArray alloc] init];
    FMResultSet *set = [self.dataBase executeQuery:@"SELECT * FROM DetailTable where myId = ?", myId];
    
    while ([set next] == YES) {
#if 1
        DetailModel *model = [[DetailModel alloc] init];
        model.login = [set stringForColumn:@"login"];
        model.content = [set stringForColumn:@"content"];
        model.floor = [set stringForColumn:@"floor"];
        [arrM addObject:model];
#endif
    }
    
    [self.dataBase close];
    
    return arrM;
}

@end

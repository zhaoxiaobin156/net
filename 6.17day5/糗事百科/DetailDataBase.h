//
//  DetailDataBase.h
//  
//
//  Created by lgh on 16/4/5.
//
//

#import <Foundation/Foundation.h>
#import "DetailModel.h"
#import "FMDatabase.h"

@interface DetailDataBase : NSObject

+ (instancetype)shareDataBase;

- (void)insertModel:(DetailModel *)model andId:(NSString *)myId;
- (void)delectAllDataWithId:(NSString *)myId;
- (NSMutableArray *)searchAllDataWithId:(NSString *)myId;



@end

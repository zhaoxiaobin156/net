//
//  HomeDataBase.h
//  
//
//  Created by lgh on 16/4/5.
//
//

#import <Foundation/Foundation.h>
#import "HomeModel.h"
#import "FMDatabase.h"
/**
 *  第一界面的缓存管理:
 */
@interface HomeDataBase : NSObject

+ (instancetype)shareDataBase;

- (void)insertModel:(HomeModel *)model;
- (void)delectAllData;
- (NSMutableArray *)searchAllData;

@end

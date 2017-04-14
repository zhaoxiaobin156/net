//
//  LRCManager.m
//  1-AudioPlayer
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "LRCManager.h"

@implementation ItemModel

@end

@implementation LRCManager

-(instancetype)initWithPath:(NSString *)path{

    if (self = [super init]) {
        
        self.itemDataSource = [NSMutableArray array];
        
        [self paserItemWithPath:path];
    }
    return self;
}

//歌词的解析
-(void)paserItemWithPath:(NSString *)path{

    //读取文件内容
    NSString *contentStr = [NSString stringWithContentsOfFile:path encoding:NSUTF8StringEncoding error:nil];
    
    //以\n分割
    NSArray *arr = [contentStr componentsSeparatedByString:@"\n"];
    
    for (NSString *str in arr) {
        
        if ([str hasPrefix:@"[0"] || [str hasPrefix:@"[1"]) {
            
            //以符号集合@"[:]"进行分割
            NSCharacterSet *set = [NSCharacterSet characterSetWithCharactersInString:@"[:]"];
            
            NSArray *arr2 = [str componentsSeparatedByCharactersInSet:set];
            
            ItemModel *mod = [[ItemModel alloc] init];
            mod.time = [arr2[1] floatValue] * 60 + [arr2[2] floatValue];
            mod.itemContents = arr2[3];
            
            [self.itemDataSource addObject:mod];
        }
    }
}

-(NSInteger)rowFromTime:(float)time{

    for (int i = 0; i < self.itemDataSource.count; i++) {
        
        ItemModel *mod = self.itemDataSource[i];
        
        if (mod.time > time) {
            
            if (i == 0) {
                return i;
            }
            return i - 1;
        }
    }
    
    //唱完了，返回最后一行
    return self.itemDataSource.count - 1;
}

@end

//
//  LRCManager.h
//  1-AudioPlayer
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

//歌词模型类
@interface ItemModel : NSObject

@property(nonatomic,assign)float time;//时间

@property(nonatomic,copy)NSString *itemContents;//歌词内容

@end

//歌词解析类
@interface LRCManager : NSObject

@property(nonatomic,strong)NSMutableArray *itemDataSource;//存储歌词对象的数组

//通过歌词文件路径，解析歌词
-(instancetype)initWithPath:(NSString *)path;

//传入时间，返回第几行
-(NSInteger)rowFromTime:(float)time;

@end

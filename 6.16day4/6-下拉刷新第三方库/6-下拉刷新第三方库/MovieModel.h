//
//  MovieModel.h
//  6-下拉刷新第三方库
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface MovieModel : JSONModel

@property(nonatomic,copy)NSString *iconUrl;

@property(nonatomic,copy)NSString *name;

@property(nonatomic,copy)NSString *des;

@end

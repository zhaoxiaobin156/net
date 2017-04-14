//
//  MovieModel.h
//  4-解析练习
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface CastsModel : JSONModel

@property(nonatomic,copy)NSString *alt;

@property(nonatomic,copy)NSString *small;

@property(nonatomic,copy)NSString *name;

@end

@protocol CastsModel;

@interface MovieModel : JSONModel

@property(nonatomic,copy)NSString *title;

@property(nonatomic,copy)NSString *small;

@property(nonatomic,strong)NSArray <CastsModel>*castsArr;

@end

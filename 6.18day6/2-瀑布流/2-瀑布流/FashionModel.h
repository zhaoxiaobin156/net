//
//  FashionModel.h
//  2-瀑布流
//
//  Created by mac on 16/6/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface FashionModel : JSONModel

@property(nonatomic,copy)NSString *width;

@property(nonatomic,copy)NSString *height;

@property(nonatomic,copy)NSString *picUrl;

@property(nonatomic,copy)NSString *des;

@end

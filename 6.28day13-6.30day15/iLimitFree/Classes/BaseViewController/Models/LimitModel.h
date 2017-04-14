//
//  LimitModel.h
//  iLimitFree
//
//  Created by mac on 16/6/28.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "JSONModel.h"

@interface LimitModel : JSONModel

@property(nonatomic,copy)NSString *applicationId;//程序id

@property(nonatomic,copy)NSString *iconUrl;//图片

@property(nonatomic,copy)NSString *name;//程序名称

@property(nonatomic,copy)NSString <Optional>*expireDatetime;//剩余时间

@property(nonatomic,copy)NSString *starOverall;//评分

@property(nonatomic,copy)NSString *lastPrice;//价格

@property(nonatomic,copy)NSString *categoryName;//程序类型

@property(nonatomic,copy)NSString *shares;//分享

@property(nonatomic,copy)NSString *favorites;//收藏

@property(nonatomic,copy)NSString *downloads;//下载

@end

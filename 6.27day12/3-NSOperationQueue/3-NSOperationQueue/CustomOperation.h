//
//  CustomOperation.h
//  3-NSOperationQueue
//
//  Created by mac on 16/6/27.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <Foundation/Foundation.h>

//告诉编译器，我们会在后面声明这个类
@class CustomOperation;

typedef void(^myBlock)(NSData *data,CustomOperation *operation);

@interface CustomOperation : NSOperation

@property(nonatomic,copy)NSString *url;//保存图片地址

@property(nonatomic,strong)NSMutableData *mutData;//接收图片数据

@property(nonatomic,copy)myBlock block;

@property(nonatomic,assign)NSInteger tag;//每个任务下载一张图，通过tag和图片对应

//在这任务中做图片的下载，输入一个图片地址，返回图片的二进制数据
-(instancetype)initWithUrl:(NSString *)url andBlock:(myBlock)block;

@end

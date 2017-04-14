//
//  BaseViewController.h
//  iLimitFree
//
//  Created by mac on 16/6/28.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface BaseViewController : UIViewController

//在使用xib和storyBoard来做页面布局时，可以使用继承，但是父类必须是纯代码写的页面

@property(nonatomic,assign)int tag;//区分限免，降价，免费

//为了让子类可以调用，需要将方法声明暴露出来
-(void)observeNetStatus;

@end

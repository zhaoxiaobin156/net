//
//  UIViewController+AlertShow.h
//  3-淘宝界面Json解析
//
//  Created by mac on 16/6/13.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

//给UIViewController写一个类别，凡是UIViewController对象或者是UIViewController的子类对象都可以使用该类别里面的所有方法
@interface UIViewController (AlertShow)

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message;

@end

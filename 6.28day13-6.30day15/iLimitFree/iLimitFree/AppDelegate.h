//
//  AppDelegate.h
//  iLimitFree
//
//  Created by mac on 16/6/28.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface AppDelegate : UIResponder <UIApplicationDelegate>

@property (strong, nonatomic) UIWindow *window;

/*
 屏幕分辩率
 
 3.5寸  @2x   640*960
 4寸    @2x   640*1136
 4.7寸  @2x   750*1334
 5.5寸  @3x   1242*2208
 
 程序启动图有两个作用:
 1.设置一张图片，放置公司logo信息
 2.告知应用程序，你的分辩率是多少
 */

@end


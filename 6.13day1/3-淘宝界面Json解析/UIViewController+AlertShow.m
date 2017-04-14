//
//  UIViewController+AlertShow.m
//  3-淘宝界面Json解析
//
//  Created by mac on 16/6/13.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "UIViewController+AlertShow.h"

@implementation UIViewController (AlertShow)

-(void)showAlertWithTitle:(NSString *)title andMessage:(NSString *)message{

    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:title message:message delegate:nil cancelButtonTitle:@"取消" otherButtonTitles:@"确定", nil];
    [alert show];
}

@end

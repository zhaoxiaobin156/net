//
//  UIViewController+showAlertView.h
//  
//
//  Created by lgh on 16/3/22.
//
//

#import <UIKit/UIKit.h>

// UIViewController的类别:
@interface UIViewController (showAlertView)

// 给UIViewController添加方法:
- (void)showMessage:(NSString *)message andButtonMessage:(NSString *)btnMessage;

@end

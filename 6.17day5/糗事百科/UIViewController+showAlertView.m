//
//  UIViewController+showAlertView.m
//  
//
//  Created by lgh on 16/3/22.
//
//

#import "UIViewController+showAlertView.h"

@implementation UIViewController (showAlertView)

- (void)showMessage:(NSString *)message andButtonMessage:(NSString *)btnMessage
{
    UIAlertView *a = [[UIAlertView alloc] initWithTitle:message message:nil delegate:nil cancelButtonTitle:nil otherButtonTitles:btnMessage, nil];
    
    [a show];
}

@end

//
//  TableViewController.h
//  2-UIPopoverController
//
//  Created by mac on 16/6/23.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
typedef void(^myBlock)(UIColor *color);

//@protocol ChangeColorDelegate <NSObject>
//
//-(void)changeColor:(UIColor *)color;
//
//@end

@interface TableViewController : UITableViewController

//@property(nonatomic,weak)id<ChangeColorDelegate> delegate;

@property(nonatomic,copy)myBlock block;

@end

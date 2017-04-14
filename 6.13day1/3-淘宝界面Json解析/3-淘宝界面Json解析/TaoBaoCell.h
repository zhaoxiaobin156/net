//
//  TaoBaoCell.h
//  3-淘宝界面Json解析
//
//  Created by mac on 16/6/13.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "TaoBaoModel.h"

@interface TaoBaoCell : UITableViewCell

//传递模型对象进来，刷新UI界面
-(void)refreshUI:(TaoBaoModel *)mod;

@end

//
//  LimitCell.h
//  iLimitFree
//
//  Created by mac on 16/6/28.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface LimitCell : UITableViewCell

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *expireDatetimeLabel;

@property (weak, nonatomic) IBOutlet UIImageView *starOverallImgView;

//评分图片固定宽度约束
@property (weak, nonatomic) IBOutlet NSLayoutConstraint *starWidthConstraint;

@property (weak, nonatomic) IBOutlet UILabel *lastPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *sharesLabel;

@property (weak, nonatomic) IBOutlet UILabel *favoritesLabel;

@property (weak, nonatomic) IBOutlet UILabel *downloadsLabel;

//重写这个model的set方法，来刷新cell
@property(nonatomic,strong)LimitModel *mod;

@end

//
//  FashionCell.m
//  2-瀑布流
//
//  Created by mac on 16/6/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "FashionCell.h"
#import "UIImageView+WebCache.h"

@interface FashionCell ()

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *imgHeight;

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *desL;

@end

@implementation FashionCell

-(void)refreshUI:(FashionModel *)mod{

    [self.imgView sd_setImageWithURL:[NSURL URLWithString:mod.picUrl]];
    self.desL.text = mod.des;
    
    CGFloat w = ([UIScreen mainScreen].bounds.size.width - 30) / 2;
    self.imgHeight.constant = mod.height.floatValue / mod.width.floatValue * w;
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

@end

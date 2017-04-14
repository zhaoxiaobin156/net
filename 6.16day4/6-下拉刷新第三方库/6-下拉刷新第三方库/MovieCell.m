//
//  MovieCell.m
//  6-下拉刷新第三方库
//
//  Created by mac on 16/6/16.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "MovieCell.h"
#import "UIImageView+WebCache.h"

@implementation MovieCell

-(void)refreshUI:(MovieModel *)mod{

    [self.imgView sd_setImageWithURL:[NSURL URLWithString:mod.iconUrl]];
    self.nameL.text = [NSString stringWithFormat:@"《%@》",mod.name];
    self.descriptionL.text = mod.des;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

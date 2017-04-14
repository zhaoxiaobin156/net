//
//  TableViewCell.m
//  1-AudioPlayer
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "TableViewCell.h"

@implementation TableViewCell

- (void)awakeFromNib {
    // Initialization code
    
    //设置cell的背景没有颜色
    self.backgroundColor = [[UIColor whiteColor] colorWithAlphaComponent:0.3];
    
    //设置不能选择cell
    self.selectionStyle = UITableViewCellSelectionStyleNone;
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

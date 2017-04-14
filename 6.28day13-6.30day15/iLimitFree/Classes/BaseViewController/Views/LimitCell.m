//
//  LimitCell.m
//  iLimitFree
//
//  Created by mac on 16/6/28.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "LimitCell.h"

@implementation LimitCell

- (void)awakeFromNib {
    // Initialization code
}

-(void)setMod:(LimitModel *)mod{

    _mod = mod;
    
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:_mod.iconUrl]];
    
    self.nameLabel.text = _mod.name;
    
    //时间的比较处理：
    
    //时间格式类
    NSDateFormatter *formatter = [[NSDateFormatter alloc] init];
    formatter.dateFormat = @"YYYY-MM-dd HH:mm:ss";
    
    //这里转换后的时间是零时区时间(-8h)
    NSDate *expireTime = [formatter dateFromString:_mod.expireDatetime];
    
    //获取系统当前时间(-8h)
    NSDate *nowDate = [NSDate date];
    
//    NSLog(@"expireTime = %@ --- nowDate = %@",expireTime,nowDate);
    
    //计算两个时间相距多少秒
    CGFloat time = [expireTime timeIntervalSinceDate:nowDate];
    
//    NSLog(@"time = %f",time);
    
    //计算出相距的小时，分钟
    int hour = time / 3600;
    int minute = (int)time % 3600 / 60;
    
    self.expireDatetimeLabel.text = [NSString stringWithFormat:@"剩余%d小时%d分钟",hour,minute];
    
    //保持视图的比例不变，靠左
    self.starOverallImgView.contentMode = UIViewContentModeLeft;
    
    //设置子视图不能超出父视图边界
    self.starOverallImgView.clipsToBounds = YES;
    
    //获取评分
    CGFloat score = _mod.starOverall.floatValue;
    
    //获取比例
    CGFloat rate = score / 5;
    
    //修改starOverallImgView宽度，来达到修改评分的效果
    self.starWidthConstraint.constant = rate * 65;
    
    self.lastPriceLabel.text = [NSString stringWithFormat:@"¥ %@",_mod.lastPrice];
    
    self.categoryNameLabel.text = _mod.categoryName;
    
    self.sharesLabel.text = [NSString stringWithFormat:@"分享:%@",_mod.shares];
    
    self.favoritesLabel.text = [NSString stringWithFormat:@"收藏:%@",_mod.favorites];
    
    self.downloadsLabel.text = [NSString stringWithFormat:@"下载:%@",_mod.downloads];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

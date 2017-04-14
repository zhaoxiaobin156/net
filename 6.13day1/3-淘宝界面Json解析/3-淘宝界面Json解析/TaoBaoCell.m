//
//  TaoBaoCell.m
//  3-淘宝界面Json解析
//
//  Created by mac on 16/6/13.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "TaoBaoCell.h"
#import "UIImageView+WebCache.h"//第三方下载图片框架

//匿名类别
@interface TaoBaoCell ()

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *nameL;

@property (weak, nonatomic) IBOutlet UILabel *nickL;

@property (weak, nonatomic) IBOutlet UILabel *priceL;

@end

@implementation TaoBaoCell

-(void)refreshUI:(TaoBaoModel *)mod{

    //第三方的方法sd_setImageWithURL：通过图片的链接异步下载图片
    [self.imgView sd_setImageWithURL:[NSURL URLWithString:mod.img]];
    
    //参数二：占位图片
//    [self.imgView sd_setImageWithURL:[NSURL URLWithString:mod.img] placeholderImage:[UIImage imageNamed:@""]];
    
    self.nameL.text = mod.name;
    self.nickL.text = mod.nick;
    self.priceL.text = [NSString stringWithFormat:@"¥%@",mod.price];
}

- (void)awakeFromNib {
    // Initialization code
    [super awakeFromNib];
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

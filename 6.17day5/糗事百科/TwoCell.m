//
//  TwoCell.m
//  
//
//  Created by lgh on 16/4/6.
//
//

#import "TwoCell.h"
#import "UIImageView+WebCache.h"

@interface TwoCell ()

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@property (weak, nonatomic) IBOutlet UIImageView *leftImageView;

@property (weak, nonatomic) IBOutlet UIImageView *midImageView;
@property (weak, nonatomic) IBOutlet UIImageView *rightImageView;

@end

@implementation TwoCell

- (void)refreshUI:(NewsModel *)model
{
    self.titleLabel.text = model.title;
    [self.leftImageView sd_setImageWithURL:[NSURL URLWithString:model.images[0]]];
    [self.midImageView sd_setImageWithURL:[NSURL URLWithString:model.images[1]]];
    [self.rightImageView sd_setImageWithURL:[NSURL URLWithString:model.images[2]]];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

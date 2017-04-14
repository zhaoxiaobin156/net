//
//  OneCell.m
//  
//
//  Created by lgh on 16/4/6.
//
//

#import "OneCell.h"
#import "UIImageView+WebCache.h"

@interface OneCell ()

@property (weak, nonatomic) IBOutlet UIImageView *headerImageView;

@property (weak, nonatomic) IBOutlet UILabel *titleLabel;

@end

@implementation OneCell

- (void)refreshUI:(NewsModel *)model
{
    [self.headerImageView sd_setImageWithURL:[NSURL URLWithString:model.thumbnail]];
    self.titleLabel.text = model.title;
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

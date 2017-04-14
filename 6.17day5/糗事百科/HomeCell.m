//
//  HomeCell.m
//  
//
//  Created by lgh on 16/4/5.
//
//

#import "HomeCell.h"

@interface HomeCell ()

@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *upLabel;

@end


@implementation HomeCell

- (void)refreshUI:(HomeModel *)model
{
    self.loginLabel.text = model.login;
    self.contentLabel.text = model.content;
    self.upLabel.text = [NSString stringWithFormat:@"%@好笑·%@评论", model.up, model.comments_count];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

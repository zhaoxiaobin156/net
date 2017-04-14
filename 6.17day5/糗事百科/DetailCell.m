//
//  DetailCell.m
//  
//
//  Created by lgh on 16/4/5.
//
//

#import "DetailCell.h"

@interface DetailCell ()

@property (weak, nonatomic) IBOutlet UILabel *loginLabel;

@property (weak, nonatomic) IBOutlet UILabel *contentLabel;

@property (weak, nonatomic) IBOutlet UILabel *floorLabel;


@end

@implementation DetailCell

- (void)refreshUI:(DetailModel *)model
{
    self.loginLabel.text = model.login;
    self.contentLabel.text = model.content;
    self.floorLabel.text=  [model.floor stringByAppendingString:@"楼"];
}

- (void)awakeFromNib {
    // Initialization code
}

- (void)setSelected:(BOOL)selected animated:(BOOL)animated {
    [super setSelected:selected animated:animated];

    // Configure the view for the selected state
}

@end

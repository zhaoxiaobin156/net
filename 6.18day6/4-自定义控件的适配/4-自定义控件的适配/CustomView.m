//
//  CustomView.m
//  4-自定义控件的适配
//
//  Created by mac on 16/6/18.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "CustomView.h"

@implementation CustomView

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    
    if (self) {
        
        self.backgroundColor = [UIColor yellowColor];
        
        [self myInitFunction];
    }
    return self;
}

//拖控件的初始化方法
-(void)awakeFromNib{
    
    [self myInitFunction];
    
    [super awakeFromNib];
}

-(void)myInitFunction{
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    self.label = [[UILabel alloc] initWithFrame:CGRectMake(0, 0, w, h / 3)];
    self.label.textAlignment = NSTextAlignmentCenter;
    [self addSubview:self.label];
    
    self.imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, h / 3, w, h / 3 * 2)];
    [self addSubview:self.imgView];
}

//当前视图frame发生变化，子视图要相应变化时调用以下方法达到适配
-(void)layoutSubviews{
    
    [super layoutSubviews];
    
    CGFloat w = self.bounds.size.width;
    CGFloat h = self.bounds.size.height;
    
    self.label.frame = CGRectMake(0, 0, w, h / 3);
    self.imgView.frame = CGRectMake(0, h / 3, w, h / 3 * 2);
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

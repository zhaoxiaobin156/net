//
//  QFPlayer.m
//  3-AVPlayer
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "QFPlayer.h"

@implementation QFPlayer

//修改当前view的layer类型(默认为CALayer类型)为AVPlayerLayer类型，这样才能安装播放器AVPlayer(AVPlayerLayer.layer = 安装播放器)
+(Class)layerClass{

    return [AVPlayerLayer class];
}

//重写setter方法(在AVPlayerLayer层安装播放器)
-(void)setPlayer:(AVPlayer *)player{

    AVPlayerLayer *avLayer = (id)self.layer;
    
    avLayer.player = player;
}

//重写getter方法(获取播放器)
-(AVPlayer *)player{

    AVPlayerLayer *avLayer = (id)self.layer;
    
    return avLayer.player;
}

/*
// Only override drawRect: if you perform custom drawing.
// An empty implementation adversely affects performance during animation.
- (void)drawRect:(CGRect)rect {
    // Drawing code
}
*/

@end

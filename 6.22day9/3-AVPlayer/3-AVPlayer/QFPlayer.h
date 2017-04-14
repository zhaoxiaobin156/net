//
//  QFPlayer.h
//  3-AVPlayer
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import <UIKit/UIKit.h>
#import <AVFoundation/AVFoundation.h>

//视频播放视图
@interface QFPlayer : UIView

@property(nonatomic,strong)AVPlayer *player;

@end

//
//  ViewController.m
//  3-AVPlayer
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>
#import "QFPlayer.h"

@interface ViewController ()

//@property(nonatomic,strong)QFPlayer *qfPlayer;

@property (weak, nonatomic) IBOutlet QFPlayer *storyBoardQFPlayer;

@property (weak, nonatomic) IBOutlet UILabel *currentTimeL;

@property (weak, nonatomic) IBOutlet UILabel *totalTimeL;

@property (weak, nonatomic) IBOutlet UISlider *timeProgress;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //AVAudioPlayer：音频播放器，只能播放音频；只能播放本地音频，不能播放远程音频；需要开定时器同步；时间返回多少秒；预播放 prepareToPlay
    //AVPlayer：可以播放音频，也可以播放视频；可以播放本地的，也可以播放远程的；不用开定时器同步，内部有提供方法进行同步；时间返回CMTime结构体，需要通过结构体算出是多少秒；KVO监听预播放
    
//    self.qfPlayer = [[QFPlayer alloc] initWithFrame:CGRectMake(0, 20, 375, 250)];
    
    //创建播放项目
    AVPlayerItem *item = [[AVPlayerItem alloc] initWithURL:[NSURL URLWithString:@"http://10.20.158.16/1.mp4"]];
    
    //创建qfPlayer播放视图里面的播放器
    self.storyBoardQFPlayer.player = [[AVPlayer alloc] initWithPlayerItem:item];
    
//    [self.view addSubview:self.qfPlayer];
    
    [self.storyBoardQFPlayer.player play];
    
    //KVO监听是否ready to play
    //监听当前播放器的播放项目的状态
    [self.storyBoardQFPlayer.player.currentItem addObserver:self forKeyPath:@"status" options:NSKeyValueObservingOptionNew context:nil];
}

//KVO响应方法
-(void)observeValueForKeyPath:(NSString *)keyPath ofObject:(id)object change:(NSDictionary *)change context:(void *)context{

    if ([keyPath isEqualToString:@"status"] && object == self.storyBoardQFPlayer.player.currentItem) {
        
        if ([change[@"new"] integerValue] == AVPlayerItemStatusReadyToPlay) {
            
            NSLog(@"可以播放");
            
            //获取总的时间
            CMTime totalTime = self.storyBoardQFPlayer.player.currentItem.duration;
            
            NSInteger t = totalTime.value / totalTime.timescale;//totalTime.value 总的帧数 totalTime.timescale 帧率：每秒播放多少帧
            
            self.totalTimeL.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",t / 3600,t / 60 % 60,t % 60];
            
            self.currentTimeL.text = @"00:00:00";
            
            //每隔指定的时间调用block里面的代码
            CMTime time = CMTimeMake(1, 1);
            
            [self.storyBoardQFPlayer.player addPeriodicTimeObserverForInterval:time queue:nil usingBlock:^(CMTime time) {
                
                NSLog(@"播放中");
                
                //修改进度条
//                __weak typeof(self) mySelf = self;
                CMTime currentTime = self.storyBoardQFPlayer.player.currentItem.currentTime;
                
                NSInteger c = currentTime.value / currentTime.timescale;
                
                self.timeProgress.value = c * 1.0 / t;
                
                self.currentTimeL.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",c / 3600,c / 60 % 60,c % 60];
            }];
        }
    }
}

//移除监听
-(void)dealloc{

    [self.storyBoardQFPlayer.player.currentItem removeObserver:self forKeyPath:@"status"];
}

- (IBAction)timeProgress:(UISlider *)sender {
    
    CMTime totalTime = self.storyBoardQFPlayer.player.currentItem.duration;
    
    CMTime time = CMTimeMake(sender.value * totalTime.value, totalTime.timescale);
    
    //定位到对应的时间点
    [self.storyBoardQFPlayer.player seekToTime:time];
}

- (IBAction)pauseBtn:(UIButton *)sender {
}

- (IBAction)playBtn:(UIButton *)sender {
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

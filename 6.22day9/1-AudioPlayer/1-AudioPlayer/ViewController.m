//
//  ViewController.m
//  1-AudioPlayer
//
//  Created by mac on 16/6/22.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"
#import <AVFoundation/AVFoundation.h>//AV指audio和video
#import "TableViewCell.h"
#import "LRCManager.h"

@interface ViewController ()<UITableViewDelegate,UITableViewDataSource,AVAudioPlayerDelegate>

@property (weak, nonatomic) IBOutlet UILabel *currentTimeL;

@property (weak, nonatomic) IBOutlet UILabel *totalTimeL;

@property (weak, nonatomic) IBOutlet UISlider *timeProgress;

@property (weak, nonatomic) IBOutlet UIButton *playB;

@property(nonatomic,strong)AVAudioPlayer *player;

@property(nonatomic,strong)NSTimer *timer;

@property(nonatomic,strong)NSArray *musicListArr;//播放列表

@property(nonatomic,assign)NSInteger currentCount;//当前播放第几首音乐

@property (weak, nonatomic) IBOutlet UITableView *tableView;

@property(nonatomic,strong)LRCManager *lrcManager;//歌词解析属性

@property(nonatomic,assign)NSInteger row;//显示歌词是第几行

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //设置没有分割线
    self.tableView.separatorStyle = UITableViewCellSeparatorStyleNone;
    
    self.tableView.bounces = NO;
    self.tableView.showsVerticalScrollIndicator = NO;
    
    [self myInitPlayer];
}

-(void)myInitPlayer{
    
    NSURL *url = [[NSBundle mainBundle] URLForResource:self.musicListArr[self.currentCount] withExtension:@"mp3"];
    
    //通过音频的URL路径创建一个音频播放器对象
    self.player = [[AVAudioPlayer alloc] initWithContentsOfURL:url error:nil];
    
    //设置音频播放器的代理
    self.player.delegate = self;
    
    //预播放：校验编码，格式是否有错误
    if ([self.player prepareToPlay] == YES) {
        
        NSLog(@"可以播放");
        
        //获取歌词文件路径
        NSString *path = [[NSBundle mainBundle] pathForResource:self.musicListArr[self.currentCount] ofType:@"lrc"];
        
        //创建歌词解析对象
        self.lrcManager = [[LRCManager alloc] initWithPath:path];
        
        [self.tableView reloadData];
        
        //设置背景图片
        NSString *imgPath = [[NSBundle mainBundle] pathForResource:self.musicListArr[self.currentCount] ofType:@"jpg"];
        
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:self.tableView.bounds];
        
        imgView.image = [UIImage imageWithContentsOfFile:imgPath];
        
        self.tableView.backgroundView = imgView;
        
        //获取总的时间
        NSInteger totalTime = self.player.duration;
        
        self.totalTimeL.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",totalTime / 3600,totalTime / 60 % 60,totalTime % 60];
        
        self.currentTimeL.text = @"00:00:00";
        
        self.timer = [NSTimer scheduledTimerWithTimeInterval:1.0 target:self selector:@selector(updateTimer:) userInfo:nil repeats:YES];
    }
}

-(NSArray *)musicListArr{

    if (_musicListArr == nil) {
        _musicListArr = @[@"李白",@"喜剧之王",@"作曲家"];
    }
    return _musicListArr;
}

-(void)updateTimer:(NSTimer *)timer{

    NSInteger currentTime = self.player.currentTime;
    
    self.currentTimeL.text = [NSString stringWithFormat:@"%02ld:%02ld:%02ld",currentTime / 3600,currentTime / 60 % 60,currentTime % 60];
    
    self.timeProgress.value = currentTime * 1.0 / self.player.duration;
    
    //传入时间，获取到显示的是第几行
    self.row = [self.lrcManager rowFromTime:currentTime];
    
    [self.tableView reloadData];
    
    //让self.row滚到中间
    [self.tableView scrollToRowAtIndexPath:[NSIndexPath indexPathForRow:self.row inSection:0] atScrollPosition:UITableViewScrollPositionMiddle animated:YES];
}

//上一曲
- (IBAction)preBtn:(UIButton *)sender {
    
    self.currentCount = (self.currentCount - 1 + self.musicListArr.count) % self.musicListArr.count;
    
    [self myInitPlayer];
    
    [self.player play];
}

//下一曲
- (IBAction)nextBtn:(UIButton *)sender {
    
    self.currentCount = (self.currentCount + 1) % self.musicListArr.count;
    
    [self myInitPlayer];
    
    [self.player play];
}

//播放
- (IBAction)playBtn:(UIButton *)sender {
    
    if ([sender.currentTitle isEqualToString:@"播放"]) {
        
        [sender setTitle:@"暂停" forState:UIControlStateNormal];
        
        [self.player play];
    }else{
        
        [sender setTitle:@"播放" forState:UIControlStateNormal];
        
        [self.player pause];
    }
}

//进度条
- (IBAction)timeProgress:(UISlider *)sender {
    
    //设置播放时间
    self.player.currentTime = sender.value * self.player.duration;
}

//音量
- (IBAction)volumeS:(UISlider *)sender {
    
    //音量的范围0 ～ 1.0之间
    self.player.volume = sender.value;
}

#pragma mark --- UITableViewDelegate

-(NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section{

    return self.lrcManager.itemDataSource.count;
}

-(UITableViewCell *)tableView:(UITableView *)tableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{

    TableViewCell *cell = [tableView dequeueReusableCellWithIdentifier:@"cell" forIndexPath:indexPath];
    
    ItemModel *mod = self.lrcManager.itemDataSource[indexPath.row];
    cell.itemLabel.text = mod.itemContents;
    
    if (indexPath.row == self.row) {
        
        cell.itemLabel.textColor = [UIColor redColor];
    }else{
    
        cell.itemLabel.textColor = [UIColor blackColor];
    }
    
    return cell;
}

#pragma mark --- AVAudioPlayerDelegate

//播放完一首歌调用
-(void)audioPlayerDidFinishPlaying:(AVAudioPlayer *)player successfully:(BOOL)flag{

    //手动调用切换到下一首
    [self nextBtn:nil];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

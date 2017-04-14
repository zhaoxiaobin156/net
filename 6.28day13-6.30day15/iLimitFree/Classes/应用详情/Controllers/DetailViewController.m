//
//  DetailViewController.m
//  iLimitFree
//
//  Created by mac on 16/6/29.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "DetailViewController.h"
#import <CoreLocation/CoreLocation.h>

@interface DetailViewController ()<CLLocationManagerDelegate>

@property (weak, nonatomic) IBOutlet UIImageView *imgView;

@property (weak, nonatomic) IBOutlet UILabel *nameLabel;

@property (weak, nonatomic) IBOutlet UILabel *lastPriceLabel;

@property (weak, nonatomic) IBOutlet UILabel *fileSizeLabel;

@property (weak, nonatomic) IBOutlet UILabel *categoryNameLabel;

@property (weak, nonatomic) IBOutlet UILabel *starOverallLabel;

@property (weak, nonatomic) IBOutlet UIButton *collectBtn;

@property (weak, nonatomic) IBOutlet UIScrollView *topScrollView;

@property (weak, nonatomic) IBOutlet UILabel *descriptionLabel;

@property (weak, nonatomic) IBOutlet NSLayoutConstraint *backImgViewHeightConstraint;

//位置服务管理器
@property(nonatomic,strong)CLLocationManager *locationManager;

@property (weak, nonatomic) IBOutlet UIScrollView *bottomScrollView;

//存储App的下载地址
@property(nonatomic,copy)NSString *itunesUrl;

@property(nonatomic,strong)NSMutableDictionary *collectMutDic;

@end

@implementation DetailViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    
    [self initNavigationBar];
    [self getData];
    [self initLocationService];
    [self checkCollect];
}

-(void)initNavigationBar{

    self.title = @"应用详情";
    
    UIButton *backBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backBtn.frame = CGRectMake(0, 0, 63, 30);
    [backBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_back"] forState:UIControlStateNormal];
    [backBtn setTitle:@"返回" forState:UIControlStateNormal];
    [backBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backBtn addTarget:self action:@selector(back) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.leftBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backBtn];
    
    UIButton *backToHomeBtn = [UIButton buttonWithType:UIButtonTypeSystem];
    backToHomeBtn.frame = CGRectMake(0, 0, 60, 30);
    [backToHomeBtn setBackgroundImage:[UIImage imageNamed:@"buttonbar_action"] forState:UIControlStateNormal];
    [backToHomeBtn setTitle:@"Home" forState:UIControlStateNormal];
    [backToHomeBtn setTitleColor:[UIColor blackColor] forState:UIControlStateNormal];
    [backToHomeBtn addTarget:self action:@selector(backToHome) forControlEvents:UIControlEventTouchUpInside];
    
    self.navigationItem.rightBarButtonItem = [[UIBarButtonItem alloc] initWithCustomView:backToHomeBtn];
}

-(void)back{
    
    [self.navigationController popViewControllerAnimated:YES];
}

-(void)backToHome{

    [self.navigationController popToRootViewControllerAnimated:YES];
}

- (IBAction)collectBtn:(UIButton *)sender {
    
    NSData *data = UIImagePNGRepresentation(self.imgView.image);
    
    [self.collectMutDic setObject:data forKey:@"image"];
    
    [[SQLManager shareInstance] insertCollect:self.collectMutDic];
    
    //再次检查状态，修改为已收藏
    [self checkCollect];
}

- (IBAction)downloadBtn:(UIButton *)sender {
    
    //将http -> itms-apps：将字符串修改成可以下载的字符串
    NSMutableString *mutStr = [NSMutableString stringWithString:self.itunesUrl];
    [mutStr replaceCharactersInRange:NSMakeRange(0, 4) withString:@"itms-apps"];
    
    //调取系统的AppStore应用去下载
    //打电话：tel://10010
    //发短信：sms://10010
    //发邮件：mailto://4444@qq.com
    [[UIApplication sharedApplication] openURL:[NSURL URLWithString:mutStr]];
}

-(void)getData{

    [[HttpManager shareInstance] getAppDetailInfoById:self.applicationId AndSuccess:^(id object) {
        
        NSDictionary *dic = object;
        
        //收藏字典
        self.collectMutDic = [NSMutableDictionary dictionary];
        [self.collectMutDic setObject:dic[@"applicationId"] forKey:@"applicationId"];
        [self.collectMutDic setObject:dic[@"name"] forKey:@"name"];
        
        [self.imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"iconUrl"]]];
        self.nameLabel.text = dic[@"name"];
        self.lastPriceLabel.text = [NSString stringWithFormat:@"原价:¥ %@ 限免中",dic[@"lastPrice"]];
        self.fileSizeLabel.text = [NSString stringWithFormat:@"%@MB",dic[@"fileSize"]];
        self.categoryNameLabel.text = [NSString stringWithFormat:@"类型:%@",dic[@"categoryName"]];
        self.starOverallLabel.text = [NSString stringWithFormat:@"评分:%@",dic[@"starOverall"]];
        
        NSArray *imgArr = dic[@"photos"];
        
        self.topScrollView.contentSize = CGSizeMake(imgArr.count * 90, 0);
        
        for (int i = 0; i < imgArr.count; i++) {
            
            UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(90 * i, 0, 80, 80)];
            
            NSDictionary *dic = imgArr[i];
            
            [imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"smallUrl"]]];
            
            [self.topScrollView addSubview:imgView];
        }
        
        self.descriptionLabel.text = dic[@"description"];

#if 0
        //计算文字所占用的高度
        CGFloat height = [dic[@"description"] boundingRectWithSize:CGSizeMake(WIDTH - 40, CGFLOAT_MAX) options:NSStringDrawingUsesLineFragmentOrigin | NSStringDrawingUsesFontLeading attributes:@{NSFontAttributeName:[UIFont systemFontOfSize:13]} context:nil].size.height;
        
        //修改背景图的高度
        self.backImgViewHeightConstraint.constant = 258 + height + 10;
#endif
        
    } AndFailure:^(NSError *error) {
        
        NSLog(@"获取详情信息失败，error = %@",error);
        
    }];
}

-(void)initLocationService{

    self.locationManager = [[CLLocationManager alloc] init];
    
    //设置代理，获取定位结果
    self.locationManager.delegate = self;
    
    //支持永久定位
    [self.locationManager requestAlwaysAuthorization];
    
    //开始定位
    [self.locationManager startUpdatingLocation];
    
    //需要在Info.plist文件中添加以下两个选项
//    NSLocationWhenInUseUsageDescription
//    NSLocationAlwaysUsageDescription
}

#pragma mark --- CLLocationManagerDelegate

-(void)locationManager:(CLLocationManager *)manager didUpdateLocations:(NSArray *)locations{

    NSLog(@"定位成功");
    
    CLLocation *location = [locations firstObject];
    
    //纬度：113.968651，经度：22.586536
    CGFloat latitude = location.coordinate.latitude;
    CGFloat longitude = location.coordinate.longitude;
    
    NSLog(@"latitude = %f,longitude = %f",latitude,longitude);
    
    //获取附近App
    [[HttpManager shareInstance] getNearByAppWithLatitude:latitude AndLongitude:longitude AndSuccess:^(id object) {
        
        NSArray *arr = object;
        
        [self layoutBottomScrollViewWithArray:arr];
        
    } AndFailure:^(NSError *error) {
        
        NSLog(@"获取附近App失败，error = %@",error);
        
    }];
    
    //定位成功，结束定位
    [manager stopUpdatingLocation];
}

-(void)layoutBottomScrollViewWithArray:(NSArray *)arr{

    self.bottomScrollView.contentSize = CGSizeMake(90 * arr.count, 0);
    
    //为了避免重叠
    for (UIView *view in self.bottomScrollView.subviews) {
        
        [view removeFromSuperview];
    }
    
    for (int i = 0; i < arr.count; i++) {
        
        NSDictionary *dic = arr[i];
        
        //获取下载链接
        self.itunesUrl = dic[@"itunesUrl"];
        
        //放图片和标题的view
        UIView *view = [[UIView alloc] initWithFrame:CGRectMake(i * 90, 0, 80, 100)];
        
        //将tag值就等同于applicationId，点击view的时候就直接将tag传递过去
        NSString *applicationId = dic[@"applicationId"];
        view.tag = applicationId.integerValue;
        
        [self.bottomScrollView addSubview:view];
        
        //图片
        UIImageView *imgView = [[UIImageView alloc] initWithFrame:CGRectMake(0, 0, 80, 80)];
        [imgView sd_setImageWithURL:[NSURL URLWithString:dic[@"iconUrl"]]];
        [view addSubview:imgView];
        
        //标题
        UILabel *label = [[UILabel alloc] initWithFrame:CGRectMake(0, 80, 80, 20)];
        label.text = dic[@"name"];
        label.textColor = [UIColor darkGrayColor];
        label.textAlignment = NSTextAlignmentCenter;
        label.font = [UIFont systemFontOfSize:13];
        label.adjustsFontSizeToFitWidth = YES;
        [view addSubview:label];
        
        //点击手势
        UITapGestureRecognizer *tap = [[UITapGestureRecognizer alloc] initWithTarget:self action:@selector(tap:)];
        [view addGestureRecognizer:tap];
    }
}

-(void)tap:(UIGestureRecognizer *)tap{

    //获取点击的view的tag
    NSInteger tag = tap.view.tag;
    
    NSString *applicationId = [NSString stringWithFormat:@"%ld",tag];
    
    DetailViewController *detailVC = [self.storyboard instantiateViewControllerWithIdentifier:@"detail"];
    
    detailVC.applicationId = applicationId;
    
    [self.navigationController pushViewController:detailVC animated:YES];
}

-(void)locationManager:(CLLocationManager *)manager didFailWithError:(NSError *)error{

    NSLog(@"定位失败，error = %@",error);
}

-(void)checkCollect{

    if ([[SQLManager shareInstance] isCollectWith:self.applicationId]) {
        
        self.collectBtn.enabled = NO;
        [self.collectBtn setTitle:@"已收藏" forState:UIControlStateNormal];
        [self.collectBtn setTitleColor:[UIColor darkGrayColor] forState:UIControlStateNormal];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender {
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

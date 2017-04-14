//
//  ViewController.m
//  2-NSThreadDemo
//
//  Created by mac on 16/6/27.
//  Copyright (c) 2016年 mac. All rights reserved.
//

#import "ViewController.h"

@interface ViewController (){

    NSThread *_thread4;
    NSThread *_thread5;
    NSLock *_lock;//线程锁
    int _sum;
}

@property (weak, nonatomic) IBOutlet UIProgressView *progressView;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    //在没有创建子线程之前，获取到主线程
    NSThread *thread = [NSThread currentThread];
    
    NSLog(@"thread = %@",thread);
    
    //添加一个观察者，获取子线程退出的事件
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(threadExit:) name:NSThreadWillExitNotification object:nil];
    
    //实例化线程锁
    _lock = [[NSLock alloc] init];
}

- (IBAction)createThread1:(UIButton *)sender {
    
    //三种创建NSThread方式：
    //1.NSObject的方法，直接启动子线程
    
    //启动一个线程，线程的作用就是执行这个方法，方法执行完毕，线程就会被销毁(点击几次button就启动几次子线程)
    [self performSelectorInBackground:@selector(thread1) withObject:nil];
    
    NSLog(@"单例地址1 = %p",[ViewController shareInstance]);
}

- (IBAction)createThread2:(UIButton *)sender {
    
    //2.通过NSThread类方法来启动线程
    [NSThread detachNewThreadSelector:@selector(thread2) toTarget:self withObject:nil];
    
    NSLog(@"单例地址2 = %p",[ViewController shareInstance]);
}

- (IBAction)createThread3:(UIButton *)sender {
    
    //3.生成一个线程对象
    NSThread *thread3 = [[NSThread alloc] initWithTarget:self selector:@selector(thread3) object:nil];
    
    //设置线程name
    thread3.name = @"thread3";
    
    //启动线程
    [thread3 start];
}

- (IBAction)createThread4:(UIButton *)sender {
    
    _thread4 = [[NSThread alloc] initWithTarget:self selector:@selector(thread4) object:nil];
    
    [_thread4 start];
    
    //将thread4中的代码放到主线程中执行
//    [_thread4 main];
}

- (IBAction)createThread5:(UIButton *)sender {
    
    _thread5 = [[NSThread alloc] initWithTarget:self selector:@selector(thread5) object:nil];
    
    [_thread5 start];
}

- (IBAction)createThread6:(UIButton *)sender {
    
    [self performSelectorInBackground:@selector(thread6) withObject:nil];
}

- (IBAction)createThread7:(UIButton *)sender {
    
    [self performSelectorInBackground:@selector(thread7) withObject:nil];
}

- (IBAction)createThread8:(UIButton *)sender {
    
    [self performSelectorInBackground:@selector(thread8) withObject:nil];
}

-(void)thread1{
    
    //线程启动
    
    //创建一个不会结束的线程
    /*
     while (1) {
        
         //子线程可以做死循环，不会影响主线程
         NSLog(@"hello");
         
         [NSThread sleepForTimeInterval:1.0];
    }
    */
    
    for (int i = 0; i < 10; i++) {
        
        NSLog(@"thread1:i = %d",i);
        
        [NSThread sleepForTimeInterval:1.0];
    }
    
    //获取当前线程，主线程当中获取的就是主线程，子线程当中获取的就是子线程
    NSThread *thread1 = [NSThread currentThread];
    
    NSLog(@"thread1 = %@",thread1);
    
    //线程结束
}

-(void)thread2{

    for (int i = 0; i < 10; i++) {
        
        NSLog(@"thread2:i = %d",i);
        
        [NSThread sleepForTimeInterval:1.0];
    }
}

-(void)thread3{

    for (int i = 0; i < 10; i++) {
        
        NSLog(@"thread3:i = %d",i);
        
        [NSThread sleepForTimeInterval:1.0];
    }
    
    NSLog(@"thread3线程名 = %@",[NSThread currentThread].name);
}

//通知中心的参数只有NSNotification
-(void)threadExit:(NSNotification *)noti{

    NSThread *thread = noti.object;
    
    NSLog(@"线程退出：thread = %@",thread);
}

-(void)thread4{

    for (int i = 0; i < 10; i++) {
        
        NSLog(@"thread4:i = %d",i);
        
        [NSThread sleepForTimeInterval:1.0];
        
        if (i == 5) {
            
            //向另一个线程发送cancel消息，_thread5处不处理这个cancel消息由他自己决定
            [_thread5 cancel];
        }
    }
}

-(void)thread5{

    int j = 0;
    while (true) {
        j++;
        NSLog(@"j = %d",j);
        [NSThread sleepForTimeInterval:1.0];
        
        //检测是否收到cancel消息
        if ([[NSThread currentThread] isCancelled]) {
            
            //让当前线程结束
            [NSThread exit];
        }
    }
}

-(void)thread6{

    while (1) {
        
        //将_sum变量锁起来，其他线程不能访问，必须等解锁之后，其他线程才能访问
        [_lock lock];
        _sum++;
        [_lock unlock];
        
        [NSThread sleepForTimeInterval:1.0];
        NSLog(@"thread6:sum = %d",_sum);
    }
}

-(void)thread7{

    while (1) {
        [_lock lock];
        _sum--;
        [_lock unlock];
        
        [NSThread sleepForTimeInterval:2.0];
        NSLog(@"thread7:sum = %d",_sum);
    }
}

//单例加锁写法
+(instancetype)shareInstance{

    //static 静态，这片内存空间不会被释放
    static ViewController *vc = nil;
    
    @synchronized(self){
    
        if (vc == nil) {
            
            vc = [[ViewController alloc] init];
        }
    }
    return vc;
}

-(void)thread8{
    
    //子线程最大的特点，不能操作UI
    for (int i = 1; i <= 10; i++) {
        
//        [self.progressView setProgress:i * 0.1 animated:YES];
        
        //将刷新UI的操作放到主线程里面去(waitUntilDone 子线程是否等主线程结束)
        [self performSelectorOnMainThread:@selector(changeProgress:) withObject:@(i) waitUntilDone:NO];
        
        NSLog(@"进度 = %f",self.progressView.progress);
        
        [NSThread sleepForTimeInterval:1.0];
    }
}

-(void)changeProgress:(NSNumber *)number{

    //主线程中刷新UI
    [self.progressView setProgress:number.floatValue * 0.1 animated:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

//
//  PlayViewController.m
//  ShortMovie
//
//  Created by MS on 16-6-1.
//  Copyright (c) 2016年 MS. All rights reserved.
//

#import "PlayViewController.h"
#import <AVFoundation/AVFoundation.h>

@interface PlayViewController ()

@property(nonatomic,copy)AVPlayer *player;

@property(nonatomic,copy)AVPlayerLayer *layer;

@property(nonatomic,strong)UISlider *slider;

@end

@implementation PlayViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view.
    self.view.backgroundColor = [UIColor darkGrayColor];
    
    
    [self createPlayer];
    
    [self  createControlBtn];
    
    
    __weak typeof (self)weakSelf = self;
    //self 在block内部使用时,用weakSelf替换
    
    [self.player addPeriodicTimeObserverForInterval:CMTimeMake(30, 30) queue:dispatch_get_main_queue() usingBlock:^(CMTime time) {
        //在block内部可以计算处player播放总时间,和当前播放的时间,,两个时间按的比值 可以作为进度条 的value
        //获取当前时间  秒
        float currentTime = weakSelf.player.currentItem.currentTime.value *1.0 /weakSelf.player.currentTime.timescale ;
        
        //总时间
        float totalTime = weakSelf.player.currentItem.duration.value *1.0/         weakSelf.player.currentItem.duration.timescale ;
        
        weakSelf.slider.value = currentTime/totalTime;
        
        
        
    }];
    //该方法可以用于循环监测播放的时间的进度
    //参数1 CMTimeMake  (30,30)  第一个30 播放到第30帧的时候,开始循环触发,第二个30表示没播放30帧触发一次
    //参数2 将当前任务放到主队列中管理,固定写法
    
    //参数3  每次触发回调的block ,
    
    
    
    
}

//创建播放器
- (void)createPlayer{
    
    NSURL *url = [NSURL URLWithString:self.movieURL];
    
    AVURLAsset *asset = [AVURLAsset URLAssetWithURL:url options:nil];
    
    AVPlayerItem *item = [AVPlayerItem playerItemWithAsset:asset];
    
    _player = [[AVPlayer alloc]initWithPlayerItem:item];
    
    //定制播放播放界面的效果
    _layer = [AVPlayerLayer playerLayerWithPlayer:_player];
    
    _layer.frame = CGRectMake(0, 164, SCREEN_WIDTH , 300);
    _layer.backgroundColor = [UIColor darkGrayColor].CGColor;
    //将超出边界的部分剪掉
    _layer.masksToBounds = YES;
    
    //5.适配:播放界面按照哪一种填充效果展示
    _layer.videoGravity = AVLayerVideoGravityResizeAspect;

    //AVLayerVideoGravityResizeAspect  表示播放的渲染层 根据视图的大小 按比例压缩,不容易产生形变  默认值
    //AVLayerVideoGravityResizeAspectFill  完全填充,会产生形变   ,,填充的半边街没有黑色边界线
    //AVLayerVideoGravityResize 填充

    
    [self.view.layer addSublayer:_layer];
    
    [_player play];

}

#pragma mark -- 创建控制button
- (void)createControlBtn{
    UIButton *playBtn = [[UIButton alloc]initWithFrame:CGRectMake(0, CGRectGetMaxY(_layer.frame)-40, 40, 40)];
    playBtn.alpha = 0.6;
    [playBtn setBackgroundImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];

    [playBtn addTarget:self action:@selector(playBtnClicked:) forControlEvents:UIControlEventTouchUpInside];
    
    [self.view addSubview:playBtn];
    
#pragma mark --slider 进度条
    _slider = [[UISlider alloc]initWithFrame:CGRectMake(CGRectGetMaxX(playBtn.frame)+10, CGRectGetMinY(playBtn.frame), SCREEN_WIDTH - 90, 40)];
    
    [_slider setThumbImage:[UIImage imageNamed:@"cannonball"] forState:UIControlStateNormal];
    
    [_slider addTarget:self action:@selector(valueChanged:) forControlEvents:UIControlEventValueChanged];
    
    [self.view addSubview:_slider];
    
    
    
    
}
//点击播放
- (void)playBtnClicked:(UIButton *)btn{
    
    btn.selected = !btn.selected;
    
    if (btn.selected) {
        [_player pause];
    [btn setBackgroundImage:[UIImage imageNamed:@"播放"] forState:UIControlStateNormal];

        
    }else{
        

    [_player play];
    [btn setBackgroundImage:[UIImage imageNamed:@"暂停"] forState:UIControlStateNormal];

    }
}

//活动slider
- (void)valueChanged:(UISlider *)slider{
    
    NSLog(@"gaibimn");
    
    
    
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

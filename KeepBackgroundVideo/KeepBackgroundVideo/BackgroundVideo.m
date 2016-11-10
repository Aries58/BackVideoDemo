//
//  BackgroundVideo.m
//  KeepBackgroundVideo
//
//  Created by 王亮 on 2016/11/10.
//  Copyright © 2016年 wangliang. All rights reserved.
//

#import "BackgroundVideo.h"

@implementation BackgroundVideo

static bool isUsed = false;

-(instancetype)initViewController:(UIViewController *)viewController videoUrl:(NSString *)url
{
    self=[super init];
    
    if (self) {
        
        _viewController=viewController;
        
        //分割字符串name和扩展名
        NSArray *array=[url componentsSeparatedByString:@"."];
        
        if (array.count == 2) {
            
            __weak NSString *name=array[0];
            __weak NSString *extens=array[1];
            
            if ([[NSBundle mainBundle] URLForResource:name withExtension:extens] ) {
                
                _videoUrl=[[NSBundle mainBundle] URLForResource:name withExtension:extens];
                _bgPlayer=[AVPlayer playerWithURL:_videoUrl];
            }else
            {
                NSLog(@"视频地址无效");
            }
        }
        
    }
    
    return self;
    
}

-(void)dealloc
{
    //使用完后或进入后台就移除
    if (isUsed) {
        
        [[NSNotificationCenter defaultCenter] removeObserver:self name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationWillEnterForegroundNotification object:nil];
        [[NSNotificationCenter defaultCenter] removeObserver:self name:UIApplicationDidEnterBackgroundNotification object:nil];
    }
}

-(void)setupBackground
{
    //添加bgPlayer到播放器图层
    AVPlayerLayer *playerL=[AVPlayerLayer playerLayerWithPlayer:_bgPlayer];
    
    playerL.videoGravity=AVLayerVideoGravityResizeAspectFill;
    //值越高view的层级就越高
    playerL.zPosition=-1;
    playerL.frame=_viewController.view.frame;
    
    [_viewController.view.layer addSublayer:playerL];
    
    //视频播放时 消除外界干扰
    @try {
        
        [[AVAudioSession sharedInstance] setCategory:AVAudioSessionCategoryAmbient error:nil];
    }
    @catch(NSException *exception) {
        
        NSLog(@"%@",exception.reason);
    }
    
    //开始播放
    [_bgPlayer play];
    
    //播放完毕 进入自定义状态
    self.bgPlayer.actionAtItemEnd=AVPlayerActionAtItemEndNone;
    self.bgPlayer.muted=YES;
    
    //播放完成，播放器的current item会发出通知
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(repeatPlay) name:AVPlayerItemDidPlayToEndTimeNotification object:nil];
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doPlay) name:UIApplicationWillEnterForegroundNotification object:nil];
  
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(doPause) name:UIApplicationDidEnterBackgroundNotification object:nil];
    
    isUsed=true;
}

-(void)repeatPlay{
    
    NSLog(@"重新播放---");
    //时间帧归零
    [_bgPlayer seekToTime:kCMTimeZero];
    
    [_bgPlayer play];
}

-(void)doPlay
{
    NSLog(@"进入界面---");
    [_bgPlayer play];
}

-(void)doPause
{
    NSLog(@"进入后台---");
    
    [_bgPlayer pause];
    
    
}

@end

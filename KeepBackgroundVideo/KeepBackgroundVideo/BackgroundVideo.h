//
//  BackgroundVideo.h
//  KeepBackgroundVideo
//
//  Created by 王亮 on 2016/11/10.
//  Copyright © 2016年 wangliang. All rights reserved.
//

#import <Foundation/Foundation.h>
#import <AVKit/AVKit.h>
#import <AVFoundation/AVFoundation.h>

@interface BackgroundVideo : NSObject

@property (nonatomic,copy) NSURL *videoUrl;

@property (nonatomic,strong) UIViewController *viewController;

@property (nonatomic,strong) AVPlayer *bgPlayer;

-(instancetype)initViewController:(UIViewController *)viewController videoUrl:(NSString *)url;

-(void)setupBackground;

@end

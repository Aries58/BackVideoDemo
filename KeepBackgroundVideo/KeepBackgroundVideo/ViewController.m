//
//  ViewController.m
//  KeepBackgroundVideo
//
//  Created by 王亮 on 2016/11/10.
//  Copyright © 2016年 wangliang. All rights reserved.
//

#import "ViewController.h"
#import "BackgroundVideo.h"

@interface ViewController ()

@property (nonatomic,strong) BackgroundVideo *backgroundVideo;

@end

@implementation ViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view, typically from a nib.
    
    
    
    _backgroundVideo=[[BackgroundVideo alloc] initViewController:self videoUrl:@"intro_video.mp4"];
    
    [_backgroundVideo setupBackground];
    
}
- (IBAction)signup:(UIButton *)sender {
    
    NSLog(@"signup---");

}

- (IBAction)signin:(UIButton *)sender {
    
    NSLog(@"signin---");
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

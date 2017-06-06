//
//  MainViewController.m
//  musicleague
//
//  Created by DaVinci Shen on 14-4-11.
//  Copyright (c) 2014年 cuuse. All rights reserved.
//

#import "MainViewController.h"
#import "DownloadUtils.h"

@interface MainViewController ()

@end

@implementation MainViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    //导航栏，标题文字颜色设置
    labCustomTitleColor = MS_RGB(255, 255, 255);
    
    //设置背景图片
    UIImageView *imgview = [[UIImageView alloc]initWithImage:[UIImage imageNamed:@"ActivityBG"]];
    imgview.frame = CGRectMake(0, 0, 320, 568);
    [self.view insertSubview:imgview atIndex:0];
    
    if ([MSUIUtils getIOSVersion] < 7.0){
        [self.navigationController.navigationBar setTintColor:MS_RGBA(60, 151, 42, 1.0)];
        if ([self.navigationController.navigationBar respondsToSelector:@selector(setBackgroundImage:forBarMetrics:)]){
            [self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
        }
    }else{
        [self.navigationController.navigationBar setBarStyle:UIBarStyleBlack];
        [self.navigationController.navigationBar setTranslucent:NO];
        //主题颜色
        [self.navigationController.navigationBar setTintColor:MS_RGB(249,249,249)];
        //背景颜色
        //[self.navigationController.navigationBar setBackgroundColor:MS_RGBA(50, 180, 200, 1.0)];
        [self.navigationController.navigationBar setBarTintColor:MS_RGBA(10,17,36, 1.0)];
        //背景图片
        //[self.navigationController.navigationBar setBackgroundImage:[UIImage imageNamed:@"navbar_bg.png"] forBarMetrics:UIBarMetricsDefault];
    }

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

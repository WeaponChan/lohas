//
//  MainTabViewController.m
//  musicleague
//
//  Created by DaVinci Shen on 14-4-10.
//  Copyright (c) 2014年 cuuse. All rights reserved.
//

#import "MainTabViewController.h"
#import "MSColorUtils.h"
#import "MSUIUtils.h"
#import "MSTintImage.h"

#import "NewTabMainViewController.h"
#import "NearViewController.h"
#import "DynamicViewController.h"
#import "DiscoverViewController.h"
#import "NewUserViewController.h"

@interface MainTabViewController (){
    int screenHeight;
    int screenWidth;
}


@end

@implementation MainTabViewController

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

    screenHeight=[[UIScreen mainScreen]bounds].size.height;
    screenWidth=[[UIScreen mainScreen]bounds].size.width;
    
    [self addViewCtrl:[[NewTabMainViewController alloc] initWithNibName:@"NewTabMainViewController" bundle:nil]];
    [self addViewCtrl:[[NearViewController alloc] initWithNibName:@"NearViewController" bundle:nil]];
    [self addViewCtrl:[[DynamicViewController alloc] initWithNibName:@"DynamicViewController" bundle:nil]];
    [self addViewCtrl:[[DiscoverViewController alloc] initWithNibName:@"DiscoverViewController" bundle:nil]];
    [self addViewCtrl:[[NewUserViewController alloc] initWithNibName:@"NewUserViewController" bundle:nil]];
    
    [self initTabItemViewCtrl];
    
    tabbarViewColorFor6 = MS_RGB(249, 249, 249);
    tabBar_btn_normal_TextIconColor = MS_RGB(121, 121, 121);
    tabBar_btn_selected_TextIconColor = MS_RGB(54, 146, 250);
    [tabbarViewFor6 setBackgroundColor:tabbarViewColorFor6];
    
    //添加按钮
    [self addTabItemTitle:@"首页" NormalIcon:@"lehuoicon_06.png" SeletedIcon:@"lehuoicon_01.png"];
    [self addTabItemTitle:@"附近" NormalIcon:@"lehuoicon_07.png" SeletedIcon:@"lehuoicon_02.png"];
    [self addTabItemTitle:@"动态" NormalIcon:@"lehuoicon_08.png" SeletedIcon:@"lehuoicon_03.png"];
    [self addTabItemTitle:@"发现" NormalIcon:@"lehuoicon_10.png" SeletedIcon:@"lehuoicon_05.png"];
    [self addTabItemTitle:@"我的" NormalIcon:@"lehuoicon_09.png" SeletedIcon:@"lehuoicon_04.png"];
    
    [self initTabBarBtn];
}

- (void) initTabItemViewCtrl
{
    self.viewControllers = viewCtrl_list;
}

- (void) addViewCtrl:(UIViewController*) viewCtrl{
    if (!viewCtrl_list) {
        viewCtrl_list = [[NSMutableArray alloc]init];
    }
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:viewCtrl];
    [navCtrl.tabBarItem setTag:viewCtrl_list.count];
    [viewCtrl_list addObject:navCtrl];
}

- (void)addTabItemTitle:(NSString*)title NormalIcon:(NSString*)nicon SeletedIcon:(NSString*)sicon{
    if (!tabBar_btn_titles) {
        tabBar_btn_titles = [[NSMutableArray alloc]init];
    }
    if (!tabBar_btn_normal_imgs) {
        tabBar_btn_normal_imgs = [[NSMutableArray alloc]init];
    }
    if (!tabBar_btn_selected_imgs) {
        tabBar_btn_selected_imgs = [[NSMutableArray alloc]init];
    }
    
    NSLog(@"title==%@",title);
    
    [tabBar_btn_titles addObject:title];
    [tabBar_btn_normal_imgs addObject:[UIImage imageNamed:nicon]];
    [tabBar_btn_selected_imgs addObject:[UIImage imageNamed:sicon]];
}

- (void)initTabBarBtn{
    
    if (!tabBar_btn_list) {
        tabBar_btn_list = [[NSMutableArray alloc]init];
    }
    if ([MSUIUtils getIOSVersion] < 7.0){
        //添加自定义背景
        tabbarViewFor6 = [[UIView alloc]initWithFrame:CGRectMake(0, 0, screenWidth, 49)];
        [tabbarViewFor6 setBackgroundColor:tabbarViewColorFor6];
        [self.tabBar addSubview:tabbarViewFor6];
    }else{
        //[self.tabBar setBarStyle:UIBarStyleBlack];
    }
    
    int count = tabBar_btn_titles.count;
    int width = screenWidth/count;
    int height = 49;
    
    for (int i=0; i<count; i++) {
        //创建tabBarBtn
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        [tabBar_btn_list addObject:btn];
        
        btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        btn.frame = CGRectMake(i*width, 0, width, height);
        btn.tag = i;
        if (tabbarViewFor6) {
            [tabbarViewFor6 addSubview:btn];
            NSLog(@"tabBar_BgView addSubview");
        }else{
            [self.tabBar addSubview:btn];
        }
        
        [btn addTarget:self action:@selector(actTabbarBtn:) forControlEvents:UIControlEventTouchUpInside];
        
        UILabel *labTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, height-14, width, 14)];
        [labTitle setTextAlignment:NSTextAlignmentCenter];
        [labTitle setFont:[UIFont systemFontOfSize:11]];
        [labTitle setText:[tabBar_btn_titles objectAtIndex:i]];
        
        [labTitle setTextColor:tabBar_btn_selected_TextIconColor];
        [labTitle setTag:888];
        
        [labTitle setBackgroundColor:[UIColor clearColor]];
        
        [btn addSubview:labTitle];
        
        int imgSize = 30;
        int imgMarginTop = 4;
        int padding = (width - imgSize)/2;
        
        //设置图标
        [btn setImageEdgeInsets:UIEdgeInsetsMake(imgMarginTop, padding, height-imgMarginTop-imgSize, padding)];
        if (i==0) {
            btn_selected = btn;
            [self setTabBarBtnSelected:btn];
        }else{
            [self setTabBarBtnNormal:btn];
        }
        
    }
}

- (void)actTabbarBtn:(id)sender
{
    NSLog(@"actTabbarBtn");
    if (btn_selected) {
        [self setTabBarBtnNormal:btn_selected];
    }
    
    btn_selected = (UIButton *)sender;
    int index = (int)btn_selected.tag;
    
    [self setTabBarBtnSelected:btn_selected];
    
    //切换View Controller
    [self setSelectedIndex:index];
    UINavigationController *navCtrl = [viewCtrl_list objectAtIndex:index];
    
    [navCtrl popToRootViewControllerAnimated:true];
}

- (void)setTabBarBtnNormal:(UIButton *)tabBar_btn{
    int index = (int)tabBar_btn.tag;
    
    [tabBar_btn setImage:[tabBar_btn_normal_imgs objectAtIndex:index] forState:UIControlStateNormal];
    [tabBar_btn setImage:[tabBar_btn_normal_imgs objectAtIndex:index] forState:UIControlStateHighlighted];
    
    UILabel *labTitle = (UILabel *)[tabBar_btn viewWithTag:888];
    
    if(labTitle){
        [labTitle setTextColor:tabBar_btn_normal_TextIconColor];
    }
    
}

- (void)setTabBarBtnSelected:(UIButton *)tabBar_btn{
    int index = (int)tabBar_btn.tag;
    
    [tabBar_btn setImage:[tabBar_btn_selected_imgs objectAtIndex:index] forState:UIControlStateNormal];
    [tabBar_btn setImage:[tabBar_btn_selected_imgs objectAtIndex:index] forState:UIControlStateHighlighted];
    
    UILabel *labTitle = (UILabel *)[tabBar_btn viewWithTag:888];
    
    if(labTitle){
        [labTitle setTextColor:tabBar_btn_selected_TextIconColor];
    }
    
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

//
//  MSTabBarController.m
//  musicleague
//
//  Created by DaVinci Shen on 14-4-10.
//  Copyright (c) 2014年 cuuse. All rights reserved.
//

#import "MSTabBarController.h"
#import "MSColorUtils.h"
#import "MSUIUtils.h"
#import "MSTintImage.h"

@interface MSTabBarController ()

@end

@implementation MSTabBarController

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
    //标题列表
    tabBar_btn_titles = [[NSMutableArray alloc]init];
    //正常图标
    tabBar_btn_normal_imgs = [[NSMutableArray alloc]init];
    //选中图标
    tabBar_btn_selected_imgs = [[NSMutableArray alloc]init];

    NSLog(@"viewDidLoad");
    //self.tabBar.delegate = self;
}

- (void)addTabItemTitle:(NSString*)title NormalIcon:(NSString*)nicon SeletedIcon:(NSString*)sicon{
    NSLog(@"addTabItemTitle");
    [tabBar_btn_titles addObject:title];
    [tabBar_btn_normal_imgs addObject:[[UIImage imageNamed:nicon]imageWithTintColor:tabBar_btn_normal_TextIconColor]];
    [tabBar_btn_selected_imgs addObject:[[UIImage imageNamed:sicon]imageWithTintColor:tabBar_btn_selected_TextIconColor]];
    NSLog(@"tabBar_btn_titles.count:%d",tabBar_btn_titles.count);
}

- (void)initTabBarBtn{
    tabBar_btn_list = [[NSMutableArray alloc]init];
    
    int count = tabBar_btn_titles.count;
    int width = 320/count;
    int height = 49;
    
    for (int i=0; i<count; i++) {
        //创建tabBarBtn
        
        UIButton *btn = [UIButton buttonWithType:UIButtonTypeCustom];
        btn.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
        btn.frame = CGRectMake(i*width, 0, width, height);
        btn.tag = i;
        if (tabBar_BgView) {
            [tabBar_BgView addSubview:btn];
            NSLog(@"tabBar_BgView addSubview");
        }else{
            [self.tabBar addSubview:btn];
        }
        
        [btn addTarget:self action:@selector(actTabbarBtn:) forControlEvents:UIControlEventTouchUpInside];
        [tabBar_btn_list addObject:btn];
        
        
        
        UILabel *labTitle = [[UILabel alloc]initWithFrame:CGRectMake(0, height-14, width, 14)];
        [labTitle setTextAlignment:NSTextAlignmentCenter];
        [labTitle setFont:[UIFont systemFontOfSize:10]];
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
}


- (void)selectTabbarOfIndex:(int)index{
    
    UIButton *btn = [tabBar_btn_list objectAtIndex:index];
    [self actTabbarBtn:btn];
    
}

- (void)setTabBarBtnNormal:(UIButton *)tabBar_btn{
    int index = (int)tabBar_btn.tag;

    [tabBar_btn setImage:[tabBar_btn_normal_imgs objectAtIndex:index] forState:UIControlStateNormal];
    [tabBar_btn setImage:[tabBar_btn_normal_imgs objectAtIndex:index] forState:UIControlStateHighlighted];
    
    UILabel *labTitle = (UILabel *)[tabBar_btn viewWithTag:888];
    
    if(labTitle){
        [labTitle setTextColor:tabBar_btn_normal_TextIconColor];
    }
   
    if (tabBar_btn_normal_BgColor) {
        [tabBar_btn setBackgroundColor:tabBar_btn_normal_BgColor];
        
    }else{
        if ([MSUIUtils getIOSVersion] < 7.0) {
            [tabBar_btn setBackgroundColor:tabBar_BgColor6];
        }
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
    
    if (tabBar_btn_selected_BgColor) {
        [tabBar_btn setBackgroundColor:tabBar_btn_selected_BgColor];
    }else{
        if ([MSUIUtils getIOSVersion] < 7.0) {
            NSLog(@"tabBar_btn setBackgroundColor");
            [tabBar_btn setBackgroundColor:tabBar_BgColor6];
        }
    }
}



- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


-(void)tabBar:(UITabBar *)tabBar didSelectItem:(UITabBarItem *)item{
    NSLog(@"%d",item.tag);
    [self selectTabbarOfIndex:item.tag];
}
/*
#pragma mark - Navigation

// In a storyboard-based application, you will often want to do a little preparation before navigation
- (void)prepareForSegue:(UIStoryboardSegue *)segue sender:(id)sender
{
    // Get the new view controller using [segue destinationViewController].
    // Pass the selected object to the new view controller.
}
*/

@end

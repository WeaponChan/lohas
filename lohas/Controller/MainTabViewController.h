//
//  MainTabViewController.h
//  musicleague
//
//  Created by DaVinci Shen on 14-4-10.
//  Copyright (c) 2014年 cuuse. All rights reserved.
//

@interface MainTabViewController : UITabBarController{
    NSMutableArray *viewCtrl_list;
    
    NSMutableArray *tabBar_btn_titles;
    NSMutableArray *tabBar_btn_normal_imgs;
    NSMutableArray *tabBar_btn_selected_imgs;
    
    NSMutableArray *tabBar_btn_list;
    UIButton *btn_selected;
    
    UIView *tabbarViewFor6;
    UIColor *tabbarViewColorFor6;
    
    UIColor *tabBar_btn_normal_TextIconColor;
    UIColor *tabBar_btn_selected_TextIconColor;
   }

@property (strong, nonatomic) id courseViewController;

- (void)selectTabbarOfIndex:(int)index;

@end

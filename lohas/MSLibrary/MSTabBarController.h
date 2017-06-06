//
//  MSTabBarController.h
//  musicleague
//
//  Created by DaVinci Shen on 14-4-10.
//  Copyright (c) 2014年 cuuse. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSTabBarController : UITabBarController{
    NSMutableArray *tabBar_btn_titles;
    
    UIColor *tabBar_BgColor6;
    UIColor *tabBar_BgColor7;
    
    UIColor *tabBar_btn_normal_TextIconColor;
    UIColor *tabBar_btn_selected_TextIconColor;
    
    UIColor *tabBar_btn_normal_BgColor;
    UIColor *tabBar_btn_selected_BgColor;
    
    NSMutableArray *tabBar_btn_normal_imgs;
    NSMutableArray *tabBar_btn_selected_imgs;
    
    NSMutableArray *tabBar_btn_list;
    UIButton *btn_selected;
    
    UIView * tabBar_BgView;//for 6.0
}
- (void)addTabItemTitle:(NSString*)title NormalIcon:(NSString*)nicon SeletedIcon:(NSString*)sicon;
- (void)initTabBarBtn;
- (void)selectTabbarOfIndex:(int)index;


@end

//
//  MSButton.h
//  diecai
//
//  Created by DaVinci Shen on 13-12-31.
//  Copyright (c) 2013年 xundianbao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define MSBUTTON_BG_ANIM_STYLE_GRAY 1
#define MSBUTTON_BG_ANIM_STYLE_ALPHA 2
#define MSBUTTON_BG_ANIM_STYLE_CUSTOM 3

@interface MSButton : UIButton{
    id actionTarget;
    SEL actionSelector;
    
    int animationStyle;
    UIColor *normalBgColor;
    UIColor *highlightBgColor;
    
    int cornerRadius;
}

//设置自定义圆角，默认为4
- (void)setCornerRadius:(int)r;

//设置自定义背景颜色
- (void)setCustomBgColor:(UIColor *)nColor highlight:(UIColor *)hColor;

//设置背景渐变动画
- (void)setBgAnimStyle:(int)style;

//添加按钮事件
- (void)addBtnAction:(SEL)action target:(id)target;

@end

//
//  MSButton.m
//  diecai
//
//  Created by DaVinci Shen on 13-12-31.
//  Copyright (c) 2013年 xundianbao. All rights reserved.
//

#import "MSButton.h"
#import "MSColorUtils.h"
#import "MSViewFrameUtil.h"

@implementation MSButton

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        
    }
    return self;
}

//设置自定义圆角
- (void)setCornerRadius:(int)r{
    cornerRadius = r;
}

//设置自定义背景颜色
- (void)setCustomBgColor:(UIColor *)nColor highlight:(UIColor *)hColor{
    normalBgColor = nColor;
    highlightBgColor = hColor;
    animationStyle = MSBUTTON_BG_ANIM_STYLE_CUSTOM;
    [self setBackgroundColor:normalBgColor];
}

//设置背景渐变动画
- (void)setBgAnimStyle:(int)style{
    animationStyle = style;
    switch (animationStyle) {
        case MSBUTTON_BG_ANIM_STYLE_GRAY:
            normalBgColor = self.backgroundColor;
            highlightBgColor = MS_RGB(230, 230, 230);
            break;
        case MSBUTTON_BG_ANIM_STYLE_ALPHA:
            normalBgColor = self.backgroundColor;
            highlightBgColor = [UIColor clearColor];
            break;
        default:
            break;
    }
}

//添加按钮事件
- (void)addBtnAction:(SEL)action target:(id)target{
    actionTarget = target;
    actionSelector = action;
    [self addTarget:self action:@selector(onTouchDownByViewBtnAction:) forControlEvents:UIControlEventTouchDown];
    [self addTarget:self action:@selector(onTouchUpOutsideByViewBtnAction:) forControlEvents:UIControlEventTouchUpOutside];
    [self addTarget:self action:@selector(onTouchUpOutsideByViewBtnAction:) forControlEvents:UIControlEventTouchCancel];
    [self addTarget:self action:@selector(onTouchUpInsideByViewBtnAction:) forControlEvents:UIControlEventTouchUpInside];
}

//绘制圆角
- (void)drawRect:(CGRect)rect
{
    [MSViewFrameUtil setCornerRadius:cornerRadius UI:self];
}

//按下按钮
- (void)onTouchDownByViewBtnAction:(id)sender{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    switch (animationStyle) {
        case MSBUTTON_BG_ANIM_STYLE_GRAY:
        case MSBUTTON_BG_ANIM_STYLE_CUSTOM:
            [self setBackgroundColor:highlightBgColor];
            break;
        case MSBUTTON_BG_ANIM_STYLE_ALPHA:
            [self setAlpha:0.5f];
            break;
        default:
            break;
    }
    
    [UIView commitAnimations];
}

//离开按钮
- (void)onTouchUpOutsideByViewBtnAction:(id)sender{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    switch (animationStyle) {
        case MSBUTTON_BG_ANIM_STYLE_GRAY:
        case MSBUTTON_BG_ANIM_STYLE_CUSTOM:
            [self setBackgroundColor:normalBgColor];
            break;
        case MSBUTTON_BG_ANIM_STYLE_ALPHA:
            [self setAlpha:1.0f];
            break;
        default:
            break;
    }
    [UIView commitAnimations];
}

//触发点击
- (void)onTouchUpInsideByViewBtnAction:(id)sender{
    
    [UIView beginAnimations:nil context:nil];
    switch (animationStyle) {
        case MSBUTTON_BG_ANIM_STYLE_GRAY:
        case MSBUTTON_BG_ANIM_STYLE_CUSTOM:
            [self setBackgroundColor:normalBgColor];
            break;
        case MSBUTTON_BG_ANIM_STYLE_ALPHA:
            [self setAlpha:1.0f];
            break;
        default:
            break;
    }
    [UIView commitAnimations];
    [actionTarget performSelector:actionSelector withObject:sender afterDelay:0];
}


@end

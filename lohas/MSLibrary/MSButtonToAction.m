//
//  MSButtonToAction.m
//  diecai
//
//  Created by DaVinci Shen on 13-12-31.
//  Copyright (c) 2013年 xundianbao. All rights reserved.
//

#import "MSButtonToAction.h"
#import "MSColorUtils.h"
#import "MSViewFrameUtil.h"

@implementation MSButtonToAction

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        animationStyle = BTN_ACT_ANIMATION_STYLE_2ALPHA;
    }
    return self;
}

- (void)setAnimationStyle:(int)style{
    animationStyle = style;
    switch (animationStyle) {
        case BTN_ACT_ANIMATION_STYLE_2GRAY:
            normalBgColor = self.backgroundColor;
            highlightBgColor = MS_RGB(230, 230, 230);
            break;
        case BTN_ACT_ANIMATION_STYLE_2ALPHA:
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

- (void)onTouchDownByViewBtnAction:(id)sender{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    switch (animationStyle) {
        case BTN_ACT_ANIMATION_STYLE_2GRAY:
            [self setBackgroundColor:highlightBgColor];
            break;
        case BTN_ACT_ANIMATION_STYLE_2ALPHA:
            [self setAlpha:0.5f];
            break;
        default:
            break;
    }
    
    [UIView commitAnimations];
}

- (void)onTouchUpOutsideByViewBtnAction:(id)sender{
    
    [UIView beginAnimations:nil context:nil];
    [UIView setAnimationDuration:0.2];
    switch (animationStyle) {
        case BTN_ACT_ANIMATION_STYLE_2GRAY:
            [self setBackgroundColor:normalBgColor];
            break;
        case BTN_ACT_ANIMATION_STYLE_2ALPHA:
            [self setAlpha:1.0f];
            break;
        default:
            break;
    }
    [UIView commitAnimations];
}

- (void)onTouchUpInsideByViewBtnAction:(id)sender{
    
    [UIView beginAnimations:nil context:nil];
    switch (animationStyle) {
        case BTN_ACT_ANIMATION_STYLE_2GRAY:
            [self setBackgroundColor:normalBgColor];
            break;
        case BTN_ACT_ANIMATION_STYLE_2ALPHA:
            [self setAlpha:1.0f];
            break;
        default:
            break;
    }
    [UIView commitAnimations];
    [actionTarget performSelector:actionSelector withObject:sender afterDelay:0];
}


@end

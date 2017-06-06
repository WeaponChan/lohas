//
//  MSButtonToAction.h
//  diecai
//
//  Created by DaVinci Shen on 13-12-31.
//  Copyright (c) 2013年 xundianbao. All rights reserved.
//

#import <UIKit/UIKit.h>

#define BTN_ACT_ANIMATION_STYLE_2GRAY 1
#define BTN_ACT_ANIMATION_STYLE_2ALPHA 2

@interface MSButtonToAction : UIButton{
    id actionTarget;
    SEL actionSelector;
    int animationStyle;
    UIColor *normalBgColor;
    UIColor *highlightBgColor;
}

//设置动画类型
- (void)setAnimationStyle:(int)style;

//添加按钮事件
- (void)addBtnAction:(SEL)action target:(id)target;

@end

//
//  MSShadowView.m
//  musicleague
//
//  Created by DaVinci Shen on 14-4-25.
//  Copyright (c) 2014年 cuuse. All rights reserved.
//

#import "MSShadowView.h"
#import "MSViewFrameUtil.h"
#import "MSColorUtils.h"

@implementation MSShadowView

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)drawRect:(CGRect)rect
{
    [MSViewFrameUtil setshadow:self Color:MS_RGBA(135, 135, 135, 0.5) Offset:CGSizeMake(0, 1) Opacity:0.5 Radius:1];
}

@end

//
//  GrayBorderView.m
//  union
//
//  Created by DaVinci Shen on 14-6-10.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "GrayBorderView.h"
#import "MSViewFrameUtil.h"
#import "MSColorUtils.h"

@implementation GrayBorderView

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
    [MSViewFrameUtil setBorder:1 Color:MS_RGB(220, 220, 220) UI:self];
}

@end

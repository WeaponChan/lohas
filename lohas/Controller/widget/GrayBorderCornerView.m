//
//  GrayBorderCornerView.m
//  sxsx
//
//  Created by DaVinci Shen on 14-8-6.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "GrayBorderCornerView.h"
#import "MSViewFrameUtil.h"
#import "MSColorUtils.h"

@implementation GrayBorderCornerView

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
    [MSViewFrameUtil setCornerRadius:4 UI:self];
    [MSViewFrameUtil setBorder:1 Color:MS_RGB(237, 237, 237) UI:self];
}

@end

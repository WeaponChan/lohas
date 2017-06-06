//
//  MSNavigationBar.m
//  msm
//
//  Created by xmload shen on 12-3-21.
//  Copyright (c) 2012年 __MyCompanyName__. All rights reserved.
//

#import "MSNavigationBar.h"
#include <objc/runtime.h>

@implementation UINavigationBar (MSNavigationBar)

- (void)drawRect:(CGRect)rect
{
    
    UIImage *image = [UIImage imageNamed:@"top_bg.png"];
    [image drawInRect:rect];
    
//    if (navigationBarBackgroundImage)
//        [navigationBarBackgroundImage.image drawInRect:rect];
//    else
//        [super drawRect:rect];
}
@end

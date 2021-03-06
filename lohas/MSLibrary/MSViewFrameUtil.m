//
//  MSViewFrameUtil.m
//  MeEngine
//
//  Created by xmload on 12-9-25.
//  Copyright (c) 2012年 xmload. All rights reserved.
//

#import "QuartzCore/QuartzCore.h"
#import "MSViewFrameUtil.h"

@implementation MSViewFrameUtil

+ (int)setTop:(int)top UI:(UIView *)view{
    CGRect frame = view.frame;
    frame.origin.y = top;
    view.frame = frame;
    return top+frame.size.height;
}

+ (int)setLeft:(int)left UI:(UIView *)view{
    CGRect frame = view.frame;
    frame.origin.x = left;
    view.frame = frame;
    return left+frame.size.width;
}

+ (int)setRight:(int)right UI:(UIView *)view{
    CGRect frame = view.frame;
    frame.origin.x = right-frame.size.width;
    view.frame = frame;
    return right-frame.size.width;
}

+ (int)setHeight:(int)height UI:(UIView *)view{
    CGRect frame = view.frame;
    frame.size.height = height;
    view.frame = frame;
    return height+frame.origin.y;
}

+ (int)setWidth:(int)width UI:(UIView *)view{
    CGRect frame = view.frame;
    frame.size.width = width;
    view.frame = frame;
    return width+frame.origin.x;
}

+ (int)getLabHeight:(NSString *)text FontSize:(int)size Width:(int)width{
    CGSize theSize = [text sizeWithFont:[UIFont systemFontOfSize:size] constrainedToSize:CGSizeMake(width, 999999.0f) lineBreakMode:UILineBreakModeWordWrap];
    return theSize.height;
}

+ (void)setCornerRadius:(int)width UI:(UIView *)view{
    CALayer *viewLayer = view.layer;
    viewLayer.masksToBounds = YES;
    viewLayer.cornerRadius = width;
}

+ (void)setBorder:(int)width Color:(UIColor *)color UI:(UIView *)view{
    CALayer *viewLayer = view.layer;
    viewLayer.borderWidth = width;
    viewLayer.borderColor = [color CGColor];
    
}

+ (CGPoint)getViewCenter:(UIView *)view{
    CGRect frame = view.frame;
    CGPoint center = CGPointMake(frame.size.width/2, frame.size.height/2);
    return center;
}

+ (void)setshadow:(UIView *)view Color:(UIColor *)color Offset:(CGSize)offset Opacity:(float)opacity Radius:(float)radius{
    
    view.layer.shadowColor = [color CGColor];
    view.layer.shadowOffset = offset;
    view.layer.shadowOpacity = opacity;
    view.layer.shadowRadius = radius;
}
@end

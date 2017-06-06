//
//  MSViewFrameUtil.h
//  MeEngine
//
//  Created by xmload on 12-9-25.
//  Copyright (c) 2012年 xmload. All rights reserved.
//

#import <UIKit/UIKit.h>

@interface MSViewFrameUtil : NSObject
+ (int)setTop:(int)top UI:(UIView *)view;
+ (int)setLeft:(int)left UI:(UIView *)view;
+ (int)setRight:(int)right UI:(UIView *)view;
+ (int)setHeight:(int)height UI:(UIView *)view;
+ (int)setWidth:(int)width UI:(UIView *)view;
+ (int)getLabHeight:(NSString *)text FontSize:(int)size Width:(int)width;
+ (void)setCornerRadius:(int)width UI:(UIView *)view;
+ (void)setBorder:(int)width Color:(UIColor *)color UI:(UIView *)view;
+ (CGPoint)getViewCenter:(UIView *)view;
+ (void)setshadow:(UIView *)view Color:(UIColor *)color Offset:(CGSize)offset Opacity:(float)opacity Radius:(float)radius;
@end

//
//  MSColorUtils.h
//  lvling
//
//  Created by shen xmload on 13-11-2.
//  Copyright (c) 2013年 juyuanqicheng. All rights reserved.
//

#import <Foundation/Foundation.h>

// Color helpers

#define MS_RGB(r,g,b) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f alpha:1]
#define MS_RGBA(r,g,b,a) [UIColor colorWithRed:(r)/255.0f green:(g)/255.0f blue:(b)/255.0f \
alpha:(a)]

#define MS_HSV(h,s,v) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:1]
#define MS_HSVA(h,s,v,a) [UIColor colorWithHue:(h) saturation:(s) value:(v) alpha:(a)]

@interface MSColorUtils:NSObject
+(CGColorRef) getColorFromRed:(int)red Green:(int)green Blue:(int)blue Alpha:(int)alpha;
@end

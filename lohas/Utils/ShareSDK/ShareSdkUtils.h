//
//  ShareSdkUtils.h
//  chuanmei
//
//  Created by mudboy on 14-9-11.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import <Foundation/Foundation.h>
#import "MSViewController.h"

#define SHARE_GOODS 1
#define SHARE_EVENT 2
#define SHARE_COUPON 3
#define SHARE_ENROLL 4
#define SHARE_SITE 5
#define SHARE_LOTTERY 6

@interface ShareSdkUtils : NSObject

+(NSString*) getShareUrl:(int)type itemid:(NSNumber*)itemid;
+(void) share:(NSString*)title url:(NSString*)url content:(NSString*)content image:(NSString*)image delegate:(id)delegate parentView:(MSViewController*)parentView shareImage:(UIImage*)shareImage textStr:(NSString*)textStr;

@property(copy,nonatomic)NSString *textStr;

@end

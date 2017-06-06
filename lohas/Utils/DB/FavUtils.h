//
//  FavUtils.h
//  sinov4ipad
//
//  Created by mudboy on 12-12-17.
//  Copyright (c) 2012年 sinovision. All rights reserved.
//  我的收藏课程

#import <Foundation/Foundation.h>

@interface FavUtils : NSObject

+(BOOL) isFav:(NSString*)key;
+(BOOL) setFav:(NSString*)key content:(NSString*)content;
+(BOOL) delFav:(NSString*)key;
+(BOOL) clearFav;
+(NSArray*) getFav:(int)limit offset:(int)offset;

@end

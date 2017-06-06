//
//  HistoryUtils.h
//  sinov4ipad
//
//  Created by mudboy on 12-12-17.
//  Copyright (c) 2012年 sinovision. All rights reserved.
//  浏览历史

#import <Foundation/Foundation.h>

@interface HistoryUtils : NSObject

+(BOOL) isHistory:(NSString*)key;
+(BOOL) setHistory:(NSString*)key content:(NSString*)content;
+(BOOL) delHistory:(NSString*)key;
+(BOOL) clearHistory;
+(NSArray*) getHistory:(int)limit offset:(int)offset;

@end

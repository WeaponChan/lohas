//
//  FavUtils.h
//  sinov4ipad
//
//  Created by mudboy on 12-12-17.
//  Copyright (c) 2012年 sinovision. All rights reserved.
//  下载的文件

#import <Foundation/Foundation.h>

@interface DownloadUtils : NSObject


+(NSString*) getDownloadPath:(NSString*)filename;
+(NSDictionary*) getDownloadedFile:(NSString*)key;
+(NSString*)getTempVideoFile:(BOOL)isOverwrite;

+(int) isDownloaded:(NSString*)key;

//+(NSArray*) getItems:(int)limit offset:(int)offset;
+(BOOL) setItem:(NSString*)key url:(NSString*)url filename:(NSString*)filename title:(NSString*)title packageid:(NSString*)packageid password:(NSString*)password;
+(BOOL) setProgress:(NSString*)url progress:(int)progress;
+(NSArray*) delDownloads:(NSString*)packageid;
+(void) delDownloadedFile:(NSString*)key;

@end

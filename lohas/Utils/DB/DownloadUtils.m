//
//  FavUtils.m
//  sinov4ipad
//
//  Created by mudboy on 12-12-17.
//  Copyright (c) 2012年 sinovision. All rights reserved.
//

#import "DownloadUtils.h"
#import "DBConnection.h"
#import "SBJson.h"
#import "SIDownloadManager.h"

@implementation DownloadUtils

+(NSString*) getDownloadPath:(NSString*)filename
{
    NSArray *docpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString *targetpath = [[docpaths objectAtIndex:0] stringByAppendingPathComponent:@"files"];
    
    if (![[NSFileManager defaultManager] fileExistsAtPath:targetpath])
	{
		NSError *err = nil;
		if (![[NSFileManager defaultManager] createDirectoryAtPath:targetpath
		                               withIntermediateDirectories:YES attributes:nil error:&err])
		{
            NSLog(@"error:create file");
            return nil;
		}
	}
    
    NSString* downloadPath = [targetpath stringByAppendingPathComponent:filename];
    return downloadPath;
}

+(NSString*)getTempVideoFile:(BOOL)isOverwrite
{
    NSArray *docpaths = NSSearchPathForDirectoriesInDomains(NSDocumentDirectory, NSUserDomainMask, YES);
    NSString* downloadPath = [[docpaths objectAtIndex:0] stringByAppendingPathComponent:@"temp.mp4"];
    
    
    if (isOverwrite && [[NSFileManager defaultManager] fileExistsAtPath:downloadPath])
	{
		NSError *error = nil;
		[[NSFileManager defaultManager] removeItemAtPath:downloadPath error:&error];
	}
    
    
    return downloadPath;
}

+(NSDictionary*) getDownloadedFile:(NSString*)key
{
    if(!key) {
        return nil;
    }
    
    NSMutableDictionary* result = [[NSMutableDictionary alloc] init];
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSString* sql = [NSString stringWithFormat:@"SELECT filename,password FROM download Where key='%@' limit 1", key];
    
    FMResultSet *fResult= [db executeQuery:sql];
    NSString* filename = nil;
    NSString* password = nil;
	if([fResult next])
	{
		filename = [fResult stringForColumn:@"filename"];
        password = [fResult stringForColumn:@"password"];
	}
    if(filename) {
        [result setObject:filename forKey:@"filename"];
        [result setObject:password forKey:@"passwd"];
        return result;
    }
    return nil;
}



+(int) isDownloaded:(NSString*)key
{
    //-1 不存在 0-100=正在下载 100=己下载完成
    
    if(!key) {
        return -1;
    }
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSString* sql = [NSString stringWithFormat:@"SELECT progress FROM download Where key='%@' limit 1", key];
    
    FMResultSet *fResult= [db executeQuery:sql];
    int progress = -1;
	if([fResult next])
	{
		progress = [fResult intForColumn:@"progress"];
	}
    
    //NSLog(@"progress:%d, sql:%@", progress, sql);
    return progress;
}

+(BOOL) setItem:(NSString*)key url:(NSString*)url filename:(NSString*)filename title:(NSString*)title packageid:(NSString*)packageid password:(NSString*)password
{
    if(!url || !key || !filename || !title) {
        return NO;
    }
    
    if(!password || [[NSNull null] isEqual:password]) {
        password = @"";
    }
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSTimeInterval ctime = [[NSDate date] timeIntervalSince1970];
    NSInteger time = round(ctime);
    NSDictionary *argsDict = [NSDictionary dictionaryWithObjectsAndKeys:key, @"key",  url, @"url",  filename, @"filename",  title, @"title", packageid, @"packageid", password, @"password", [NSNumber numberWithInt:time], @"createdAt", nil];
    NSLog(@"save:%@", argsDict);
    //NSLog(@"replace INTO download (key,url,filename, title, createdAt) VALUES (:key,:url,:filename,:title,:createdAt)");
    
    [db executeUpdate:@"replace INTO download (key,url,filename, title, packageid, password, createdAt) VALUES (:key,:url,:filename,:title,:packageid, :password, :createdAt)" withParameterDictionary:argsDict];
    
    return YES;
}

+(BOOL) setProgress:(NSString*)url progress:(int)progress
{
    //-1 error, -2 暂停
    if(!url || progress>100 || progress<-2) {
        return NO;
    }
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSString* sql = [NSString stringWithFormat:@"update download set progress=%d where url='%@'", progress, url];
    //NSLog(@"sql:%@", sql);
    [db executeUpdate:sql];
    
    return YES;
}

+(BOOL) delDownload:(NSString*)key
{
    if(!key) {
        return NO;
    }
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSString* sql = [NSString stringWithFormat:@"delete FROM download Where key='%@'", key];
    //NSLog(@"sql:%@", sql);
    [db executeUpdate:sql];
    
    return NO;
}

+(NSArray*) delDownloads:(NSString*)packageid
{
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    
    NSString* sql = [NSString stringWithFormat:@"SELECT * FROM download where packageid=%@", packageid];
    
    FMResultSet *fResult= [db executeQuery: sql];
    
    NSMutableArray* results = [[NSMutableArray alloc] init];
    
	while([fResult next])
	{
        
        NSString* key = [fResult stringForColumn:@"key"];
        NSString* url = [fResult stringForColumn:@"url"];
        NSString* filename = [fResult stringForColumn:@"filename"];
        
        SIDownloadManager* siDownloadManager = [SIDownloadManager sharedSIDownloadManager];
        [siDownloadManager cancelDownloadFileTaskInQueue:url];
        
        NSString* downloadPath = [DownloadUtils getDownloadPath:filename];
        //NSLog(@"file:%@", downloadPath);
        ///var/mobile/Applications/7D2EECEC-AD1D-4ABD-BF6F-186711991115/Documents/files/BE875F3047EE590A98FE0B411E47F77B.mp4
        if ([[NSFileManager defaultManager] fileExistsAtPath:downloadPath])
        {
            NSError *error = nil;
            [[NSFileManager defaultManager] removeItemAtPath:downloadPath error:&error];
            NSLog(@"del file error:%@", error);
        }
        
        [DownloadUtils delDownload:key];
        
		NSLog(@"filename=>%@ key=>%@ url=%@ file:%@", filename, key, url, downloadPath);
	}
    
    
    
    return results;
}


+(void) delDownloadedFile:(NSString*)key
{

    NSString* downloadPath = [DownloadUtils getDownloadedFile:key];
    NSLog(@"file:%@", downloadPath);
    if (downloadPath && [[NSFileManager defaultManager] fileExistsAtPath:downloadPath])
    {
        NSError *error = nil;
        [[NSFileManager defaultManager] removeItemAtPath:downloadPath error:&error];
        NSLog(@"del file error:%@", error);
    }
    
    [DownloadUtils delDownload:key];
    
}
@end

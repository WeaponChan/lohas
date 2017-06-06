//
//  HistoryUtils.m
//  sinov4ipad
//
//  Created by mudboy on 12-12-17.
//  Copyright (c) 2012年 sinovision. All rights reserved.
//

#import "HistoryUtils.h"
#import "DBConnection.h"
#import "SBJson.h"

@implementation HistoryUtils

+(BOOL) isHistory:(NSString*)key
{
    if(!key) {
        return NO;
    }
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSString* sql = [NSString stringWithFormat:@"SELECT content FROM history Where key='%@' limit 1", key];
    
    FMResultSet *fResult= [db executeQuery:sql];
    
	if([fResult next])
	{
		NSString* content = [fResult stringForColumn:@"content"];
        if(content && [content length]>0) {
            return YES;
        }
	}
    return NO;
}

+(BOOL) setHistory:(NSString*)key content:(NSString*)content
{
    if(!content || !key || [key isEqual:[NSNull null]] ) {
        return NO;
    }
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSTimeInterval ctime = [[NSDate date] timeIntervalSince1970];
    NSInteger time = round(ctime);
    NSDictionary *argsDict = [NSDictionary dictionaryWithObjectsAndKeys:key, @"key",  content, @"content", [NSNumber numberWithInt:time], @"createdAt", nil];
    NSLog(@"save:%@", argsDict);
    [db executeUpdate:@"replace INTO history (key,content, createdAt) VALUES (:key,:content,:createdAt)" withParameterDictionary:argsDict];
    
    return YES;
}

+(BOOL) delHistory:(NSString*)key
{
    if(!key) {
        return NO;
    }
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSString* sql = [NSString stringWithFormat:@"delete FROM history Where key='%@'", key];
    //NSLog(@"sql:%@", sql);
    [db executeUpdate:sql];

    return NO;
}

+(BOOL) clearHistory
{
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSString* sql = [NSString stringWithFormat:@"delete FROM history"];
    //NSLog(@"sql:%@", sql);
    [db executeUpdate:sql];
    
    return NO;
}

+(NSArray*) getHistory:(int)limit offset:(int)offset
{
    NSMutableDictionary* items = [[NSMutableDictionary alloc] init];
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    
    NSString* sql = [NSString stringWithFormat:@"SELECT * FROM history order by createdAt desc limit %d offset %d",  limit, offset];
    
    NSLog(@"sql=>%@ ", sql);
    
    FMResultSet *fResult= [db executeQuery: sql];
    
    NSMutableArray* results = [[NSMutableArray alloc] init];
    
	while([fResult next])
	{
        
        NSString* key = [fResult stringForColumn:@"key"];
        NSString* content = [fResult stringForColumn:@"content"];
        [results addObject:[content JSONValue]];
		NSLog(@"key=>%@ content=%@", key, content);
	}
    
    
    return results;
}

@end

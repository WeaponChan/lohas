//
//  FavUtils2.m
//  sinov4ipad
//
//  Created by mudboy on 12-12-17.
//  Copyright (c) 2012年 sinovision. All rights reserved.
//

#import "FavUtils2.h"
#import "DBConnection.h"
#import "SBJson.h"

@implementation FavUtils2

+(BOOL) isFav:(NSString*)key
{
    if(!key) {
        return NO;
    }
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSString* sql = [NSString stringWithFormat:@"SELECT content FROM fav2 Where key='%@' limit 1", key];
    
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

+(BOOL) setFav:(NSString*)key content:(NSString*)content
{
    if(!content || !key || [key isEqual:[NSNull null]]) {
        return NO;
    }
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSTimeInterval ctime = [[NSDate date] timeIntervalSince1970];
    NSInteger time = round(ctime);
    NSDictionary *argsDict = [NSDictionary dictionaryWithObjectsAndKeys:key, @"key",  content, @"content", [NSNumber numberWithInt:time], @"createdAt", nil];
    //NSLog(@"save:%@", argsDict);
    [db executeUpdate:@"replace INTO fav2 (key,content, createdAt) VALUES (:key,:content,:createdAt)" withParameterDictionary:argsDict];
    
    return YES;
}

+(BOOL) delFav:(NSString*)key
{
    if(!key) {
        return NO;
    }
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSString* sql = [NSString stringWithFormat:@"delete FROM fav2 Where key='%@'", key];
    //NSLog(@"sql:%@", sql);
    [db executeUpdate:sql];

    return NO;
}

+(BOOL) clearFav
{
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    NSString* sql = [NSString stringWithFormat:@"delete FROM fav2"];
    //NSLog(@"sql:%@", sql);
    [db executeUpdate:sql];
    
    return NO;
}

+(NSArray*) getFav:(int)limit offset:(int)offset
{
    NSMutableDictionary* items = [[NSMutableDictionary alloc] init];
    
    FMDatabase *db  = [DBConnection getSharedDatabase];
    
    NSString* sql = [NSString stringWithFormat:@"SELECT * FROM fav2 order by createdAt desc limit %d offset %d",  limit, offset];
    
    FMResultSet *fResult= [db executeQuery: sql];
    
    NSMutableArray* results = [[NSMutableArray alloc] init];
    
	while([fResult next])
	{
        
        NSString* key = [fResult stringForColumn:@"key"];
        NSString* content = [fResult stringForColumn:@"content"];
        [results addObject:[content JSONValue]];
		//NSLog(@"key=>%@ content=%@", key, content);
	}
    

    
    return results;
}

@end

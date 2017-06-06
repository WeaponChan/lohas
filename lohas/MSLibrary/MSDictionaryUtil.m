//
//  MSDictionaryUtil.m
//  MeEngine
//
//  Created by mudboy on 12-11-30.
//  Copyright (c) 2012年 xmload. All rights reserved.
//

#import "MSDictionaryUtil.h"

@implementation NSDictionary (Utility)

// in case of [NSNull null] values a nil is returned ...
- (id)objectForKeyNotNull:(id)key {
    id object = [self objectForKey:key];
    if (object == [NSNull null]) {
        return @"";
    }
    
    return object;
}


@end

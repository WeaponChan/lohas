//
//  UserFollowViewCell.m
//  lohas
//
//  Created by fred on 15-3-12.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "UserFollowViewCell.h"

@implementation UserFollowViewCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
  
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

@end

//
//  SearchPlaceTitleCell.m
//  lohas
//
//  Created by juyuan on 15-3-10.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "SearchPlaceTitleCell.h"

@implementation SearchPlaceTitleCell

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
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
}

+ (int)Height:(NSDictionary *)itemData{
    return 30;
}


@end

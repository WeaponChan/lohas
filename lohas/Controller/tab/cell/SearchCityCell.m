//
//  SearchCityCell.m
//  lohas
//
//  Created by juyuan on 15-3-10.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "SearchCityCell.h"

@implementation SearchCityCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
//    parent11=parentCtrl;
}

+ (int)Height:(NSDictionary *)itemData{
    return 60;
}


@end

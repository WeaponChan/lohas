//
//  searchTitleCell.m
//  lohas
//
//  Created by Juyuan123 on 15/5/13.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "searchTitleCell.h"

@implementation searchTitleCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
     [super update:itemData Parent:parentCtrl];
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
}

+ (int)Height:(NSDictionary *)itemData{
    return 30;
}

@end

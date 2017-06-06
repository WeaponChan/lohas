//
//  SearchHisCell.m
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "SearchHisCell.h"
#import "SearchViewController.h"

@implementation SearchHisCell{
    MSViewController *parent11;
}

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    parent11=parentCtrl;
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

- (IBAction)actSearch:(id)sender {
    
    SearchViewController *viewCtrl=(SearchViewController*)parent11;
    
    [viewCtrl actSearchHistory];    
    
}

@end

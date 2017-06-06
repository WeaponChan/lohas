//
//  SearchPlaceCell.m
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "SearchPlaceCell.h"
#import "FoodViewController.h"

@implementation SearchPlaceCell{
    MSViewController *parent11;
    int viewTag;
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
    return 60;
}

- (IBAction)actSearch:(id)sender {
    //viewTag 1:餐饮 2:酒店 3:景点 4:乡村游 5:购物
    
    FoodViewController *viewCtrl=[[FoodViewController alloc]initWithNibName:@"FoodViewController" bundle:nil];

    [parent11.navigationController pushViewController:viewCtrl animated:YES];

}

@end

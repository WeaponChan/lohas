//
//  FoodViewTitleCell.m
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodViewTitleCell.h"
#import "FoodGroupListViewController.h"

@implementation FoodViewTitleCell{
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
    [super update:itemData Parent:parentCtrl];
    self.btngroup.layer.cornerRadius=4.0;
    self.labDistance.layer.cornerRadius=4.0;
}

+ (int)Height:(NSDictionary *)itemData{
    return 292;
}

- (IBAction)actGroup:(id)sender {
    FoodGroupListViewController *viewCtrl=[[FoodGroupListViewController alloc]initWithNibName:@"FoodGroupListViewController" bundle:nil];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

@end

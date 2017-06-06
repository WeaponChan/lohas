//
//  RaidersListCell.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "RaidersListCell.h"
#import "RaidersReadListViewController.h"

@implementation RaidersListCell

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
    return 190;
}

- (IBAction)actRaiders:(id)sender {
    RaidersReadListViewController *viewCtrl=[[RaidersReadListViewController alloc]initWithNibName:@"RaidersReadListViewController" bundle:nil];
    [parent.navigationController pushViewController:viewCtrl animated:YES];

}

@end

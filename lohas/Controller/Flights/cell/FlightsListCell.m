//
//  FlightsListViewController.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FlightsListCell.h"
#import "FlightsBookingListViewController.h"

@implementation FlightsListCell

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
    return 80;
}

- (IBAction)actFlightOrder:(id)sender {
    FlightsBookingListViewController *viewCtrl=[[FlightsBookingListViewController alloc]initWithNibName:@"FlightsBookingListViewController" bundle:nil];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

@end
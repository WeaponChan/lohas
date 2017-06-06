//
//  WatchOtherTripViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "WatchOtherTripViewController.h"

@interface WatchOtherTripViewController ()

@end

@implementation WatchOtherTripViewController
@synthesize user_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"查看行程"];
    
    self.mOtherTripList.isOther=YES;
    self.mOtherTripList.user_id=user_id;
    [self.mOtherTripList initial:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

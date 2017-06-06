//
//  MyTripListViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/23.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MyTripListViewController.h"
#import "ShareSdkUtils.h"

@interface MyTripListViewController (){
    NSDictionary *item;
}

@end

@implementation MyTripListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"行程列表"];

    
    [self.mMyTripList initial:self];
}



-(void)viewWillAppear:(BOOL)animated{
    
    if ([AppDelegate sharedAppDelegate].isNeedrefshTrip) {
        [AppDelegate sharedAppDelegate].isNeedrefshTrip=NO;
        [self.mMyTripList refreshData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

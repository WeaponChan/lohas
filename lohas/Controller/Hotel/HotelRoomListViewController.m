//
//  HotelRoomListViewController.m
//  lohas
//
//  Created by Juyuan123 on 15/5/14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "HotelRoomListViewController.h"

@interface HotelRoomListViewController ()

@end

@implementation HotelRoomListViewController
@synthesize HotelID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"房型列表"];
    
    self.mHotelRoomList.hotelID=HotelID;
    [self.mHotelRoomList initial:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

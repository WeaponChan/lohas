//
//  MyTripViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/23.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MyTripViewController.h"

@interface MyTripViewController ()

@end

@implementation MyTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"我的行程"];
    
    [self.mMyTripList initial:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

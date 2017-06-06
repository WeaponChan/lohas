//
//  SceneryBookingListViewController.m
//  lohas
//
//  Created by juyuan on 15-3-12.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "SceneryBookingListViewController.h"

@interface SceneryBookingListViewController ()

@end

@implementation SceneryBookingListViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self.mSceneryBookingList initial:self];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

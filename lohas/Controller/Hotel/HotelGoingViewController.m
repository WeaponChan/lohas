//
//  HotelGoingViewController.m
//  lohas
//
//  Created by juyuan on 15-1-20.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "HotelGoingViewController.h"

@interface HotelGoingViewController ()

@end

@implementation HotelGoingViewController

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
    
    self.btnGoing.layer.cornerRadius=4;
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

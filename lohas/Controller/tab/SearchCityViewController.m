//
//  SearchCityViewController.m
//  lohas
//
//  Created by juyuan on 15-3-10.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "SearchCityViewController.h"

@interface SearchCityViewController ()

@end

@implementation SearchCityViewController

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
    // Do any additional setup after loading the view from its nib.
    [self setNavBarTitle:@"切换城市"];
    [self.mSearchCityList initial:self];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

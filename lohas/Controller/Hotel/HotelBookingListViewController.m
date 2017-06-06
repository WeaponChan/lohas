//
//  HotelBookingListViewController.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "HotelBookingListViewController.h"

@interface HotelBookingListViewController ()

@end

@implementation HotelBookingListViewController
@synthesize responseItem,ListItem;

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
    [self setNavBarTitle:@"酒店预订"];
    // Do any additional setup after loading the view from its nib.
    
    self.labTitle.text=[responseItem objectForKeyNotNull:@"title"];
    [self.imageHead loadImageAtURLString:[responseItem objectForKeyNotNull:@"picture"] placeholderImage:[UIImage imageNamed:@"default_bg80x80.png"]];
    NSString *distance=[ListItem objectForKeyNotNull:@"distance"];
    if (distance.doubleValue<0) {
        self.labDistance.hidden=YES;
    }else{
        self.labDistance.text=[NSString stringWithFormat:@"%.0f公里",distance.floatValue];
    }
    
    NSArray *plan=[responseItem objectForKeyNotNull:@"plan"];
    self.mHotelBookingList.plans=plan;
    self.mHotelBookingList.sdate=self.sdate;
    self.mHotelBookingList.edate=self.edate;
    self.mHotelBookingList.ListItem=ListItem;
    self.mHotelBookingList.headTitle=self.labTitle.text;
    [self.mHotelBookingList initial:self];
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

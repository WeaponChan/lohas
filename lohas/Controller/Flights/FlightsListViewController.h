//
//  FlightsListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "FlightsList.h"

@interface FlightsListViewController : MainViewController
@property (weak, nonatomic) IBOutlet FlightsList *mFlightsList;

@end

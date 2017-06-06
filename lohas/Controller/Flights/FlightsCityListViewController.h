//
//  FlightsCityListViewController.h
//  lohas
//
//  Created by fred on 15-3-10.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@protocol flightsCityDelegate <NSObject>

-(void)pickedCity:(NSString*)cityname code:(NSString*)code categoryStr:(NSString*)categoryStr flag:(NSString*)flag;

@end

@interface FlightsCityListViewController : MainViewController

@property (weak, nonatomic) IBOutlet UITableView *mCityList;
@property(copy,nonatomic)NSString *categoryStr;

@property(weak,nonatomic)id<flightsCityDelegate>delegate;

@end

//
//  FlightsSearchViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface FlightsSearchViewController : MainViewController

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnSearch;

- (IBAction)actStartCity:(id)sender;
- (IBAction)actEndCity:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labSCity;
@property (weak, nonatomic) IBOutlet UILabel *labEcity;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
- (IBAction)actExchange:(id)sender;
- (IBAction)actSelectSTime:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewNavbarTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnClickHead;
- (IBAction)actClickLeft:(id)sender;
- (IBAction)actClickRight:(id)sender;

@end

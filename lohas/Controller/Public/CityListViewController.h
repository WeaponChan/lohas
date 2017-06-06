//
//  CityListViewController.h
//  chuanmei
//
//  Created by juyuan on 14-8-15.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "CityList.h"
#import <CoreLocation/CoreLocation.h>
#import "MSButtonToAction.h"

@protocol cityPickerDelegate <NSObject>

-(void)getSelectCity:(NSString*)cityName cityID:(NSString*)cityID;

@end

@interface CityListViewController : MainViewController<CLLocationManagerDelegate>

@property (nonatomic) bool isRootView;

@property(weak,nonatomic)id<cityPickerDelegate>delegate;
@property(copy,nonatomic)NSString* categoryStr;

@property (weak, nonatomic) IBOutlet UILabel *labCity;

@property (weak, nonatomic) IBOutlet UITableView *mCityList;

- (IBAction)actClickCurrentCity:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labTag;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *labRadius;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property (weak, nonatomic) IBOutlet UIView *viewHotCity;
@property (weak, nonatomic) IBOutlet UILabel *labHotTitle;

@end

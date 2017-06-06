//
//  NewCityListViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/4/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"
#import "newCityList.h"
#import "NewCitySearchList.h"

@interface NewCityListViewController : MainViewController

@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *labRadius;
@property (weak, nonatomic) IBOutlet UILabel *labSubCurrentCity;
@property (weak, nonatomic) IBOutlet UILabel *labCurrentCity;
- (IBAction)actCurrentCity:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewHotCity;
@property (weak, nonatomic) IBOutlet UILabel *labHotTitle;
@property (weak, nonatomic) IBOutlet UIView *viewHead;

@property (weak, nonatomic) IBOutlet newCityList *mnewCityList;
-(void)selectProvince:(NSDictionary*)item;

@property (weak, nonatomic) IBOutlet UIView *view1;
@property (weak, nonatomic) IBOutlet UIView *view2;
- (IBAction)actIntergation:(id)sender;
- (IBAction)actOwnCountry:(id)sender;

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;
@property (weak, nonatomic) IBOutlet NewCitySearchList *mNewCitySearchList;

@end

//
//  FoodViewController.h
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "FoodViewList.h"
#import "CountryViewList.h"

@interface FoodViewController : MainViewController

- (IBAction)actPostPicture:(id)sender;
- (IBAction)actErrorCorrect:(id)sender;
- (IBAction)actComment:(id)sender;
- (IBAction)actShare:(id)sender;
- (IBAction)actPhotoShow:(id)sender;

@property (weak, nonatomic) IBOutlet FoodViewList *mFoodViewList;

@property (copy,nonatomic)NSString *countryID;
@property (copy,nonatomic)NSDictionary *HeadDic;

@property (weak, nonatomic) IBOutlet CountryViewList *mCountryViewList;

-(void)getMore:(BOOL)isHide;

@end

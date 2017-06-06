//
//  CountrySearchViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@protocol searchCountryDelegate <NSObject>

-(void)viewPop:(NSString*)title city_id:(NSString*)city_id type_id:(NSString*)type_id;

@end

@interface CountrySearchViewController : MainViewController

- (IBAction)actLocation:(id)sender;
- (IBAction)actTravelType:(id)sender;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnSearch;

@property BOOL isListBack;
@property(weak,nonatomic)id<searchCountryDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *labCity;
@property (weak, nonatomic) IBOutlet UITextField *labCountryName;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textType;

@property (weak, nonatomic) IBOutlet UILabel *labTag;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *labIndicator;

@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property(weak, nonatomic)  NSArray *backSelectBtn;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
@property (weak, nonatomic) IBOutlet UIView *viewTextSearch;

@end

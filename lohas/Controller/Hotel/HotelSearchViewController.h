//
//  HotelSearchViewController.h
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@protocol searchHotelDelete <NSObject>

-(void)viewPop:(NSString*)title stdate:(NSString*)stdate category_id:(NSString*)category_id cityid:(NSString*)cityid edate:(NSString*)edate;

@end

@interface HotelSearchViewController : MainViewController

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnSearch;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)actLocation:(id)sender;
- (IBAction)actDate:(id)sender;
- (IBAction)actType:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textType;
@property (weak, nonatomic) IBOutlet UITextField *textName;

@property (weak, nonatomic) IBOutlet UILabel *labCityName;
@property (weak, nonatomic) IBOutlet UILabel *labTag;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *labIndicator;

@property (weak, nonatomic) IBOutlet UILabel *labSDate;
@property (weak, nonatomic) IBOutlet UILabel *labSWeek;
@property (weak, nonatomic) IBOutlet UILabel *labEDate;
@property (weak, nonatomic) IBOutlet UILabel *labEWeek;
@property (weak, nonatomic) IBOutlet UILabel *labInteval;
- (IBAction)actSelectDate:(id)sender;
- (IBAction)actSelectEDate:(id)sender;

@property BOOL isListBack;

@property(weak,nonatomic)id<searchHotelDelete>delegate;

@end

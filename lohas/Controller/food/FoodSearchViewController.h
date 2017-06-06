//
//  FoodSearchViewController.h
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@protocol hotelSearchDelegate <NSObject>

-(void)viewPop:(NSString*)title city_id:(NSString*)city_id price:(int)price category_id:(NSString*)category_id;

@end

@interface FoodSearchViewController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)actChooseCity:(id)sender;
- (IBAction)actPrice:(id)sender;
- (IBAction)actStyleOfCooking:(id)sender;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnSearch;

@property BOOL isListBack;

@property(weak,nonatomic)id<hotelSearchDelegate>delegate;

@property (weak, nonatomic) IBOutlet UILabel *labCity;
@property (weak, nonatomic) IBOutlet UITextField *textFoodName;

@property (weak, nonatomic) IBOutlet UILabel *labTag;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *labIndicator;
@property (weak, nonatomic) IBOutlet UITextField *textPriceRange;

@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property(weak, nonatomic)  NSArray *backSelectBtn;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
@property (weak, nonatomic) IBOutlet UIView *viewTextSearch;

@property (weak, nonatomic) IBOutlet UIView *viewNavbarTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnClickHead;
- (IBAction)actClickLeft:(id)sender;
- (IBAction)actClickRight:(id)sender;





@end

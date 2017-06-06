//
//  ShopSearchViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@protocol searchShopDelegate <NSObject>

-(void)viewPop:(NSString*)title city_id1:(NSString*)city_id1 type_id1:(NSString*)type_id1 category_id:(NSString*)category_id;

@end

@interface ShopSearchViewController : MainViewController

- (IBAction)actLocation:(id)sender;
- (IBAction)actShopType:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labCity;
@property (weak, nonatomic) IBOutlet UITextField *textShopName;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnSearch;

@property BOOL isListBack;
@property(weak,nonatomic)id<searchShopDelegate>delegate;
@property (weak, nonatomic) IBOutlet UITextField *textType;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UILabel *labTag;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *labIndicator;

@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property(weak, nonatomic)  NSArray *backSelectBtn;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
@property (weak, nonatomic) IBOutlet UIView *viewTextSearch;

@end

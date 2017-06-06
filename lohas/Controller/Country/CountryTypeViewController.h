//
//  CountryTypeViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "CountryTypeList.h"

@protocol selectTypeDelegate <NSObject>

-(void)backWithSelectMenu:(NSArray*)btnList categoryID:(NSString*)categoryID title:(NSString*)titile;

@end

@interface CountryTypeViewController : MainViewController

@property (weak, nonatomic) IBOutlet CountryTypeList *mCountryTypeList;

@property(weak,nonatomic)id<selectTypeDelegate> delegate;
@property(copy,nonatomic)NSString *categoryStr;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIButton *btnOther;
@property(weak, nonatomic)  NSArray *backSelectBtn;
@property(copy,nonatomic)NSString *Stitle;
- (IBAction)actOther:(id)sender;

@end

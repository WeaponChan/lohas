//
//  ScenerySearchViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@protocol searchSceneryDelegate <NSObject>

-(void)viewPop:(NSString*)title city_id:(NSString*)city_id categoryID11:(NSString*)categoryID11;

@end

@interface ScenerySearchViewController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property BOOL isListBack;
@property(weak,nonatomic)id<searchSceneryDelegate>delegate;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnSearch;

@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property(weak, nonatomic)  NSArray *backSelectBtn;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;

@property (weak, nonatomic) IBOutlet UIView *viewNavbarTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnClickHead;
- (IBAction)actClickLeft:(id)sender;
- (IBAction)actClickRight:(id)sender;

@end

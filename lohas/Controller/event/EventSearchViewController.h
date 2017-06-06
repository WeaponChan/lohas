//
//  EventSearchViewController.h
//  lohas
//
//  Created by fred on 15-4-23.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@protocol eventBackDelegate <NSObject>

-(void)backEvent:(NSString*)categoryID title11:(NSString*)title11;

@end


@interface EventSearchViewController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UITextField *textType;

- (IBAction)actTravelType:(id)sender;

@property (weak,nonatomic)id<eventBackDelegate>delegate;

@property BOOL isListBack;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnSearch;

@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property(weak, nonatomic)  NSArray *backSelectBtn;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
@property (weak, nonatomic) IBOutlet UIView *viewTextSearch;

@end

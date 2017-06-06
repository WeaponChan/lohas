//
//  WapViewController.h
//  lohas
//
//  Created by fred on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface WapViewController : MainViewController

@property (weak, nonatomic) IBOutlet UIWebView *webView;

@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *linkStr;
@property(copy,nonatomic)NSString *categoryStr;
@property(copy,nonatomic)NSString *interNationFlag;
@property(copy,nonatomic)NSString *scode;
@property(copy,nonatomic)NSString *ecode;
@property(copy,nonatomic)NSString *scity;
@property(copy,nonatomic)NSString *ecity;
@property (weak, nonatomic) IBOutlet UIView *viewNavbarTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnClickHead;
- (IBAction)actClickLeft:(id)sender;
- (IBAction)actClickRight:(id)sender;

@property BOOL isFlight;

@end

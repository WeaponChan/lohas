//
//  WapTrainViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/18.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface WapTrainViewController : MainViewController
@property (weak, nonatomic) IBOutlet UIWebView *webView;
@property (weak, nonatomic) IBOutlet UIView *viewNavbarTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnClickHead;
- (IBAction)actClickLeft:(id)sender;
- (IBAction)actClickRight:(id)sender;


@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *linkStr;
@property(copy,nonatomic)NSString *categoryStr;
@property(copy,nonatomic)NSString *interNationFlag;
@property(copy,nonatomic)NSString *scode;
@property(copy,nonatomic)NSString *ecode;
@property(copy,nonatomic)NSString *scity;
@property(copy,nonatomic)NSString *ecity;

@property BOOL isFlight;
@end

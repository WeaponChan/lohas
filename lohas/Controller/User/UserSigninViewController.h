//
//  UserSigninViewController.h
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface UserSigninViewController : MainViewController

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
- (IBAction)actRegister:(id)sender;
- (IBAction)actForgetPWD:(id)sender;

@property (weak, nonatomic) IBOutlet UITextField *textPhone;
@property (weak, nonatomic) IBOutlet UITextField *textPassWord;

- (IBAction)actLogin:(id)sender;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnLogin;
@property (weak, nonatomic) IBOutlet UIView *viewLogin;
@property (weak, nonatomic) IBOutlet UIButton *btnQQ;
@property (weak, nonatomic) IBOutlet UIButton *btnSina;

@end

//
//  UserSignupViewController.h
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface UserSignupViewController : MainViewController{
    NSTimer *mTimer;
    int time;
}

@property (weak, nonatomic) IBOutlet UITextField *textNickName;
@property (weak, nonatomic) IBOutlet UITextField *textPhone;
@property (weak, nonatomic) IBOutlet UITextField *textRecommend;
@property (weak, nonatomic) IBOutlet UITextField *textCode;
@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UIButton *sexMan;
@property (weak, nonatomic) IBOutlet UIButton *sexWoman;
- (IBAction)actMan:(id)sender;
- (IBAction)actWoman:(id)sender;


- (IBAction)actRegister:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnAgreeMent;
- (IBAction)actAgreeMent:(id)sender;

- (IBAction)actReadAgreeMent:(id)sender;
- (IBAction)actCode:(id)sender;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnRegister;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnCode;
@property (weak, nonatomic) IBOutlet UILabel *labCode;

@end

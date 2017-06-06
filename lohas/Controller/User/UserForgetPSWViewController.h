//
//  UserForgetPSWViewController.h
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface UserForgetPSWViewController : MainViewController{
    NSTimer *mTimer;
    int time;
}

@property (weak, nonatomic) IBOutlet UITextField *textPhone;
@property (weak, nonatomic) IBOutlet UITextField *textCode;
@property (weak, nonatomic) IBOutlet UITextField *textNewPassword;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnSet;

- (IBAction)actResetPWD:(id)sender;
- (IBAction)actGetCode:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnCode;
@property (weak, nonatomic) IBOutlet UILabel *labCode;

@end

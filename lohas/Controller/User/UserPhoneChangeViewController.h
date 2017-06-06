//
//  UserPhoneChangeViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface UserPhoneChangeViewController : MainViewController{
    NSTimer *mTimer;
    int time;
}

@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UITextField *textPhone;
@property (weak, nonatomic) IBOutlet UITextField *textCode;

- (IBAction)actCommit:(id)sender;
- (IBAction)actGetCode:(id)sender;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnCommit;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnCode;
@property (weak, nonatomic) IBOutlet UILabel *labCode;

@end

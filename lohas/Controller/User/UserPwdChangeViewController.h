//
//  UserPwdChangeViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface UserPwdChangeViewController : MainViewController

@property (weak, nonatomic) IBOutlet UITextField *textPassword;
@property (weak, nonatomic) IBOutlet UITextField *textNewPassword;
@property (weak, nonatomic) IBOutlet UITextField *textEnsure;

- (IBAction)actCommit:(id)sender;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnCommit;

@end

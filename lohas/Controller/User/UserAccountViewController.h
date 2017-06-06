//
//  UserAccountViewController.h
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface UserAccountViewController : MainViewController

- (IBAction)actChangePhone:(id)sender;
- (IBAction)actChangeInfo:(id)sender;
- (IBAction)actChangePassword:(id)sender;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnOutLogin;
- (IBAction)actOutLogin:(id)sender;


@end

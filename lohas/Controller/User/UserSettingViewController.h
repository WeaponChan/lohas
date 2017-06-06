//
//  UserSettingViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/29.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface UserSettingViewController : MainViewController

- (IBAction)actSetting:(id)sender;
- (IBAction)actAttention:(id)sender;
- (IBAction)actBlack:(id)sender;
- (IBAction)actShare:(id)sender;
- (IBAction)actAbout:(id)sender;
- (IBAction)actClean:(id)sender;
- (IBAction)actOutResponse:(id)sender;
- (IBAction)actProblem:(id)sender;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)actSwitch:(id)sender;
@property (weak, nonatomic) IBOutlet UISwitch *tripSwitch;


@end

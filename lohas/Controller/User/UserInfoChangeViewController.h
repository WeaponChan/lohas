//
//  UserInfoChangeViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"
@interface UserInfoChangeViewController : MainViewController

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnCommit;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)actImage:(id)sender;
@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UITextField *textNickName;


@property (weak, nonatomic) IBOutlet UIButton *btnMan;
@property (weak, nonatomic) IBOutlet UIButton *btnWoman;
- (IBAction)actMan:(id)sender;
- (IBAction)actWoman:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textLocation;
@property (weak, nonatomic) IBOutlet UITextField *textSign;
@property (weak, nonatomic) IBOutlet UITextView *labIntro;
@property (weak, nonatomic) IBOutlet UILabel *labTag;

@end

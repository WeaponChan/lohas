//
//  UserMyViewController.h
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSShadowView.h"

@interface UserMyViewController : MainViewController
@property (strong, nonatomic) IBOutlet UIView *viewMy;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

- (IBAction)actSetting:(id)sender;
- (IBAction)actRecommend:(id)sender;
- (IBAction)actAttention:(id)sender;
- (IBAction)actShareSetting:(id)sender;
- (IBAction)actAboutLeHuo:(id)sender;
- (IBAction)actClean:(id)sender;
- (IBAction)actReponse:(id)sender;
- (IBAction)actHelp:(id)sender;

- (IBAction)actUserInfo:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labCity;

@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labUID;
@property (weak, nonatomic) IBOutlet MSShadowView *viewHead;

@property (weak, nonatomic) IBOutlet UIImageView *imageSex;

@end

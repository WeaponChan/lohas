//
//  UserAbountUSViewController.h
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface UserAbountUSViewController : MainViewController

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnCheck;
@property (weak, nonatomic) IBOutlet UILabel *labVersion;
@property (weak, nonatomic) IBOutlet UILabel *labAboutInfo;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;


@end

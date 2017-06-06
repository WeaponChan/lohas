//
//  UserRecommendBusinessViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface UserRecommendBusinessViewController : MainViewController

@property (weak, nonatomic) IBOutlet UITextField *textBusinessName;
@property (weak, nonatomic) IBOutlet UITextField *textBusinessPhone;

- (IBAction)actRecommend:(id)sender;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnCommit;

@end

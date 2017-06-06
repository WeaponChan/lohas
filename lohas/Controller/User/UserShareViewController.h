//
//  UserShareViewController.h
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface UserShareViewController : MainViewController
@property (weak, nonatomic) IBOutlet UIImageView *image1;
@property (weak, nonatomic) IBOutlet UIImageView *image2;
@property (weak, nonatomic) IBOutlet UIImageView *image3;

- (IBAction)actShare1:(id)sender;
- (IBAction)actShare2:(id)sender;
- (IBAction)actShare3:(id)sender;

@end

//
//  WXShareViewController.h
//  lohas
//
//  Created by Juyuan123 on 15/12/3.
//  Copyright © 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface WXShareViewController : MainViewController

@property(copy,nonatomic)NSString *textStr;

@property(copy,nonatomic)NSString *content;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *url;
@property(copy,nonatomic)NSString *image;
@property(copy,nonatomic)UIImage *shareImage;

@property (weak, nonatomic) IBOutlet UITextView *textView;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnShare;

@end

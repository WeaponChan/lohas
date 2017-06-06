//
//  PubishDynamicViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@interface PubishDynamicViewController : MainViewController<UITextViewDelegate>

- (IBAction)actSelectImage:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labTag;
@property (weak, nonatomic) IBOutlet UITextView *textContent;
@property (weak, nonatomic) IBOutlet UILabel *labNum;
@property (weak, nonatomic) IBOutlet UIImageView *imageHead;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnImage;
- (IBAction)actCurrentplace:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labAddress;


@end

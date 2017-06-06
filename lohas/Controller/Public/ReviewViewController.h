//
//  ReviewViewController.h
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"

@protocol reviewDelegate <NSObject>

-(void)reviewBack;

@end

@interface ReviewViewController : MainViewController

@property (weak, nonatomic) IBOutlet UIButton *btn1;
@property (weak, nonatomic) IBOutlet UIButton *btn2;
@property (weak, nonatomic) IBOutlet UIButton *btn3;
@property (weak, nonatomic) IBOutlet UIButton *btn4;
@property (weak, nonatomic) IBOutlet UIButton *btn5;

- (IBAction)actBtnStar:(id)sender;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnCommit;

@property int type;
@property(copy,nonatomic)NSNumber *subID;

@property (weak, nonatomic) IBOutlet UITextView *textContent;
@property (weak, nonatomic) IBOutlet UILabel *labTag;

@property(weak,nonatomic)id<reviewDelegate>delegate;

@property (weak, nonatomic) IBOutlet UIButton *btnGood1;
@property (weak, nonatomic) IBOutlet UIButton *btnGood2;
@property (weak, nonatomic) IBOutlet UIButton *btnGood3;
@property (weak, nonatomic) IBOutlet UIButton *btnGood4;
- (IBAction)actGood:(id)sender;

@end

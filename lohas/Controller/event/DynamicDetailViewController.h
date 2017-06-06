//
//  DynamicDetailViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/24.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"



@interface DynamicDetailViewController : MainViewController<UITextFieldDelegate>

@property(copy,nonatomic)NSString *dynamicID;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;

@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labInfo;
@property (weak, nonatomic) IBOutlet MSImageView *imageMain;
@property (weak, nonatomic) IBOutlet UILabel *labZanNum;
@property (weak, nonatomic) IBOutlet UILabel *labCommentNum;
@property (weak, nonatomic) IBOutlet UIButton *btnJubao;

@property (weak, nonatomic) IBOutlet UIButton *imageSmall;

@property (strong, nonatomic) IBOutlet UIView *viewSeeMore;
- (IBAction)actSeeMore:(id)sender;

- (IBAction)actWriteComment:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UITextField *textComment;
- (IBAction)actSendComment:(id)sender;
- (IBAction)beginEdit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;

- (IBAction)actClickHead:(id)sender;
- (IBAction)actJubao:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnZan;
- (IBAction)actZan:(id)sender;

- (IBAction)actShare:(id)sender;
- (IBAction)actZanpeo:(id)sender;
- (IBAction)actImage:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;

@property (weak, nonatomic) IBOutlet UIButton *btnImage;
- (IBAction)actClickComment:(id)sender;


@end

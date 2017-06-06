//
//  DynamicCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface DynamicCell : MSTableViewCell<UITextFieldDelegate>

@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labInfo;
@property (weak, nonatomic) IBOutlet MSImageView *imageMain;
@property (weak, nonatomic) IBOutlet UILabel *labZanNum;
@property (weak, nonatomic) IBOutlet UILabel *labCommentNum;
@property (weak, nonatomic) IBOutlet UIButton *imageSmall;
@property (weak, nonatomic) IBOutlet UIButton *btnJubao;

@property (weak, nonatomic) IBOutlet UIView *viewSub;

- (IBAction)actComment:(id)sender;
- (IBAction)actJubao:(id)sender;
- (IBAction)actZan:(id)sender;
- (IBAction)actZanpeo:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnZan;
- (IBAction)actShare:(id)sender;

- (IBAction)actClick:(id)sender;

- (IBAction)actClickHead:(id)sender;
- (IBAction)actClickComment:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnImage;
- (IBAction)actClickImage:(id)sender;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;

@end

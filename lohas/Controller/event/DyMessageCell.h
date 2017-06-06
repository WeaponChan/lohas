//
//  DyMessageCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/25.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface DyMessageCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labInfo;
@property (weak, nonatomic) IBOutlet MSImageView *imageDynamic;

@property (weak, nonatomic) IBOutlet UIButton *btnAttention;
- (IBAction)actAttention:(id)sender;

- (IBAction)actClick:(id)sender;

- (IBAction)actClickHead:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnDyDetail;
- (IBAction)actDyDetail:(id)sender;

@end

//
//  DynamicUserZanCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface DynamicUserZanCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labInfo;

@property (weak, nonatomic) IBOutlet UIButton *btnAttention;

- (IBAction)actAttention:(id)sender;
- (IBAction)actClickHead:(id)sender;


@property BOOL isFans;
@property BOOL isFocus;

@end

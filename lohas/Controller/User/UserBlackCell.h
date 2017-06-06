//
//  UserBlackCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/29.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface UserBlackCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
- (IBAction)actClick:(id)sender;

@end

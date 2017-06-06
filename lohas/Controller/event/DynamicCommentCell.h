//
//  DynamicCommentCell.h
//  lohas
//
//  Created by Juyuan123 on 16/2/26.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface DynamicCommentCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labName;
@property (weak, nonatomic) IBOutlet UILabel *labTime;
@property (weak, nonatomic) IBOutlet UILabel *labInfo;

@property (weak, nonatomic) IBOutlet UIView *viewMain;

- (IBAction)actClickHead:(id)sender;


@end

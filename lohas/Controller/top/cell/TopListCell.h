//
//  TopListCell.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "MSButtonToAction.h"

@interface TopListCell : MSTableViewCell
- (IBAction)actTop:(id)sender;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labsubTitle;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnClick;
@property (weak, nonatomic) IBOutlet UIView *viewInfo;

@end

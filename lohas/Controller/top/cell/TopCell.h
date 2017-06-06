//
//  TopCell.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface TopCell : MSTableViewCell
- (IBAction)actTop:(id)sender;

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labSubTitle;
@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labNum;

@property(copy,nonatomic)NSDictionary *headDic;

@end

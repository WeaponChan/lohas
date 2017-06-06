//
//  WrongCell.h
//  lohas
//
//  Created by fred on 15-4-15.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface WrongCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnSelect;
- (IBAction)actSelect:(id)sender;

@end

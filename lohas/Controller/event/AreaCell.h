//
//  AreaCell.h
//  lohas
//
//  Created by Juyuan123 on 16/3/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface AreaCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labName;
- (IBAction)actClick:(id)sender;

@end

//
//  OtherTripCell.h
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface OtherTripCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labName;
- (IBAction)actClick:(id)sender;

@property BOOL isOther;

@end

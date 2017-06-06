//
//  TripAddCell.h
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface TripAddCell : MSTableViewCell
- (IBAction)actAdd:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnAdd;

@end

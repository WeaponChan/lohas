//
//  CityStateCell.h
//  lohas
//
//  Created by Juyuan123 on 16/4/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface CityStateCell : MSTableViewCell
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

- (IBAction)actClick:(id)sender;

@end

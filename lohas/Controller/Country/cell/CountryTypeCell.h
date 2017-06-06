//
//  CountryTypeCell.h
//  lohas
//
//  Created by fred on 15-3-16.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "MSButtonToAction.h"

@interface CountryTypeCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnClick;

@end

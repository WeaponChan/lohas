//
//  HotelTypeCell.h
//  lohas
//
//  Created by fred on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "MSButtonToAction.h"

@interface HotelTypeCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *labTag;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnClick;

@end

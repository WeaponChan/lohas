//
//  FoodTypeChioceCell.h
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "MSButtonToAction.h"

@interface FoodTypeChioceCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *imageS;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnSelect;

@end

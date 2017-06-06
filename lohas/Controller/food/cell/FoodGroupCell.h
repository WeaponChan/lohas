//
//  FoodGroupCell.h
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "MSButtonToAction.h"

@interface FoodGroupCell : MSTableViewCell

+ (int)Height:(NSDictionary *)itemData;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnClick;

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UIImageView *labTag;

@end

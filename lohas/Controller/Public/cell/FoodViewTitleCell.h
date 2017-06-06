//
//  FoodViewTitleCell.h
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "MSButtonToAction.h"

@interface FoodViewTitleCell : MSTableViewCell

+ (int)Height:(NSDictionary *)itemData;
- (IBAction)actGroup:(id)sender;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btngroup;

@property (weak, nonatomic) IBOutlet UILabel *labDistance;
@end

//
//  CityCell.h
//  chuanmei
//
//  Created by juyuan on 14-8-15.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface CityCell : MSTableViewCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl;
+ (int)Height:(NSDictionary *)itemData;

@property (weak, nonatomic) IBOutlet UILabel *labCityName;
@property (weak, nonatomic) IBOutlet UIActivityIndicatorView *indicator;
@property (weak, nonatomic) IBOutlet UILabel *labTips;


@end



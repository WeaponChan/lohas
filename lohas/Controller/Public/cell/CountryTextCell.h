//
//  CountryTextCell.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface CountryTextCell : MSTableViewCell

@property(copy,nonatomic)NSDictionary *countryInfo;
@property (weak, nonatomic) IBOutlet UILabel *labDescribe;

@property (weak, nonatomic) IBOutlet UIButton *btnGetMore;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;
- (IBAction)actGetMore:(id)sender;

@property BOOL isHideMore;

+ (int)Height:(NSDictionary *)itemData isHide:(BOOL)isHide;

@end

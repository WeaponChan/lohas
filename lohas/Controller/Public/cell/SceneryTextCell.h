//
//  SceneryTextCell.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface SceneryTextCell : MSTableViewCell

@property(copy,nonatomic)NSDictionary *countryInfo;
@property (weak, nonatomic) IBOutlet UILabel *labDescribe;
@property (weak, nonatomic) IBOutlet UIView *viewText;

@property (weak, nonatomic) IBOutlet UIButton *btnGetMore;
- (IBAction)actGetMore:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;

@property BOOL isHideMore;

+ (int)Height:(NSDictionary *)itemData isHide:(BOOL)isHide;
@end

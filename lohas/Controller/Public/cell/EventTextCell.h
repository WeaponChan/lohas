//
//  EventTextCell.h
//  lohas
//
//  Created by juyuan on 15-5-9.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface EventTextCell : MSTableViewCell

@property(copy,nonatomic)NSDictionary *countryInfo;
@property (weak, nonatomic) IBOutlet UILabel *labDescribe;
@property (weak, nonatomic) IBOutlet UIView *viewMain;

@property (weak, nonatomic) IBOutlet UIButton *btnGetMore;
- (IBAction)actGetMore:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;

@property BOOL isHideMore;

+ (int)Height:(NSDictionary *)itemData isHide:(BOOL)isHide;

@end

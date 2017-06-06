//
//  FoodHotelCell.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface HotelTextCell : MSTableViewCell

+ (int)Height:(NSDictionary *)itemData;

@property (weak, nonatomic) IBOutlet UIView *viewText;
@property (weak, nonatomic) IBOutlet UILabel *labDes;

@property(copy,nonatomic)NSDictionary *responseItem;


@property (weak, nonatomic) IBOutlet UIButton *btnGetMore;
- (IBAction)actGetMore:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnMore;

@property BOOL isHideMore;
+ (int)Height:(NSDictionary *)itemData isHide:(BOOL)isHide;

@end

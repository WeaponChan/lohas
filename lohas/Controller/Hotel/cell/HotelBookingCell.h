//
//  HotelBookingCell.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"
#import "MSButtonToAction.h"

@interface HotelBookingCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet UILabel *labPrice;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labSubtitle;
@property (weak, nonatomic) IBOutlet UILabel *labTag;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnClick;

@property(copy,nonatomic)NSString *sdate;
@property(copy,nonatomic)NSString *edate;
@property(copy,nonatomic)NSDictionary *ListItem;
@property(copy,nonatomic)NSString *headTitle;

@end

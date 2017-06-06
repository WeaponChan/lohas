//
//  HotelListCell.h
//  lohas
//
//  Created by juyuan on 15-3-10.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSTableViewCell.h"

@interface HotelListCell : MSTableViewCell

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labSubTitle;
@property (weak, nonatomic) IBOutlet UILabel *labComment;
@property (weak, nonatomic) IBOutlet UILabel *labDistance;

@property (weak, nonatomic) IBOutlet UILabel *labf;
@property (weak, nonatomic) IBOutlet UILabel *labPeople;
@property (weak, nonatomic) IBOutlet UILabel *labPrice;

@property(copy,nonatomic)NSString *sdate;
@property(copy,nonatomic)NSString *edate;

@property (weak, nonatomic) IBOutlet UIImageView *imageStar1;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar2;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar3;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar4;
@property (weak, nonatomic) IBOutlet UIImageView *imageStar5;

@property BOOL isNeehideDistance;

@end

//
//  HotelBookingListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "HotelBookingList.h"

@interface HotelBookingListViewController : MainViewController

@property(copy,nonatomic)NSDictionary *responseItem;
@property(copy,nonatomic)NSDictionary *ListItem;
@property (weak, nonatomic) IBOutlet HotelBookingList *mHotelBookingList;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

@property (weak, nonatomic) IBOutlet UILabel *labDistance;

@property(copy,nonatomic)NSString *sdate;
@property(copy,nonatomic)NSString *edate;

@end

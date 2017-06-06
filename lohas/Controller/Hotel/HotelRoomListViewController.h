//
//  HotelRoomListViewController.h
//  lohas
//
//  Created by Juyuan123 on 15/5/14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "HotelRoomList.h"

@interface HotelRoomListViewController : MainViewController

@property(copy,nonatomic)NSString *HotelID;
@property (weak, nonatomic) IBOutlet HotelRoomList *mHotelRoomList;

@end

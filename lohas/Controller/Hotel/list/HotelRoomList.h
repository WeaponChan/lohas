//
//  HotelRoomList.h
//  lohas
//
//  Created by Juyuan123 on 15/5/14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface HotelRoomList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property(copy,nonatomic)NSString *hotelID;

@end

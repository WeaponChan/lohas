//
//  HotelBookingList.h
//  lohas
//
//  Created by juyuan on 14-12-9.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface HotelBookingList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
-(void) initial:(MSViewController*)parentViewController;

@property(copy,nonatomic)NSArray *plans;

@property(copy,nonatomic)NSString *sdate;
@property(copy,nonatomic)NSString *edate;
@property(copy,nonatomic)NSString *headTitle;
@property(copy,nonatomic)NSDictionary *ListItem;

@end

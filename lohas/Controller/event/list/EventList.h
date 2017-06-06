//
//  EventList.h
//  lohas
//
//  Created by juyuan on 15-2-14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface EventList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
-(void) initial:(MSViewController*)parentViewController;

@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *categoryId;
@property(copy,nonatomic)NSString *cityID;
@property int type;
@property int price_type;

//@property(copy,nonatomic)CLLocation *location;

@property float lat;
@property float lng;

@end

//
//  SceneryBookingList.h
//  lohas
//
//  Created by juyuan on 15-3-12.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface SceneryBookingList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
-(void) initial:(MSViewController*)parentViewController;

@end

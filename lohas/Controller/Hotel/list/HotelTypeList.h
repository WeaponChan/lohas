//
//  HotelTypeList.h
//  lohas
//
//  Created by fred on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface HotelTypeList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

-(void)initialInfo:(MSViewController*)parentCtrl list:(NSMutableArray*)list;
-(void)refreshInfo:(NSMutableArray*)list;

@end

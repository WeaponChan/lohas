//
//  AddTripList.h
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface AddTripList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property(retain,nonatomic)NSMutableArray *selectList;


@end

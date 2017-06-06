//
//  subDiscoverRankList.h
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface subDiscoverRankList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property(copy,nonatomic)NSString *rankID;
@property(copy,nonatomic)NSString *typeID;

@end

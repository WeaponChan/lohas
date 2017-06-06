//
//  DiscoverRankList.h
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface DiscoverRankList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property BOOL isCityIn;

@property(copy,nonatomic)NSString *interest_id;
@property(copy,nonatomic)NSString *category_id;

@end

//
//  UserFollowViewList.h
//  lohas
//
//  Created by fred on 15-3-12.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface UserFollowViewList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
@property(copy,nonatomic)NSString *type;
@property(copy,nonatomic)NSNumber *id11;
@end

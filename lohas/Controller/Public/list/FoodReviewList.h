//
//  FoodReviewList.h
//  lohas
//
//  Created by yons on 14-12-10.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface FoodReviewList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property int type;
@property (copy,nonatomic)NSString *seID;
@end

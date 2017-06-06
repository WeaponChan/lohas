//
//  AreaList.h
//  lohas
//
//  Created by Juyuan123 on 16/3/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface AreaList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property(copy,nonatomic)NSString *category_id;

@end

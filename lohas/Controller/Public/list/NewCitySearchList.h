//
//  NewCitySearchList.h
//  lohas
//
//  Created by Juyuan123 on 16/4/8.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface NewCitySearchList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property(copy,nonatomic)NSString *searchStr;

@end

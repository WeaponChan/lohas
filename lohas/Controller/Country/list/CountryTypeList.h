//
//  CountryTypeList.h
//  lohas
//
//  Created by fred on 15-3-16.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface CountryTypeList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property(copy,nonatomic)NSString *categoryStr;

@end

//
//  DynamicList.h
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface DynamicList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property(copy,nonatomic)NSString *keyword;

@end

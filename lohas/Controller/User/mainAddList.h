//
//  mainAddList.h
//  lohas
//
//  Created by Juyuan123 on 16/3/2.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface mainAddList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property BOOL isDelete;

@property(copy,nonatomic)NSMutableArray* selectList;
@property BOOL isEdit;

@end

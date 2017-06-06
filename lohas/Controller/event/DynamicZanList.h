//
//  DynamicZanList.h
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface DynamicZanList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property BOOL isFans;
@property BOOL isFocus;
@property(copy,nonatomic)NSString *said_id;
@property BOOL isOtherFocus;
@property BOOL isOtherFans;

@property(copy,nonatomic)NSString *user_id;

@end

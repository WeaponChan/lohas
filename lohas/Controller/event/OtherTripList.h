//
//  OtherTripList.h
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface OtherTripList : MSPullRefreshTableView<UITableViewDelegate,UITableViewDataSource>

@property(copy,nonatomic)NSString *user_id;
@property(copy,nonatomic)NSString *tripID;

@property BOOL isDetial;
@property BOOL isOther;
@property BOOL isDelete;

@end

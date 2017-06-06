//
//  DynamicJubaoList.h
//  lohas
//
//  Created by Juyuan123 on 16/2/25.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface DynamicJubaoList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

@property(copy,nonatomic)NSString *jubao_id;

@end

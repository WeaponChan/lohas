//
//  SearchHisList.h
//  lohas
//
//  Created by juyuan on 14-12-9.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface SearchHisList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

-(void) initial:(MSViewController*)parentViewController;

@end

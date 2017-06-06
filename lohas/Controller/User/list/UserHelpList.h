//
//  UserHelpList.h
//  lohas
//
//  Created by yons on 14-12-10.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface UserHelpList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

-(void) initial:(MSViewController*)parentViewController tag:(int)tag;

@end

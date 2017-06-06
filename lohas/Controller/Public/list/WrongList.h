//
//  WrongList.h
//  lohas
//
//  Created by fred on 15-4-15.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface WrongList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

-(void)selectWrong:(NSString*)wrongID;

@end

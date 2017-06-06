//
//  FoodTypeChioceList.h
//  lohas
//
//  Created by juyuan on 14-12-9.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface FoodTypeChioceList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
-(void) initial:(MSViewController*)parentViewController;

-(void)getSelectCell:(NSString*)cellIndex;
@property(copy,nonatomic) NSArray *SelectmenuL;

@end


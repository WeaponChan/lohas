//
//  ShopViewList.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface ShopViewList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
-(void) initial:(MSViewController*)parentViewController;
@property(copy,nonatomic)NSDictionary *responseItem;
@property(copy,nonatomic)NSDictionary *infoItem;
@property(copy,nonatomic)NSArray *array;
@property(copy,nonatomic)NSString *seID;
@property(copy,nonatomic)NSDictionary *comment_numDic;

@property BOOL isHideMore;

@end
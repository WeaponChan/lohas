//
//  SceneryViewList.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface SceneryViewList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
-(void) initial:(MSViewController*)parentViewController;

@property(copy,nonatomic)NSDictionary *countryInfo;
@property(copy,nonatomic)NSDictionary *HeadDic;
@property(copy,nonatomic)NSArray *array;
@property(copy,nonatomic)NSString *selectID;
@property(copy,nonatomic)NSDictionary *comment_numDic;
@property(copy,nonatomic)NSArray *photoList;

@property BOOL isHideMore;

@end

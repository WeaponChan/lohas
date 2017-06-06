//
//  DestinationList.h
//  lohas
//
//  Created by Juyuan123 on 16/3/4.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface DestinationList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
-(void) initial:(MSViewController*)parentViewController;
@property(copy,nonatomic)NSDictionary *responseItem;
@property(copy,nonatomic)NSDictionary *infoItem;
@property(copy,nonatomic)NSArray *array;
@property(copy,nonatomic)NSString *seID;
@property(copy,nonatomic)NSDictionary *comment_numDic;

@property BOOL isHideMore;

@property BOOL isDestination;

@end

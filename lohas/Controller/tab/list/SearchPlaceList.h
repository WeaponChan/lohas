//
//  SearchPlaceList.h
//  lohas
//
//  Created by juyuan on 14-12-9.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"


@interface SearchPlaceList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>

-(void) initial:(MSViewController*)parentViewController seat:(NSDictionary*)seat train:(NSDictionary*)train date:(NSString*)date array:(NSArray*)array;

-(void)refreshInfo:(NSDictionary*)seat train:(NSDictionary*)train date:(NSString*)date array:(NSArray*)array;

@property(copy,nonatomic)NSString *type;
@property(copy,nonatomic)NSString *searchText;

@end

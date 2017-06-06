//
//  SelectAddressList.h
//  lohas
//
//  Created by Juyuan123 on 16/4/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"
#import "BMapKit.h"

@interface SelectAddressList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate,BMKPoiSearchDelegate>{
    BMKPoiSearch* _poisearch;
}

@property(copy,nonatomic)NSArray *POIList;

@property BOOL isSearch;
@property(copy,nonatomic)NSString *cityName;
@property(copy,nonatomic)NSString *searchStr;

@property int count;

@end

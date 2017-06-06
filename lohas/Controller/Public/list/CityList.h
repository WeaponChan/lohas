//
//  CityList.h
//  chuanmei
//
//  Created by juyuan on 14-8-22.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface CityList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
{
    CLLocation *location;
    NSMutableArray* cityList;
    NSMutableDictionary* current_city;
    int locationError;
    
}
-(void) initial:(MSViewController*)parentViewController;
-(void) refresh:(CLLocation *)newlocation;
-(void) refreshFail;

@end

//
//  FoodList.h
//  lohas
//
//  Created by juyuan on 14-12-9.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface FoodList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
//tag=2酒店
-(void) initial:(MSViewController*)parentViewController tag:(int)tag;

@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *city_id;
@property(copy,nonatomic)NSString *category_id;
//@property(copy,nonatomic)CLLocation *location;
@property int type;
@property int price;
@property int priceType;

@property float lat;
@property float lng;

@end


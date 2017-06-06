//
//  SceneryList.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface SceneryList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
//-(void) initial:(MSViewController*)parentViewController;

@property(copy,nonatomic)NSString *type;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *cityID;
//@property(copy,nonatomic)CLLocation *Location;
@property(copy,nonatomic)NSString *priceType;
@property(copy,nonatomic)NSString *category;

@property float lat;
@property float lng;

@end

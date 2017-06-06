//
//  CountryList.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"


@interface CountryList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
-(void) initial:(MSViewController*)parentViewController;

@property(copy,nonatomic)NSString *type;
@property(copy,nonatomic)NSString *cityID;
@property(copy,nonatomic)NSString *typeID;
@property(copy,nonatomic)NSString *text;
//@property(copy,nonatomic)CLLocation *Location;
@property(copy,nonatomic)NSString *category_id;
@property(copy,nonatomic)NSString *priceType;

@property float lat;
@property float lng;

@end

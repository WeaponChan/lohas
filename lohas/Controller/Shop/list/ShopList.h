//
//  ShopList.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface ShopList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
-(void) initial:(MSViewController*)parentViewController;

@property(copy,nonatomic)NSString *type;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *cityID;
@property(copy,nonatomic)NSString *categoryID;
//@property(copy,nonatomic)CLLocation *location;

@property float lat;
@property float lng;

@end
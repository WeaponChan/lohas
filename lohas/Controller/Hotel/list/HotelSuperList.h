//
//  HotelSuperList.h
//  lohas
//
//  Created by Juyuan123 on 16/2/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MSPullRefreshTableView.h"

@interface HotelSuperList : MSPullRefreshTableView<UITableViewDataSource,UITableViewDelegate>
-(void) initial:(MSViewController*)parentViewController;
@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *city_id;
@property(copy,nonatomic)NSString *category_id;
@property(copy,nonatomic)NSString *sdate;
@property(copy,nonatomic)CLLocation *location;
@property int type;
@property(copy,nonatomic)NSString *edate;
@property (copy,nonatomic)NSString *price_type;

@property(copy,nonatomic)NSString *min;
@property(copy,nonatomic)NSString *max;

@end

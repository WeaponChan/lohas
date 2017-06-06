//
//  CityList.m
//  chuanmei
//
//  Created by juyuan on 14-8-22.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "CityList.h"
#import "CityCell.h"
#import "CityListViewController.h"

@implementation CityList

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
        location = nil;
        locationError = 0;
        current_city = nil;
    }
    return self;
}

-(void) initial:(MSViewController*)parentViewController
{
    [super initial:parentViewController];
    self.delegate = self;
    self.dataSource = self;
    cityList = [[NSMutableArray alloc] init];
    pageSize = 10;
    [super initData];
}

-(void)refresh:(CLLocation *)newlocation
{
    locationError = 1;
    location = newlocation;
    [super refreshData];
}

-(void)refreshFail
{
    locationError = -1;
    location = [[CLLocation alloc] initWithLatitude:-1 longitude:-1];
    [super refreshData];
}

-(void) asyncLoadData
{
    [super asyncLoadData];
    
    switch (actionType) {
        case ACTION_TYPE_INITIAL:
        case ACTION_TYPE_REFRESH:
        {
            pageIndex = 1;
            break;
        }
        case ACTION_TYPE_GETMORE:
        {
            pageIndex++;
            break;
        }
        case ACTION_TYPE_PULLREFRESH:
        {
            pageIndex = 1;
            break;
        }
        default:
            break;
    }

    Api *api1=[[Api alloc]init:self tag:@"get_city_lists"];
    [api1 get_city_lists];
    
    if (location) {
        Api *api2=[[Api alloc]init:self tag:@"get_current_city"];
        [api2 get_current_city:location];
    }
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self requestSucceeded:nil];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    if ([tag isEqualToString:@"get_city_lists"]) {
        NSArray *cities = response;
        if(cities && [cities isKindOfClass:[NSArray class]]) {
            [cityList removeAllObjects];
            [cityList addObjectsFromArray:cities];
            [self requestSucceeded:cities];
        }
    }else if ([tag isEqualToString:@"get_current_city"]){
        current_city = [[NSMutableDictionary alloc] init];
    }
}

- (void)requestSucceeded:(id)result
{
    NSLog(@"CITYLIST requestSucceeded");
    loaded = YES;
    switch (actionType) {
        case ACTION_TYPE_INITIAL:
        case ACTION_TYPE_REFRESH:
            [dataList removeAllObjects];
            [dataList addObjectsFromArray:result];
            break;
            break;
        case ACTION_TYPE_GETMORE:
            [dataList addObjectsFromArray:result];
            //关闭更多loading
            [getmorecell HiddenLoading];
            break;
        case ACTION_TYPE_PULLREFRESH:
            [dataList removeAllObjects];
            [dataList addObjectsFromArray:result];
            //停止下刷新
            [self performSelector:@selector(stopLoading) withObject:nil afterDelay:0.0];
            break;
        default:
            break;
    }
    
    NSLog(@"dataList.count:%lu",(unsigned long)dataList.count);
    
    [self reloadData];
    
    if (actionType == ACTION_TYPE_REFRESH) {
        [self setContentOffset:CGPointMake(0, 0) animated:true];
    }
    [parent closeLoadingView];
    actionType = ACTION_TYPE_IDLE;
    
    if(locationError==0) {
        CityListViewController* p = (CityListViewController*) parent;
       // [p autoLocation];
    }
}

- (void)requestFailed:(NSError *)error
{
    actionType = ACTION_TYPE_IDLE;
}


- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    switch (section) {
        case 0:
            return @"GPS定位城市：";
            break;
        default:
            break;
    }
    return @"城市列表：";
}

- (NSInteger)numberOfSectionsInTableView:(UITableView *)tableView
{
    return 2;
}
//设置cell总数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    if(section==0) {
        return 1;
    } else {
        return cityList.count;
    }
}
//设置单行高度
- (CGFloat)tableView:(UITableView *)mtableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if(indexPath.section==0) {
        return [CityCell Height:nil];
    }
    if (dataList.count == 0){
        return [EmptyDataCell Height];
    }
    return [CityCell Height:nil];
}
//设置某个cell对象
- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if(indexPath.section==0) {
        cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"CityCell"];
        CityCell *mCityCell = (CityCell *)cell;
        [mCityCell update:current_city Parent:parent];
    } else {
        if (cityList.count == 0) {
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EmptyDataCell"];
            EmptyDataCell *ecell = (EmptyDataCell *)cell;
            if(loaded) {
                [ecell update:@"目前还没有城市列表"];
            } else {
                [ecell update:@"正在加载城市列表"];
            }
        }else{
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"CityCell"];
            CityCell *mCityCell = (CityCell *)cell;
            NSDictionary *item = [cityList objectAtIndex:indexPath.row];
            [mCityCell update:item Parent:parent];
        }
    }
    
    return cell;
}
//触发单行点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    NSDictionary *item = nil;
    if(indexPath.section==0) {
        return;
        item = current_city;
    } else {
        item = [dataList objectAtIndex:indexPath.row];
    }
    
    
    NSString *cityID=[item objectForKeyNotNull:@"city_id"];
    NSString *name=[item objectForKeyNotNull:@"name"];
    
    if(cityID && name && [cityID intValue]>0) {
        [[AppDelegate sharedAppDelegate] setCityByName:name ID:cityID];
        [[AppDelegate sharedAppDelegate] openTabHomeCtrl];
    }

    [self deselectRowAtIndexPath:indexPath animated:YES];
}

//返回nil，那么所属的row将无法被选中
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

@end
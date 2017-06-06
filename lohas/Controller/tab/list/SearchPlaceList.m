//
//  SearchPlaceList.m
//  lohas
//
//  Created by juyuan on 14-12-9.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "SearchPlaceList.h"
#import "SearchPlaceCell.h"
#import "SBJson.h"
#import "SearchPlaceTitleCell.h"
#import "SearchCityCell.h"
#import "CountryListCell.h"
#import "ShopListCell.h"
#import "EventListCell.h"
#import "searchTitleCell.h"
#import "searchNullCell.h"
#import "FoodListCell.h"
#import "SceneryListCell.h"
#import "HotelListCell.h"

@implementation SearchPlaceList{
    NSMutableArray *list;
}
@synthesize type,searchText;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) initial:(MSViewController*)parentViewController
{
    [super initial:parentViewController];
    self.delegate = self;
    self.dataSource = self;
    
    pageSize = 100000;
    [super initData];
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
        default:
            break;
    }
    
    NSString *cityName=[[AppDelegate sharedAppDelegate] getCityName];
    NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
    
    Api *api=[[Api alloc]init:self tag:@"appSearch"];
    [api appSearch:searchText location:[AppDelegate sharedAppDelegate].ownLocation type:type city_id:cityId city:cityName];
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self requestSucceeded:nil];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    list=[[NSMutableArray alloc]init];
    
    NSArray *country=[response objectForKeyNotNull:@"country"];
    NSArray *activity=[response objectForKeyNotNull:@"activity"];
    NSArray *shopping=[response objectForKeyNotNull:@"shopping"];
    NSArray *shop=[response objectForKeyNotNull:@"shop"];
    
    NSArray *hotel=[response objectForKeyNotNull:@"hotel"];
    NSArray *travel=[response objectForKeyNotNull:@"travel"];
    
    
    if (country) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"country" forKey:@"type"];
        [dic setObject:@"乡村游" forKey:@"title"];
        [list addObject:dic];
        
        if (country.count>0) {
            for (NSMutableDictionary *dict in country) {
                [dict setObject:@"1" forKey:@"type"];
                [list addObject:dict];
            }
        }else{
            NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
            [dictt setObject:@"10" forKey:@"type"];
            [list addObject:dictt];
        }
    }
    if (activity) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"activity" forKey:@"type"];
        [dic setObject:@"活动" forKey:@"title"];
        [list addObject:dic];
        
        if (activity.count>0) {
            for (NSMutableDictionary *dict in activity) {
                [dict setObject:@"2" forKey:@"type"];
                [list addObject:dict];
            }
        }else{
            NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
            [dictt setObject:@"10" forKey:@"type"];
            [list addObject:dictt];
        }
    }
    if (shopping) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"shopping" forKey:@"type"];
        [dic setObject:@"购物" forKey:@"title"];
        [list addObject:dic];
        
        if (shopping.count>0) {
            for (NSMutableDictionary *dict in shopping) {
                [dict setObject:@"3" forKey:@"type"];
                [list addObject:dict];
            }
        }else{
            NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
            [dictt setObject:@"10" forKey:@"type"];
            [list addObject:dictt];
        }
    }
    if (shop) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"shop" forKey:@"type"];
        [dic setObject:@"餐厅" forKey:@"title"];
        [list addObject:dic];
        
        if (shop.count>0) {
            for (NSMutableDictionary *dict in shop) {
                [dict setObject:@"4" forKey:@"type"];
                [list addObject:dict];
            }
        }else{
            NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
            [dictt setObject:@"10" forKey:@"type"];
            [list addObject:dictt];
        }
    }
    if(hotel){
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"hotel" forKey:@"type"];
        [dic setObject:@"酒店" forKey:@"title"];
        [list addObject:dic];
        
        if (hotel.count>0) {
            for (NSMutableDictionary *dict in hotel) {
                [dict setObject:@"5" forKey:@"type"];
                [list addObject:dict];
            }
        }else{
            NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
            [dictt setObject:@"10" forKey:@"type"];
            [list addObject:dictt];
        }
    }
    if (travel) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"travel" forKey:@"type"];
        [dic setObject:@"景点" forKey:@"title"];
        [list addObject:dic];
        
        if (travel.count>0) {
            for (NSMutableDictionary *dict in travel) {
                [dict setObject:@"6" forKey:@"type"];
                [list addObject:dict];
            }
        }else{
            NSMutableDictionary *dictt=[[NSMutableDictionary alloc]init];
            [dictt setObject:@"10" forKey:@"type"];
            [list addObject:dictt];
        }
    }
    
   // NSLog(@"list===%@",list);
    
    
    if(list && [list isKindOfClass:[NSArray class]]) {

        
    } else {
        list = [[NSMutableArray alloc] init];

    }
    
    [self requestSucceeded:list];
}

- (void)requestSucceeded:(id)result
{
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
    
    NSLog(@"dataList.count:%d",dataList.count);
    [self reloadData];
    if (actionType == ACTION_TYPE_REFRESH) {
        [self setContentOffset:CGPointMake(0, 0) animated:true];
    }
    [parent closeLoadingView];
    actionType = ACTION_TYPE_IDLE;
    
}

- (void)requestFailed:(NSError *)error
{
    actionType = ACTION_TYPE_IDLE;
}



//设置cell总数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (dataList.count == 0) {
        return 1;
    }else{
        
        return dataList.count;
    }
}
//设置单行高度
- (CGFloat)tableView:(UITableView *)mtableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataList.count == 0){
        return [EmptyDataCell Height];
    }
    
    NSDictionary *item = [dataList objectAtIndex:indexPath.row];
    NSString *type11=[item objectForKeyNotNull:@"type"];
    if ([type11 isEqual:@"country"] || [type11 isEqual:@"activity"] || [type11 isEqual:@"shopping"] || [type11 isEqual:@"shop"] || [type11 isEqual:@"hotel"] || [type11 isEqual:@"travel"]) {
        return [searchTitleCell Height:item];
    }
    if ([type11 isEqual:@"1"]) {
        return [CountryListCell Height:item];
    }
    if ([type11 isEqual:@"2"]) {
        return [EventListCell Height:item];
    }
    if ([type11 isEqual:@"3"]) {
        return [ShopListCell Height:item];
    }
    if ([type11 isEqual:@"10"]) {
        return [searchNullCell Height:item];
    }
    if ([type11 isEqual:@"4"]) {
        return [FoodListCell Height:item];
    }
    if ([type11 isEqual:@"5"]) {
        return [HotelListCell Height:item];
    }
    if ([type11 isEqual:@"6"]) {
        return [SceneryListCell Height:item];
    }
    
    return 0;
}
//设置某个cell对象
- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if (dataList.count == 0) {
        cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EmptyDataCell"];
        EmptyDataCell *ecell = (EmptyDataCell *)cell;
        if(loaded) {
            [ecell update:@"暂未搜索到相关内容"];
        } else {
            [ecell update:@"正在搜索..."];
        }
    }else{
        
        NSDictionary *item = [dataList objectAtIndex:indexPath.row];
        NSString *type11=[item objectForKeyNotNull:@"type"];
        
        if ([type11 isEqual:@"country"] || [type11 isEqual:@"activity"] || [type11 isEqual:@"shopping"] || [type11 isEqual:@"shop"] || [type11 isEqual:@"hotel"] || [type11 isEqual:@"travel"]) {
            
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"SearchPlaceTitleCell"];
            
            SearchPlaceTitleCell *mSearchPlaceTitleCell = (SearchPlaceTitleCell *)cell;
            
            [mSearchPlaceTitleCell update:item Parent:parent];
            
        }
        if ([type11 isEqual:@"1"]) {
            
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"CountryListCell"];
            
            CountryListCell *mSearchPlaceTitleCell = (CountryListCell *)cell;
            
            [mSearchPlaceTitleCell update:item Parent:parent];
            
        }
        if ([type11 isEqual:@"2"]) {
        
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EventListCell"];
            
            EventListCell *mSearchPlaceTitleCell = (EventListCell *)cell;
            
            [mSearchPlaceTitleCell update:item Parent:parent];
            
        }
        if ([type11 isEqual:@"3"]) {
            
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"ShopListCell"];
            
            ShopListCell *mSearchPlaceTitleCell = (ShopListCell *)cell;
            
            [mSearchPlaceTitleCell update:item Parent:parent];
        }
        if ([type11 isEqual:@"4"]) {
            
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodListCell"];
            
            FoodListCell *mSearchPlaceTitleCell = (FoodListCell *)cell;
            
            [mSearchPlaceTitleCell update:item Parent:parent tag:1];
        }
        if ([type11 isEqual:@"5"]) {
            
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"HotelListCell"];
            
            HotelListCell *mSearchPlaceTitleCell = (HotelListCell *)cell;
            
            [mSearchPlaceTitleCell update:item Parent:parent];
        }
        if ([type11 isEqual:@"6"]) {
            
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"SceneryListCell"];
            
            SceneryListCell *mSearchPlaceTitleCell = (SceneryListCell *)cell;
            
            [mSearchPlaceTitleCell update:item Parent:parent];
        }
        
        if ([type11 isEqual:@"10"]) {
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"searchNullCell"];
            
             searchNullCell *ecell = (searchNullCell *)cell;
            
             [ecell update:item Parent:parent];
        }
        
    }
    
    return cell;
}
//触发单行点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (indexPath.row != [dataList count]) {
        
    }else if([dataList count]!=0){
        //查看更多
        [self getmoreData];
    }
    
    [self deselectRowAtIndexPath:indexPath animated:YES];
}

//返回nil，那么所属的row将无法被选中
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}

@end
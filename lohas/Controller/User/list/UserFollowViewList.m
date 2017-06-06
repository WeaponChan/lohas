//
//  UserFollowViewList.m
//  lohas
//
//  Created by fred on 15-3-12.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "UserFollowViewList.h"
#import "UserFollowViewCell.h"
#import "CountryListCell.h"
#import "SceneryListCell.h"
#import "HotelListCell.h"
#import "FoodListCell.h"
#import "ShopListCell.h"
#import "EventListCell.h"
#import "EventFollowCell.h"

@implementation UserFollowViewList
@synthesize type,id11;
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
    
    pageSize = 10;
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
        case ACTION_TYPE_PULLREFRESH:
        {
            pageIndex = 1;
            break;
        }
        default:
            break;
    }
    
    Api* api = [[Api alloc] init:self];
    [api my_collect_lists:pageIndex count:pageSize location:[AppDelegate sharedAppDelegate].ownLocation];
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self requestSucceeded:nil];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    if(response && [response isKindOfClass:[NSArray class]]) {
        
        
    } else {
        response = [[NSArray alloc] init];
    }
    
    [self requestSucceeded:response];
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
    }else if(dataList.count >= pageSize*pageIndex){
        return dataList.count+1;
    }else{
        return dataList.count;
    }
}
//设置单行高度
- (CGFloat)tableView:(UITableView *)mtableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (dataList.count == 0){
        return [EmptyDataCell Height];
    }else if(indexPath.row>=dataList.count){
        return [GetMoreCell Height];
    }
    
    NSDictionary *dict=dataList[indexPath.row];
    NSString *type=[dict objectForKeyNotNull:@"type"];
    
    if (type.intValue==6) {
        return [EventFollowCell Height:[dict objectForKeyNotNull:@"info"]];
    }
    
    return 110;
}
//设置某个cell对象
- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if (dataList.count == 0) {
        cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EmptyDataCell"];
        EmptyDataCell *ecell = (EmptyDataCell *)cell;
        if(loaded) {
            [ecell update:@"目前还没有记录"];
        } else {
            [ecell update:@""];
        }
    }else if (indexPath.row >= dataList.count) {
        cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"GetMoreCell"];
        getmorecell = (GetMoreCell *)cell;
        [parent performBlock:^{
            [self getmoreData];
        }afterDelay:0.2];
    }else{
    
        NSDictionary *dict=dataList[indexPath.row];
        NSString *type=[dict objectForKeyNotNull:@"type"];
        //乡村游
        if (type.intValue==1) {
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"CountryListCell"];
            CountryListCell *mUserHelp = (CountryListCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            NSDictionary *info=[item objectForKeyNotNull:@"info"];
            mUserHelp.isNeehideDistance=YES;
            [mUserHelp update:info Parent:parent];
        }
        //景点
        else if (type.intValue==2){
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"SceneryListCell"];
            SceneryListCell *mUserHelp = (SceneryListCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            NSDictionary *info=[item objectForKeyNotNull:@"info"];
            mUserHelp.isNeehideDistance=YES;
            [mUserHelp update:info Parent:parent];
        }
        //酒店
        else if (type.intValue==3){
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"HotelListCell"];
            HotelListCell *mUserHelp = (HotelListCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            NSDictionary *info=[item objectForKeyNotNull:@"info"];
            mUserHelp.isNeehideDistance=YES;
            [mUserHelp update:info Parent:parent];
        }
        //餐厅
        else if (type.intValue==4){
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodListCell"];
            FoodListCell *mUserHelp = (FoodListCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            NSDictionary *info=[item objectForKeyNotNull:@"info"];
            mUserHelp.isNeehideDistance=YES;
            [mUserHelp update:info Parent:parent tag:4];
        }
        //购物
        else if (type.intValue==5){
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"ShopListCell"];
            ShopListCell *mUserHelp = (ShopListCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            NSDictionary *info=[item objectForKeyNotNull:@"info"];
            mUserHelp.isNeehideDistance=YES;
            [mUserHelp update:info Parent:parent];
        }
        //活动
        else if (type.integerValue==6){
            
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EventFollowCell"];
            EventFollowCell *mUserHelp = (EventFollowCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            NSDictionary *info=[item objectForKeyNotNull:@"info"];
            mUserHelp.isNeehideDistance=YES;
            [mUserHelp update:info Parent:parent];
            
           /* cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EventListCell"];
            EventListCell *mUserHelp = (EventListCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            NSDictionary *info=[item objectForKeyNotNull:@"info"];
            mUserHelp.isNeehideDistance=YES;
            [mUserHelp update:info Parent:parent];*/
            
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
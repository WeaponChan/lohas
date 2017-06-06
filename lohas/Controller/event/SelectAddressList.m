//
//  SelectAddressList.m
//  lohas
//
//  Created by Juyuan123 on 16/4/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "SelectAddressList.h"
#import "SelectAddressCell.h"
#import "SelectAddressViewController.h"

@implementation SelectAddressList
@synthesize POIList,isSearch,cityName,searchStr,count;

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
    
    if (isSearch) {
        
        pageSize = 10;
    }else{
        pageSize = 100000;
    }
    
    
    
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
            
//            SelectAddressViewController *viewctrl=(SelectAddressViewController*)parent;
//            [viewctrl onClickNextPage];
            
            
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
    
    if (isSearch) {
        
        _poisearch = [[BMKPoiSearch alloc]init];
        _poisearch.delegate = self;
        
        BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
        
        citySearchOption.pageIndex = pageIndex;
        citySearchOption.pageCapacity = pageSize;
        citySearchOption.city= cityName;
        citySearchOption.keyword = searchStr;
        BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
        if(flag)
        {
            
            NSLog(@"城市内检索发送成功");
        }
        else
        {
            
            NSLog(@"城市内检索发送失败");
        }
        
        
        
    }else{
        [self requestSucceeded:POIList];
    }
    
    
    //[self requestSucceeded:POIList];
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [parent showAlert:message];
    [self requestSucceeded:nil];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
  
    NSArray *list=[response objectForKeyNotNull:@"list"];
    
    if (!list) {
        list=[response objectForKeyNotNull:@"items"];
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
    //    NSLog(@"dataList.count:%d",dataList.count);
    [self reloadData];
    if (actionType == ACTION_TYPE_REFRESH) {
        //[self setContentOffset:CGPointMake(0, 0) animated:true];
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

    return 50;
}
//设置某个cell对象
- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if (dataList.count == 0) {
        cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EmptyDataCell"];
        EmptyDataCell *ecell = (EmptyDataCell *)cell;
        if(loaded) {
            [ecell update:@"还没有信息..."];
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
            
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"SelectAddressCell"];
            SelectAddressCell *mEventListCell = (SelectAddressCell *)cell;
            mEventListCell.poiList=dataList[indexPath.row];
        
            [mEventListCell update:nil Parent:parent];
        
        
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


#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    
 
        [parent closeLoadingView];
    
    
    [self requestSucceeded:result.poiInfoList];
    
    
}






@end

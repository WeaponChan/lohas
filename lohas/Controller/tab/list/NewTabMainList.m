//
//  NewTabMainList.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "NewTabMainList.h"
#import "NewTabMainHeadCell.h"
#import "NewTabMainCenterCell.h"
#import "NewTabHotCityCell.h"
#import "NewTabMainSeeMore.h"
#import "NewTabSubTitleCell.h"
#import "NewTabMainViewController.h"

@implementation NewTabMainList
@synthesize mainArrayList;

-  (id)initWithFrame:(CGRect)frame
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
    pageSize = 10000;
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

    NSString *cityName=[[AppDelegate sharedAppDelegate] getCityID];
    double lat=[AppDelegate sharedAppDelegate].ownLocation.coordinate.latitude;
    double lng=[AppDelegate sharedAppDelegate].ownLocation.coordinate.longitude;
    
    Api *api=[[Api alloc]init:self tag:@"index"];
    [api index:cityName lat:[NSString stringWithFormat:@"%f",lat] lng:[NSString stringWithFormat:@"%f",lng]];
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self requestSucceeded:nil];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    NSMutableArray *arrayList=[[NSMutableArray alloc]init];
    
    //滚动栏
    NSArray *adList=[response objectForKeyNotNull:@"adList"];
    NSMutableDictionary *addDic=[[NSMutableDictionary alloc]init];
    [addDic setObject:adList forKey:@"adList"];
    [addDic setObject:@"1" forKey:@"tag"];
    [arrayList addObject:addDic];
    
    //类别
    NSMutableDictionary *cateDic=[[NSMutableDictionary alloc]init];
    [cateDic setObject:@"2" forKey:@"tag"];
    [arrayList addObject:cateDic];
    
    //热门城市
    NSMutableArray *hotCity=[response objectForKeyNotNull:@"hotCity"];
    
    NSMutableDictionary *cityDic=[[NSMutableDictionary alloc]init];
    
    int count=hotCity.count;
    int i=1;
    for (NSDictionary *dicHotCity in hotCity) {
        
        if (cityDic.count==0) {
            
            [cityDic setObject:dicHotCity forKey:@"cityDic1"];
            
            if (i==count) {
                [cityDic setObject:@"3" forKey:@"tag"];
                [arrayList addObject:cityDic];
            }
            
        }else{
            if (cityDic.count==1) {
                [cityDic setObject:dicHotCity forKey:@"cityDic2"];
            }else{
                cityDic=[[NSMutableDictionary alloc]init];
                [cityDic setObject:dicHotCity forKey:@"cityDic2"];
            }
            
            [cityDic setObject:@"3" forKey:@"tag"];
            [arrayList addObject:cityDic];
            cityDic=[[NSMutableDictionary alloc]init];
        }
        
        i++;
    }
    
    //查看更多
    NSMutableDictionary *moreDic=[[NSMutableDictionary alloc]init];
    [moreDic setObject:@"4" forKey:@"tag"];
    [arrayList addObject:moreDic];
    
    //乐活精选
    NSArray *topList=[response objectForKeyNotNull:@"topList"];
    for (NSMutableDictionary *topDic in topList) {
        [topDic setObject:@"5" forKey:@"tag"];
        [arrayList addObject:topDic];
    }

    [self requestSucceeded:arrayList];
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
       // [self setContentOffset:CGPointMake(0, 0) animated:true];
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
    
    NSDictionary *dic=[dataList objectAtIndex:indexPath.row];
    NSString *tag=[dic objectForKeyNotNull:@"tag"];
    if (tag.intValue==1) {
        return [NewTabMainHeadCell Height:[dataList objectAtIndex:indexPath.row]];
    }else if (tag.intValue==2){
        return [NewTabMainCenterCell Height:[dataList objectAtIndex:indexPath.row]];
    }
    else if (tag.intValue==3){
        return [NewTabHotCityCell Height:[dataList objectAtIndex:indexPath.row]];
    }
    else if (tag.intValue==4){
        return [NewTabMainSeeMore Height:dataList[indexPath.row]];
    }
    
    return [NewTabSubTitleCell Height:dataList[indexPath.row]];
    
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
        
        NSDictionary *dic=[dataList objectAtIndex:indexPath.row];
        NSString *tag=[dic objectForKeyNotNull:@"tag"];
        if (tag.intValue==1) {
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"NewTabMainHeadCell"];
            NewTabMainHeadCell *mSearchCityCell = (NewTabMainHeadCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            [mSearchCityCell update:item Parent:parent];
        }
        else if (tag.intValue==2){
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"NewTabMainCenterCell"];
            NewTabMainCenterCell *mSearchCityCell = (NewTabMainCenterCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            [mSearchCityCell update:item Parent:parent];
        }
        else if (tag.intValue==3){
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"NewTabHotCityCell"];
            NewTabHotCityCell *mSearchCityCell = (NewTabHotCityCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            [mSearchCityCell update:item Parent:parent];
        }
        else if (tag.intValue==4){
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"NewTabMainSeeMore"];
            NewTabMainSeeMore *mSearchCityCell = (NewTabMainSeeMore *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            [mSearchCityCell update:item Parent:parent];
        }
        else if (tag.intValue==5){
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"NewTabSubTitleCell"];
            NewTabSubTitleCell *mSearchCityCell = (NewTabSubTitleCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            [mSearchCityCell update:item Parent:parent];
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

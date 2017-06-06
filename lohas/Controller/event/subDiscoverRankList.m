//
//  subDiscoverRankList.m
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "subDiscoverRankList.h"
#import "subDiscoverRankCell.h"
#import "subDiscoverTitleCell.h"

@implementation subDiscoverRankList

@synthesize typeID,rankID;

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
    pageSize = 1000;
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
    

    Api* api = [[Api alloc] init:self tag:@"topList"];
    [api topList:rankID category_id:typeID];
    

    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self requestSucceeded:nil];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    NSArray *topList=[response objectForKeyNotNull:@"topList"];
    NSArray *list=[response objectForKeyNotNull:@"list"];
    
    NSMutableArray *postList=[[NSMutableArray alloc]init];
    [postList addObjectsFromArray:topList];
    
    if (list.count>0) {
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"1" forKey:@"typeID"];
        [postList addObject:dic];
        [postList addObjectsFromArray:list];
    }
    
    [self requestSucceeded:postList];
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
    
    NSDictionary *dic=dataList[indexPath.row];
    NSString *type=[dic objectForKeyNotNull:@"typeID"];
    if (type.intValue==1) {
        
        return [subDiscoverTitleCell Height:[dataList objectAtIndex:indexPath.row]];
    }
    
    
    return [subDiscoverRankCell Height:[dataList objectAtIndex:indexPath.row]];
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
        
        NSDictionary *dic=dataList[indexPath.row];
        NSString *type=[dic objectForKeyNotNull:@"typeID"];
        if (type.intValue==1) {
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"subDiscoverTitleCell"];
            subDiscoverTitleCell *mEventListCell = (subDiscoverTitleCell *)cell;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            [mEventListCell update:item Parent:parent];
        }else{
            cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"subDiscoverRankCell"];
            subDiscoverRankCell *mEventListCell = (subDiscoverRankCell *)cell;
            mEventListCell.category_id=typeID;
            NSDictionary *item = [dataList objectAtIndex:indexPath.row];
            [mEventListCell update:item Parent:parent];
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

//
//  FoodList.m
//  lohas
//
//  Created by juyuan on 14-12-9.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodList.h"
#import "FoodListCell.h"

@implementation FoodList{
    int viewTag;
}
@synthesize city_id,lat,lng,category_id,title,type,priceType;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void) initial:(MSViewController*)parentViewController tag:(int)tag
{
    [super initial:parentViewController];
    self.delegate = self;
    self.dataSource = self;
    
    viewTag=tag;
    
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
    
    
    //酒店列表
    if (viewTag==2) {
       // Api* api = [[Api alloc] init:self tag:@"get_hotel_list"];
       // [api get_hotel_list:self.title city_id:self.city_id category_id:self.category_id type:self.type location:self.location page:pageIndex count:pageSize date:self.sda];
    }
    //餐厅
    else if (viewTag==1){
        
        if (title.length==0) {
            title=@"";
        }    
        
        Api* api = [[Api alloc] init:self tag:@"get_Dinner_lists"];
        [api get_Dinner_lists:title category:category_id type:type price_type:[NSString stringWithFormat:@"%d",priceType] lat:lat lng:lng city_id:city_id page:pageIndex count:pageSize];
        
    }
    //我的关注
    else if (viewTag==3){
        Api *api=[[Api alloc]init:self tag:@"my_collect_lists"];
        [api my_collect_lists:pageIndex count:pageSize location:[AppDelegate sharedAppDelegate].ownLocation];
    }
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self requestSucceeded:nil];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    if (!response || response == [NSNull null]) {
        [self requestFailed:nil];
        return;
    }
    
    NSArray *list;
    if (![response isKindOfClass:[NSArray class]]) {
        list=[response objectForKeyNotNull:@"businesses"];
    }else{
        list=response;
    }
    
    if(list && [list isKindOfClass:[NSArray class]]) {
        
    } else {
        list = [[NSArray alloc] init];
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
    return [FoodListCell Height:[dataList objectAtIndex:indexPath.row]];
}
//设置某个cell对象
- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if (dataList.count == 0) {
        cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EmptyDataCell"];
        EmptyDataCell *ecell = (EmptyDataCell *)cell;
        if(loaded) {
            [ecell update:@"还没有餐厅,正在努力添加中..."];
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
        cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodListCell"];
        FoodListCell *mFoodListCell = (FoodListCell *)cell;
        NSDictionary *item = [dataList objectAtIndex:indexPath.row];
        
        [mFoodListCell update:item Parent:parent tag:viewTag];
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
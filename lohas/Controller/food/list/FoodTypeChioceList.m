//
//  FoodTypeChioceList.m
//  lohas
//
//  Created by juyuan on 14-12-9.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodTypeChioceList.h"
#import "FoodTypeChioceCell.h"
#import "FoodTypeChioceViewController.h"

@implementation FoodTypeChioceList{
    NSMutableArray *menuList;
}
@synthesize SelectmenuL;

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
    
    Api *api=[[Api alloc]init:self tag:@"get_category_lists"];
    [api get_category_lists];
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self requestSucceeded:nil];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    menuList=[[NSMutableArray alloc]initWithArray:response];
    
    int i=0;
    for (NSMutableDictionary *dic in menuList) {
        [dic setObject:@"NO" forKey:@"select"];
        [dic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"index"];
        i++;
    }
    
    if(menuList && [menuList isKindOfClass:[NSArray class]]) {
        
        
    } else {
        response = [[NSArray alloc] init];
    }
    
    [self requestSucceeded:menuList];
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
    return [FoodTypeChioceCell Height:[dataList objectAtIndex:indexPath.row]];
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
        cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodTypeChioceCell"];
        FoodTypeChioceCell *mFoodTypeChioceCell = (FoodTypeChioceCell *)cell;
        NSDictionary *item = [dataList objectAtIndex:indexPath.row];
        [mFoodTypeChioceCell update:item Parent:parent];
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

//
-(void)getSelectCell:(NSString*)cellIndex{
    NSMutableDictionary *dic=menuList[cellIndex.intValue];
    
    NSString *select=[dic objectForKeyNotNull:@"select"];
    if ([select isEqual:@"NO"]) {
        [dic setObject:@"YES" forKey:@"select"];
    }else{
        [dic setObject:@"NO" forKey:@"select"];
    }
    
    [self requestSucceeded:menuList];
    
    FoodTypeChioceViewController *viewCtrl=(FoodTypeChioceViewController*)parent;
    [viewCtrl getSelectCell:menuList];
}

@end
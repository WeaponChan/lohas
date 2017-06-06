//
//  FoodViewList.m
//  lohas
//
//  Created by yons on 14-12-10.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodViewList.h"
#import "FoodViewTitleCell.h"
#import "FoodViewInfoCell.h"
#import "FoodViewReviewsCell.h"
#import "FoodReviewViewCell.h"
#import "PlaceViewCell.h"
//#import "FoodHotelCell.h"

@implementation FoodViewList{
    int viewTag;
}

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
    pageSize = 10;
    
    viewTag=tag;
    
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
    
    if (viewTag==2 || viewTag==3 || viewTag==4) {
        Api* api = [[Api alloc] init:self];
        [api test:@"{\"success\":1,\"data\":[{\"Title\":\"\",\"Time\":\"\",\"People\":\"\",\"img\":\"\",\"tag\":\"1\"},{\"Title\":\"\",\"Time\":\"\",\"People\":\"人数：1/20人\",\"img\":\"\",\"tag\":\"2\"},{\"Title\":\"\",\"Time\":\"\",\"People\":\"人数：1/20人\",\"img\":\"\",\"tag\":\"3\"},{\"Title\":\"\",\"Time\":\"\",\"People\":\"\",\"img\":\"\",\"tag\":\"4\"},{\"Title\":\"\",\"Time\":\"日期：2014年5月10日～5月20日\",\"People\":\"人数：1/20人\",\"img\":\"default_img_bg.png\",\"tag\":\"5\"},{\"Title\":\"\",\"Time\":\"\",\"People\":\"\",\"img\":\"\",\"tag\":\"6\"}]}"];
    }
    else{
        Api* api = [[Api alloc] init:self];
        [api test:@"{\"success\":1,\"data\":[{\"Title\":\"\",\"Time\":\"\",\"People\":\"\",\"img\":\"\",\"tag\":\"1\"},{\"Title\":\"\",\"Time\":\"\",\"People\":\"人数：1/20人\",\"img\":\"\",\"tag\":\"2\"},{\"Title\":\"\",\"Time\":\"\",\"People\":\"人数：1/20人\",\"img\":\"\",\"tag\":\"3\"},{\"Title\":\"\",\"Time\":\"\",\"People\":\"\",\"img\":\"\",\"tag\":\"4\"},{\"Title\":\"\",\"Time\":\"日期：2014年5月10日～5月20日\",\"People\":\"人数：1/20人\",\"img\":\"default_img_bg.png\",\"tag\":\"5\"}]}"];
    }
  
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
    
    NSDictionary *dic=[dataList objectAtIndex:indexPath.row];
    NSString *tag=[dic objectForKeyNotNull:@"tag"];
    
    if (viewTag==2 || viewTag==3 || viewTag==4) {
        if (tag.intValue==1) {
            return [FoodViewTitleCell Height:[dataList objectAtIndex:indexPath.row]];
        }else if (tag.intValue==2){
            return [FoodViewInfoCell Height:[dataList objectAtIndex:indexPath.row]];
        }else if (tag.intValue==3){
//            return [FoodHotelCell Height:[dataList objectAtIndex:indexPath.row]];
        }else if (tag.intValue==4){
            return [FoodViewReviewsCell Height:[dataList objectAtIndex:indexPath.row]];
        }else if (tag.intValue==5){
            return [FoodReviewViewCell Height:[dataList objectAtIndex:indexPath.row]];
        }else if (tag.intValue==6){
            return [PlaceViewCell Height:[dataList objectAtIndex:indexPath.row]];
        }
    }else{
        if (tag.intValue==1) {
            return [FoodViewTitleCell Height:[dataList objectAtIndex:indexPath.row]];
        }else if (tag.intValue==2){
            return [FoodViewInfoCell Height:[dataList objectAtIndex:indexPath.row]];
        }else if (tag.intValue==3){
            return [FoodViewReviewsCell Height:[dataList objectAtIndex:indexPath.row]];
        }else if (tag.intValue==4){
            return [FoodReviewViewCell Height:[dataList objectAtIndex:indexPath.row]];
        }else if (tag.intValue==5){
            return [PlaceViewCell Height:[dataList objectAtIndex:indexPath.row]];
        }
    }
    
   
    
    return [FoodViewTitleCell Height:[dataList objectAtIndex:indexPath.row]];
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

        if (viewTag==2 || viewTag==3 || viewTag==4) {
            if (tag.intValue==1) {
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodViewTitleCell"];
                FoodViewTitleCell *mFoodListCell = (FoodViewTitleCell *)cell;
                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
                [mFoodListCell update:item Parent:parent];
            }
            else if (tag.intValue==2){
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodViewInfoCell"];
                FoodViewInfoCell *mFoodListCell = (FoodViewInfoCell *)cell;
                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
                [mFoodListCell update:item Parent:parent];
            }
            else if (tag.intValue==3){
//                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodHotelCell"];
//                FoodHotelCell *mFoodListCell = (FoodHotelCell *)cell;
//                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
//                [mFoodListCell update:item Parent:parent];
            }
            else if (tag.intValue==4){
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodViewReviewsCell"];
                FoodViewReviewsCell *mFoodListCell = (FoodViewReviewsCell *)cell;
                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
                [mFoodListCell update:item Parent:parent];
            }
            else if (tag.intValue==5){
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodReviewViewCell"];
                FoodReviewViewCell *mFoodListCell = (FoodReviewViewCell *)cell;
                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
                [mFoodListCell update:item Parent:parent];
            }
            else if (tag.intValue==6){
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"PlaceViewCell"];
                PlaceViewCell *mFoodListCell = (PlaceViewCell *)cell;
                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
                [mFoodListCell update:item Parent:parent];
            }

        }else{
            if (tag.intValue==1) {
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodViewTitleCell"];
                FoodViewTitleCell *mFoodListCell = (FoodViewTitleCell *)cell;
                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
                [mFoodListCell update:item Parent:parent];
            }
            else if (tag.intValue==2){
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodViewInfoCell"];
                FoodViewInfoCell *mFoodListCell = (FoodViewInfoCell *)cell;
                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
                [mFoodListCell update:item Parent:parent];
            }
            else if (tag.intValue==3){
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodViewReviewsCell"];
                FoodViewReviewsCell *mFoodListCell = (FoodViewReviewsCell *)cell;
                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
                [mFoodListCell update:item Parent:parent];
            }
            else if (tag.intValue==4){
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodReviewViewCell"];
                FoodReviewViewCell *mFoodListCell = (FoodReviewViewCell *)cell;
                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
                [mFoodListCell update:item Parent:parent];
            }
            else if (tag.intValue==5){
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"PlaceViewCell"];
                PlaceViewCell *mFoodListCell = (PlaceViewCell *)cell;
                NSDictionary *item = [dataList objectAtIndex:indexPath.row];
                [mFoodListCell update:item Parent:parent];
            }
 
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
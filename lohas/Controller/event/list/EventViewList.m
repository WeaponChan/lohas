//
//  EventViewList.m
//  lohas
//
//  Created by Juyuan123 on 15/5/10.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "EventViewList.h"
#import "EventTextCell.h"
#import "EventViewInfCell.h"
#import "EventViewTitleCell.h"
#import "FoodViewReviewsCell.h"
#import "FoodReviewViewCell.h"
#import "PlaceViewCell.h"
#import "EventNewViewController.h"

@implementation EventViewList

@synthesize countryInfo,selectID,comment_numDic,photoList,isHideMore;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

-(void)initial:(MSViewController*)parentViewController
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
        case ACTION_TYPE_PULLREFRESH:{
            
            if ([parent isKindOfClass:[EventNewViewController class]]) {
                
                EventNewViewController *viewCtrl=(EventNewViewController*)parent;
                [viewCtrl refresh];
            }
            
            pageIndex = 1;
            break;
        }
        default:
            break;
    }
    
    [self requestSucceeded:self.array];
    
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
    //选项类型
    NSString *type=[item objectForKeyNotNull:@"type"];
    
    switch (type.intValue) {
        case 0:
            
            return [EventViewTitleCell Height:countryInfo];
            
            break;
            
        case 1:
            
            return [EventViewInfCell Height:item];
            
            break;
            
        case 2:
            
            return [EventTextCell Height:countryInfo isHide:isHideMore];
            
            break;
            
        case 3:
            
            return [FoodViewReviewsCell Height:item];
            
            break;
            
        case 4:
            
            return [FoodReviewViewCell Height:item];
            
            break;
            
        case 5:
            
            return [PlaceViewCell Height:item];
            
            break;
            
            
    }
    
    return 0;}
//设置某个cell对象
- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    
    UITableViewCell *cell;
    
    if (dataList.count == 0) {
        cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EmptyDataCell"];
        EmptyDataCell *ecell = (EmptyDataCell *)cell;
        if(loaded) {
            [ecell update:@"目前还没有服务单"];
        } else {
            [ecell update:@"尚未获取服务单信息"];
        }
    }else{
        NSDictionary *item = [dataList objectAtIndex:indexPath.row];
        //选项类型
        NSString *type=[item objectForKeyNotNull:@"type"];
        switch (type.intValue) {
            case 0:
            {
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EventViewTitleCell"];
                
                EventViewTitleCell *mCountryTitleCell = (EventViewTitleCell *)cell;
                mCountryTitleCell.countryInfo=countryInfo;
                mCountryTitleCell.headDic=self.HeadDic;
                
                [mCountryTitleCell update:item Parent:parent];
                
                break;
            }
            case 1:
            {
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EventViewInfCell"];
                
                EventViewInfCell *mCountryInfoCell = (EventViewInfCell *)cell;
                mCountryInfoCell.countryInfo=countryInfo;
                
                [mCountryInfoCell update:item Parent:parent];
                
                break;
            }
            case 2:
            {
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"EventTextCell"];
                
                EventTextCell *mCountryTextCell = (EventTextCell *)cell;
                mCountryTextCell.countryInfo=countryInfo;
                mCountryTextCell.isHideMore=isHideMore;
                [mCountryTextCell update:item Parent:parent];
                
                break;
            }
            case 3:
            {
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodViewReviewsCell"];
                
                FoodViewReviewsCell *mFoodViewReviewsCell= (FoodViewReviewsCell *)cell;
                mFoodViewReviewsCell.comment_numDic=comment_numDic;
                mFoodViewReviewsCell.infoDic=countryInfo;
                [mFoodViewReviewsCell update:item Parent:parent];
                
                break;
            }
            case 4:
            {
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"FoodReviewViewCell"];
                
                FoodReviewViewCell *mFoodReviewViewCell = (FoodReviewViewCell *)cell;
                
                [mFoodReviewViewCell update:item Parent:parent];
                
                break;
            }
            case 5:
            {
                cell=[MSUIUtils newCellByNibName: mtableView  NibName:@"PlaceViewCell"];
                
                PlaceViewCell *mPlaceViewCell= (PlaceViewCell *)cell;
                mPlaceViewCell.type=6;
                mPlaceViewCell.selID=selectID;
                mPlaceViewCell.infoItem=countryInfo;
                [mPlaceViewCell update:item Parent:parent];
                
                break;
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

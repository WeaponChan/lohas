//
//  MSTableView.m
//  xyhui
//
//  Created by shen xmload on 13-5-17.
//
//

#import "MSTableView.h"

@implementation MSTableView
@synthesize isInitData;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        actionType = ACTION_TYPE_IDLE;
        isInitData = NO;
        loaded = NO;
    }
    return self;
}
-(void) initial:(MSViewController*)parentViewController
{
    parent = parentViewController;
    //数据
    cellList = [[NSMutableDictionary alloc]init];
    dataList=[[NSMutableArray alloc]init];
    
    isInitData = YES;
    //[self initData];
}

-(void) initData {
    //初始化数据
    if (actionType != ACTION_TYPE_IDLE){
        return;
    }
    actionType = ACTION_TYPE_INITIAL;
    [self asyncLoadData];
}

-(void) refreshData {
    //相应刷新纪录
    if (actionType != ACTION_TYPE_IDLE){
        return;
    }
    actionType = ACTION_TYPE_REFRESH;
    [self asyncLoadData];
}
-(void) getmoreDate {
    //查看更多记录
    if (actionType != ACTION_TYPE_IDLE){
        return;
    }
    [getmorecell ShowLoading];
    actionType = ACTION_TYPE_GETMORE;
    [self asyncLoadData];
}

-(void) asyncLoadData
{
    [parent showLoadingView];
    
}

@end

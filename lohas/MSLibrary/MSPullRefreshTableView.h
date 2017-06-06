//
//  MSPullRefreshTableView.h
//  xyhui
//
//  Created by shen xmload on 13-5-17.
//
//
#define ACTION_TYPE_IDLE 0
#define ACTION_TYPE_INITIAL 1
#define ACTION_TYPE_REFRESH 2
#define ACTION_TYPE_GETMORE 3
#define ACTION_TYPE_PULLREFRESH 4

#import "PullRefreshTableView.h"
#import "GetMoreCell.h"
#import "EmptyDataCell.h"
#import "MSViewController.h"

@interface MSPullRefreshTableView : PullRefreshTableView{
    MSViewController *parent;
    NSMutableArray *dataList;
    NSMutableDictionary *cellList;
    
    int pageSize;
    int pageIndex;
    int actionType;
    
    GetMoreCell *getmorecell;
    
    BOOL loaded;
}

@property (readwrite, nonatomic) BOOL isInitData;

-(void) initial:(MSViewController*)parentViewController;
-(void) initData;
-(void) refreshData;
-(void) getmoreData;
-(void) onPullRefresh;
-(void) asyncLoadData;
-(void) requestSucceeded:(id)result;

@end

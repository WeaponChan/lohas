//
//  TopViewController.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "TopViewController.h"
#import "TSMessage.h"

@interface TopViewController (){
    BOOL isFirstIn;
}

@end

@implementation TopViewController
@synthesize subID,headDic;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    NSString *title=[headDic objectForKeyNotNull:@"title"];
    [self setNavBarTitle:title];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    self.viewHead.hidden=YES;
    
    isFirstIn=YES;
    
  /*  [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_top_info"];
    [api get_top_info:subID location:[AppDelegate sharedAppDelegate].ownLocation];*/
    
    self.mTopViewList.subID=subID;
    self.mTopViewList.headDic=headDic;

    [self.mTopViewList initial:self];
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"get_top_info"]) {
        self.labInfo.text=[response objectForKeyNotNull:@"desc"];
        [self.labInfo sizeToFit];
        int height = self.labInfo.frame.size.height;
        [MSViewFrameUtil setHeight:10+height+10 UI:self.viewHead];
        [self.mTopViewList setTableHeaderView:self.viewHead];
        
        self.viewHead.hidden=NO;
        
        NSArray *lists=[response objectForKeyNotNull:@"lists"];
        self.mTopViewList.lists=lists;
        self.mTopViewList.subID=subID;
        self.mTopViewList.headDic=headDic;
        if (isFirstIn) {
            isFirstIn=NO;
            [self.mTopViewList initial:self];
        }else{
            [self.mTopViewList refreshData];
        }
        
    }
}

-(void)refreshInfo:(NSDictionary*)diction{
    self.labInfo.text=[diction objectForKeyNotNull:@"desc"];
    [self.labInfo sizeToFit];
    int height = self.labInfo.frame.size.height;
    [MSViewFrameUtil setHeight:10+height+10 UI:self.viewHead];
    [self.mTopViewList setTableHeaderView:self.viewHead];
    
    self.viewHead.hidden=NO;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

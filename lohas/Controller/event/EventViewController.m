//
//  EventViewController.m
//  lohas
//
//  Created by juyuan on 15-2-14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "EventViewController.h"
#import "TSMessage.h"

@interface EventViewController (){
    BOOL isFave;
}


@end

@implementation EventViewController
@synthesize eventID,headDic;

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
    [self setNavBarTitle:@"活动详情"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_activity_info"];
    [api get_activity_info:eventID];
    
    [self reloadData];
    
}

-(void)reloadData{
    self.labTitle.text=[headDic objectForKeyNotNull:@"title"];
    [self.labTitle sizeToFit];
    int titleHeight=self.labTitle.frame.size.height;
     
    NSString *create_time=[headDic objectForKeyNotNull:@"create_time"];
    NSString *timeSZong=[self zoneChange1:create_time bit:10];
    NSString *address=[headDic objectForKeyNotNull:@"address"];
    NSString *phone=[headDic objectForKeyNotNull:@"phone"];
    self.labInfo.text=[NSString stringWithFormat:@"日期：%@\n%@\n电话：%@（可拨打）",timeSZong,address,phone];
    [self.labInfo sizeToFit];
    titleHeight=[MSViewFrameUtil setTop:10+titleHeight+10 UI:self.labInfo];
    titleHeight = [MSViewFrameUtil setHeight:titleHeight+10 UI:self.viewSub];
    
    NSString* desc=[headDic objectForKeyNotNull:@"desc"];
    self.labContent.text=desc;
    [self.labContent sizeToFit];
    titleHeight = [MSViewFrameUtil setTop:titleHeight+10 UI:self.labContent];
    [MSViewFrameUtil setHeight:titleHeight+10 UI:self.viewMain];
    [self.scrollView setContentSize:CGSizeMake(320, titleHeight+10)];
    
    //banner
    NSArray *picture_lists=[headDic objectForKeyNotNull:@"picture_lists"];
    //banner
    bannerView = (EventBanner *)[self newViewWithNibNamed:@"EventBanner" owner:self];
    [self.viewBanner addSubview:bannerView];
    [bannerView initial:self];
    [bannerView reload:picture_lists];
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"get_activity_info"]) {
        
        NSString *is_collect=[response objectForKey:@"is_collect"];
        if (is_collect.intValue==0) {
             [self addNavBar_RightBtn:@"navbar_fav.png" action:@selector(actDoFave)];
            isFave=NO;
        }else{
            [self addNavBar_RightBtn:@"navbar_faved.png" action:@selector(actDoFave)];
            isFave=YES;
        }
    }
    else if ([tag isEqual:@"activity_collect"]){
        [TSMessage showNotificationInViewController:self title:[response objectForKeyNotNull:@"message"] subtitle:nil type:TSMessageNotificationTypeSuccess];
    }
}

//收藏
-(void)actDoFave{
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    if (isFave) {
        isFave=NO;
        [self addNavBar_RightBtn:@"navbar_fav.png" action:@selector(actDoFave)];
        Api *api=[[Api alloc]init:self tag:@"activity_collect"];
        [api activity_collect:2 activity_id:[headDic objectForKeyNotNull:@"id"] lat:[headDic objectForKeyNotNull:@"lat"] lng:[headDic objectForKeyNotNull:@"lng"]];
    }else{
        isFave=YES;
        [self addNavBar_RightBtn:@"navbar_faved.png" action:@selector(actDoFave)];
        Api *api=[[Api alloc]init:self tag:@"activity_collect"];
        [api activity_collect:1 activity_id:[headDic objectForKeyNotNull:@"id"] lat:[headDic objectForKeyNotNull:@"lat"] lng:[headDic objectForKeyNotNull:@"lng"]];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}



@end

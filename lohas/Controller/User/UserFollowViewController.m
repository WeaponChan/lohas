//
//  UserFollowViewController.m
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserFollowViewController.h"

@interface UserFollowViewController (){
    NSArray *btnArray;
    
    
}

@end

@implementation UserFollowViewController

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
    [self setNavBarTitle:@"我的收藏"];
    // Do any additional setup after loading the view from its nib.

    
    [self addNavBar_RightBtnWithTitle:@"清空" action:@selector(clickRightButton)];
    
    [self.mUserFollowViewList initial:self];
}

-(void)viewWillAppear:(BOOL)animated{
    if ([AppDelegate sharedAppDelegate].isNeedrefreshCollectList) {
        [AppDelegate sharedAppDelegate].isNeedrefreshCollectList=NO;
        
        [self.mUserFollowViewList refreshData];
    }
}

//清空
-(void)clickRightButton{
    
    UIAlertView *alret=[[UIAlertView alloc]initWithTitle:@"确认清空？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alret.tag=1;
    [alret show];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex == alertView.cancelButtonIndex) {
        return;
    }
    
    else if (alertView.tag==1){
        [self showLoadingView];
        Api *api=[[Api alloc]init:self tag:@"del_all_colelct"];
        [api del_all_colelct];
    }
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
     [self closeLoadingView];
    if ([tag isEqual:@"del_all_colelct"]) {
        [self.mUserFollowViewList refreshData];
    }
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

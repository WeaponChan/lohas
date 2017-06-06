//
//  DynamicZanListViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicZanListViewController.h"
#import "DynamicUserZanCell.h"

@interface DynamicZanListViewController ()

@end

@implementation DynamicZanListViewController
@synthesize said_id,isFans,isFocus,isOtherFocus,user_id,isOtherFans;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    
    
    if (isFans || isOtherFans) {
        [self setNavBarTitle:@"粉丝"];

    }
    else if (isFocus || isOtherFocus){
        [self setNavBarTitle:@"关注"];

    }    
    else{
        [self setNavBarTitle:@"点赞用户"];
    }
    
    self.mDynamicZanList.isOtherFans=isOtherFans;
    self.mDynamicZanList.isOtherFocus=isOtherFocus;
    self.mDynamicZanList.isFocus=isFocus;
    self.mDynamicZanList.isFans=isFans;
    self.mDynamicZanList.said_id=said_id;
    self.mDynamicZanList.user_id=user_id;
    [self.mDynamicZanList initial:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)refreshMessage:(NSString*)user_id type:(NSString*)type{
    Api *api=[[Api alloc]init:self tag:@"attentionAction"];
    [api attentionAction:user_id type:type];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];

     if ([tag isEqual:@"attentionAction"]){
         
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
         
        [self.mDynamicZanList refreshData];
    }
}

@end

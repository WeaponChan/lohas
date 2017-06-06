//
//  UserBlackViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "UserBlackViewController.h"
#import "TSMessage.h"

@interface UserBlackViewController (){
    BOOL isDelete;
}

@end

@implementation UserBlackViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self addNavBar_RightBtnWithTitle:@"解除" action:@selector(actClear)];
    
    [self setNavBarTitle:@"黑名单"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    isDelete=NO;
    self.mUserBlackList.isDelete=isDelete;
    [self.mUserBlackList initial:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//解除
-(void)actClear{
    
    isDelete=!isDelete;
    
    self.mUserBlackList.isDelete=isDelete;
    [self.mUserBlackList refreshData];
    [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo = YES;
}

-(void)deleteBlack:(NSString*)blackID{
    Api *api=[[Api alloc]init:self tag:@"removeBlack"];
    [api removeBlack:blackID];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationWithTitle:message
                                subtitle:nil
                                    type:TSMessageNotificationTypeError];
    
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"removeBlack"]) {
        [self.mUserBlackList refreshData];
    }
}

@end

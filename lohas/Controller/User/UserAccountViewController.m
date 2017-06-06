//
//  UserAccountViewController.m
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserAccountViewController.h"
#import "UserPhoneChangeViewController.h"
#import "UserInfoChangeViewController.h"
#import "UserPwdChangeViewController.h"
#import "WeiboSDK.h"

@interface UserAccountViewController ()

@end

@implementation UserAccountViewController

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
    [self setNavBarTitle:@"账号设置"];
    // Do any additional setup after loading the view from its nib.
    self.btnOutLogin.layer.cornerRadius=4.0;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    self.btnOutLogin.layer.cornerRadius=4;
}

//更换手机
- (IBAction)actChangePhone:(id)sender {
    UserPhoneChangeViewController *viewCtrl=[[UserPhoneChangeViewController alloc]initWithNibName:@"UserPhoneChangeViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//更改账号
- (IBAction)actChangeInfo:(id)sender {
    UserInfoChangeViewController *viewCtrl=[[UserInfoChangeViewController alloc]initWithNibName:@"UserInfoChangeViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];

}

//修改密码
- (IBAction)actChangePassword:(id)sender {
    UserPwdChangeViewController *viewCtrl=[[UserPwdChangeViewController alloc]initWithNibName:@"UserPwdChangeViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//退出账号
- (IBAction)actOutLogin:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"token"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
    
    [self.navigationController popToRootViewControllerAnimated:YES];
}

@end

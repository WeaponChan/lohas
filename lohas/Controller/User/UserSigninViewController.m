//
//  UserSigninViewController.m
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserSigninViewController.h"
#import "UserSignupViewController.h"
#import "UserForgetPSWViewController.h"
#import "Validate.h"
#import "TSMessage.h"

@interface UserSigninViewController ()

@end

@implementation UserSigninViewController

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
    
    [self setNavBarTitle:@"用户登录"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    if ([MSUIUtils getIOSVersion] >= 7.0){
        [self addNavBar_LeftBtn:@"navbar_back" action:@selector(actNavBar_Back:)];
    }else{
        [self addNavBar_LeftBtn:[UIImage imageNamed:@"navbar_back"]
                      Highlight:[UIImage imageNamed:@"navbar_back"]
                         action:@selector(actNavBar_Back:)];
    }
    
    [self.scrollView setContentSize:CGSizeMake(320, 504)];
    
    self.textPhone.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhone"];
    
    self.btnLogin.layer.cornerRadius=4;
    self.btnQQ.layer.cornerRadius=4;
    self.viewLogin.layer.cornerRadius=4;
    self.btnSina.layer.cornerRadius=4;
    
}

-(void)actNavBar_Back:(id)sender
{
    if([self.navigationController.viewControllers objectAtIndex:0] == self){
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actRegister:(id)sender {
    UserSignupViewController *viewCtrl=[[UserSignupViewController alloc]initWithNibName:@"UserSignupViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actForgetPWD:(id)sender {
    UserForgetPSWViewController *viewCtrl=[[UserForgetPSWViewController alloc]initWithNibName:@"UserForgetPSWViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actLogin:(id)sender {
    
    if (![self judgeText]) {
        return;
    }
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"signin"];
    [api signin:self.textPhone.text password:self.textPassWord.text];
    
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
    if ([tag isEqual:@"signin"]) {
        [[NSUserDefaults standardUserDefaults]setObject:[response objectForKeyNotNull:@"token"] forKey:@"token"];
        [[NSUserDefaults standardUserDefaults]setObject:self.textPhone.text forKey:@"loginPhone"];
        [[NSUserDefaults standardUserDefaults]setObject:self.textPassWord.text forKey:@"loginPWD"];
        [[NSUserDefaults standardUserDefaults]setObject:[response objectForKeyNotNull:@"id"] forKey:@"userid"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [AppDelegate sharedAppDelegate].isNeedReloadGuide=YES;
        
        if([self.navigationController.viewControllers objectAtIndex:0] == self){
            [self dismissViewControllerAnimated:true completion:nil];
        }else{
            [self.navigationController popViewControllerAnimated:true];
        }
        
    }
}

//判断输入合法性
-(BOOL)judgeText{
    if (self.textPhone.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入注册手机号"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    else if (self.textPassWord.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入登录密码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    else if (![Validate validateMobile:self.textPhone.text]) {
        [TSMessage showNotificationWithTitle:@"请输入正确的注册手机号码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    else if (![Validate validatePassWord:self.textPassWord.text]) {
        [TSMessage showNotificationWithTitle:@"请输入6-20位登录密码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    
    return YES;
}

@end

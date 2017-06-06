//
//  UserPwdChangeViewController.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserPwdChangeViewController.h"
#import "Validate.h"
#import "TSMessage.h"
#import "IQKeyboardManager.h"

@interface UserPwdChangeViewController ()

@end

@implementation UserPwdChangeViewController

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
    [self setNavBarTitle:@"账号密码修改"];
    
    self.btnCommit.layer.cornerRadius=4.0;
    // Do any additional setup after loading the view from its nib.
    [TSMessage setDefaultViewController:self.navigationController];
 
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actCommit:(id)sender {
    if (![self judgeText]) {
        return;
    }
    
    NSLog(@"ChangeSuccess");
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@""];
    [api update_pwd:self.textPassword.text newpwd:self.textNewPassword.text repwd:self.textEnsure.text];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    
    [TSMessage showNotificationWithTitle:[response objectForKeyNotNull:@"message"]
                                subtitle:nil
                                    type:TSMessageNotificationTypeSuccess];
    
    [self performBlock:^{
        [self.navigationController popViewControllerAnimated:YES];
    }afterDelay:1.0];
    
}

//判断输入合法性
-(BOOL)judgeText{

    if (self.textPassword.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入现用密码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    else if (self.textNewPassword.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入新密码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    else if (![self.textNewPassword.text isEqual:self.textEnsure.text]){
        [TSMessage showNotificationWithTitle:@"新密码与确认密码不同"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;

    }
    else if (![Validate validatePassWord:self.textPassword.text] || ![Validate validatePassWord:self.textNewPassword.text]) {
        [TSMessage showNotificationWithTitle:@"请输入6-20位密码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    
    return YES;
}


@end

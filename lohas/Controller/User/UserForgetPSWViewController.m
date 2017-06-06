//
//  UserForgetPSWViewController.m
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserForgetPSWViewController.h"
#import "Validate.h"
#import "TSMessage.h"
#import "IQKeyboardManager.h"

@interface UserForgetPSWViewController ()

@end

@implementation UserForgetPSWViewController

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
    
    [self setNavBarTitle:@"重设密码"];
    
    self.btnSet.layer.cornerRadius=4;
    // Do any additional setup after loading the view from its nib.
    
    if ([self getIOSDevice]>=8.0) {
        self.labCode.hidden=YES;
        [self.btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
    [TSMessage setDefaultViewController:self.navigationController];

}

//提交
- (IBAction)actResetPWD:(id)sender {
    if (![self judgeText]) {
        return;
    }
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"forget_password"];
    [api forget_password:self.textPhone.text password:self.textNewPassword.text code:self.textCode.text];
    
}

//验证码
- (IBAction)actGetCode:(id)sender {
    if (self.textPhone.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入注册手机号"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return ;
    }
    else if (![Validate validateMobile:self.textPhone.text]) {
        [TSMessage showNotificationWithTitle:@"请输入正确的手机号码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return ;
    }
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"sendcode"];
    [api sendcode:self.textPhone.text type:1];
    
 
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
    if ([tag isEqual:@"sendcode"]) {
        [self.textCode becomeFirstResponder];
        [self startTimer];
        [TSMessage showNotificationWithTitle:[response objectForKeyNotNull:@"message"]
                                    subtitle:nil
                                        type:TSMessageNotificationTypeSuccess];
        
        
    }
    if ([tag isEqual:@"forget_password"]) {
        [TSMessage showNotificationWithTitle:[response objectForKeyNotNull:@"message"]
                                    subtitle:nil
                                        type:TSMessageNotificationTypeSuccess];

        [self performBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }afterDelay:1.0];
        
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
    else if (self.textCode.text.length==0) {
         [TSMessage showNotificationWithTitle:@"请输入验证码"
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

    else if (![Validate validateMobile:self.textPhone.text]) {
        [TSMessage showNotificationWithTitle:@"请输入正确的手机号码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    else if (![Validate validatePassWord:self.textNewPassword.text]) {
        [TSMessage showNotificationWithTitle:@"请输入6-20位密码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    
    return YES;
}

// 开始定时器
- (void) startTimer{
    // 定义一个NSTimer
    time = 60;
    mTimer = [NSTimer scheduledTimerWithTimeInterval:1.0
                                              target:self
                                            selector:@selector(doTimer:)  userInfo:nil
                                             repeats:YES];
}

// 定时器执行的方法
- (void)doTimer:(NSTimer *)timer{
   
    time--;
    if (time > 1) {
        
        NSString *title = [NSString stringWithFormat:@"%d秒",time];
        
        
        if ([self getIOSDevice]>=8.0) {
            [self.btnCode setTitle:title forState:UIControlStateNormal];
        }else{
            self.labCode.text=title;
        }
        //[self.btnCode setTitle:title forState:UIControlStateNormal];
        
        [self.btnCode setEnabled:false];
    }else{
        //[self.btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        
        if ([self getIOSDevice]>=8.0) {
            [self.btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
        }else{
            self.labCode.text=@"获取验证码";
        }
        
        [self.btnCode setEnabled:true];
        [self stopTimer];
    }
}

// 停止定时器
- (void) stopTimer{
    if (mTimer != nil){
        [mTimer invalidate];
    }
}


@end

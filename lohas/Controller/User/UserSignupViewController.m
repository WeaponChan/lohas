//
//  UserSignupViewController.m
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserSignupViewController.h"
#import "Validate.h"
#import "TSMessage.h"
#import "UserSignupPactViewController.h"
#import "IQKeyboardManager.h"

@interface UserSignupViewController ()
{
    BOOL sexFlag;
    BOOL sexFlag2;
    int sex;
}

@end

@implementation UserSignupViewController

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
    sexFlag = NO;
    sexFlag2 = NO;
    sex = 100;
    
    self.textRecommend.text=@"";
    
    if ([self getIOSDevice]>=8.0) {
        self.labCode.hidden=YES;
        [self.btnCode setTitle:@"获取验证码" forState:UIControlStateNormal];
    }
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self setNavBarTitle:@"账号注册"];
    if ([MSUIUtils getIOSVersion] >= 7.0){
        [self addNavBar_LeftBtn:@"navbar_back" action:@selector(actNavBar_Back:)];
    }else{
        [self addNavBar_LeftBtn:[UIImage imageNamed:@"navbar_back"]
                      Highlight:[UIImage imageNamed:@"navbar_back"]
                         action:@selector(actNavBar_Back:)];
    }
    
    self.btnRegister.layer.cornerRadius=4;
    
    [self.scrollView setContentSize:CGSizeMake(320, 504)];
}

-(void)viewWillAppear:(BOOL)animated{
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[AppDelegate sharedAppDelegate] autoKeyBoard];
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

//注册
- (IBAction)actMan:(id)sender {
    if (sexFlag==YES) {
        [self.sexMan setSelected:false];
        sexFlag=NO;
        sex=100;
    }else if(sexFlag==NO){
        [self.sexMan setSelected:true];
        [self.sexWoman setSelected:false];
        sexFlag2=NO;
        sexFlag=YES;
        sex=1;
    }
 
    
}

- (IBAction)actWoman:(id)sender {
    
    if (sexFlag2==YES) {
        [self.sexWoman setSelected:false];
        sexFlag2=NO;
        sex=100;
    }else if(sexFlag2==NO){
        [self.sexWoman setSelected:true];
        [self.sexMan setSelected:false];
        sexFlag=NO;
        sexFlag2=YES;
        sex=2;
    }
}

- (IBAction)actRegister:(id)sender {
    
    if (![self judgeText]) {
        return;
    }
    
    NSString *sex11=[NSString stringWithFormat:@"%d",sex];
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"signup"];
    //[api signup:self.textNickName.text tel:self.textPhone.text password:self.textPassword.text code:self.textCode.text];
    [api signup:self.textNickName.text tel:self.textPhone.text password:self.textPassword.text gender:sex11 code:self.textCode.text];
}

//判断输入合法性
-(BOOL)judgeText{
    if (self.btnAgreeMent.selected) {
        [TSMessage showNotificationWithTitle:@"请先同意注册协议"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }    
    else if (self.textNickName.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入用户名"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
     else if (self.textPhone.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入手机号"
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
    else if (self.textPassword.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入密码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    
    else if (![Validate validateUserName:self.textNickName.text]) {
        [TSMessage showNotificationWithTitle:@"用户名中有特殊字符"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }

    else if (![Validate validatePassWord:self.textPassword.text]) {
        [TSMessage showNotificationWithTitle:@"请输入6-20位密码"
                                    subtitle:nil
                                        type:TSMessageNotificationTypeError];
        return NO;
    }
    
    return YES;
}

- (IBAction)actAgreeMent:(id)sender {
    self.btnAgreeMent.selected=!self.btnAgreeMent.selected;
}

- (IBAction)actReadAgreeMent:(id)sender {
    UserSignupPactViewController *viewCtrl=[[UserSignupPactViewController alloc]initWithNibName:@"UserSignupPactViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//验证码
- (IBAction)actCode:(id)sender {
    if (self.textPhone.text.length==0) {
        [TSMessage showNotificationWithTitle:@"请输入手机号"
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
    [api sendcode:self.textPhone.text type:2];
    
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
        [TSMessage showNotificationWithTitle:[response objectForKeyNotNull:@"message"]
                                    subtitle:nil
                                        type:TSMessageNotificationTypeSuccess];
        [self startTimer];
    }
    if ([tag isEqual:@"signup"]) {
        [[NSUserDefaults standardUserDefaults]setObject:[response objectForKeyNotNull:@"token"] forKey:@"token"];
        [[NSUserDefaults standardUserDefaults]setObject:[response objectForKeyNotNull:@"id"] forKey:@"userid"];
        [[NSUserDefaults standardUserDefaults]setObject:self.textPhone.text forKey:@"loginPhone"];
        [[NSUserDefaults standardUserDefaults]setObject:self.textPassword.text forKey:@"loginPWD"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
         [self dismissViewControllerAnimated:true completion:nil];
    }
    
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

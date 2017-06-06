//
//  UserAbountUSViewController.m
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserAbountUSViewController.h"
#import "TSMessage.h"

@interface UserAbountUSViewController ()

@end

@implementation UserAbountUSViewController

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
    [self setNavBarTitle:@"关于我们"];
    
    self.btnCheck.layer.cornerRadius=4.0;
    [self.btnCheck setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnCheck addBtnAction:@selector(actCheck) target:self];
    
     self.labVersion.text = [NSString stringWithFormat:@"当前版本：v %@", [self getVersion]];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    
    self.scrollView.hidden=YES;
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_about_intro"];
    [api get_about_intro];
}

//检查版本
-(void)actCheck{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"check_version"];
    [api check_version];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"check_version"]) {
        
        NSString *version=[response objectForKeyNotNull:@"version"];
        
        if (![version isEqual:[self getVersion]]) {
            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"检测到新版本" message:@"立即去更新?" delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
            alert.tag=1;
            [alert show];
        }else{
            [TSMessage showNotificationInViewController:self title:@"当前版本已是最新版本" subtitle:nil type:TSMessageNotificationTypeSuccess];
        }
    }
    
    else if ([tag isEqual:@"get_about_intro"]){
        
        self.scrollView.hidden=NO;
        
        self.labAboutInfo.text=[response objectForKeyNotNull:@"content"];
        
        [self.labAboutInfo sizeToFit];
        int height = self.labAboutInfo.frame.size.height;
        [self.scrollView setContentSize:CGSizeMake(320, 150 +height +10)];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex
{
    NSLog(@"alertView ");
    if (buttonIndex == alertView.cancelButtonIndex) {
		return;
    }
    
    if(alertView.tag==1) {
        [self appStore_openApp];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

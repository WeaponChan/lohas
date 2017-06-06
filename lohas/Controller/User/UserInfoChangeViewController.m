//
//  UserInfoChangeViewController.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserInfoChangeViewController.h"
#import "TSMessage.h"

@interface UserInfoChangeViewController (){
    NSString *imageStr;
    int sex;
}

@end

@implementation UserInfoChangeViewController

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
    [self setNavBarTitle:@"账号信息修改"];
    // Do any additional setup after loading the view from its nib.
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    self.btnCommit.layer.cornerRadius=4;
    [self.btnCommit setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnCommit addBtnAction:@selector(actCommit) target:self];
    
    //设置图片变圆
    CALayer *lay = self.imageHead.layer;
    [lay setMasksToBounds:YES];
    [lay setCornerRadius:30.0];
    
    imageStr=@"";
    sex=1;
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_user_info"];
    [api get_user_info];

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actImage:(id)sender {
    [self selectPhotoPicker];
}

-(void)pickerCallback:(UIImage *)img
{
    self.imageHead.image=img;
    [self.btnCommit setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnCommit addBtnAction:@selector(actCommit) target:self];
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"upload"];
    [api update_avatar:self.imageHead.image];
}

//提交
-(void)actCommit{
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"update_info"];
    [api update_info:self.textNickName.text sex:sex sign:self.textSign.text intro:self.labIntro.text];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    
    if ([tag isEqual:@"upload"]) {
        imageStr=[response objectForKeyNotNull:@"photo"];
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
    }
    if ([tag isEqual:@"get_user_info"]) {
        self.textNickName.text=[response objectForKeyNotNull:@"nick"];
        imageStr=[response objectForKeyNotNull:@"avatar"];
        [self.imageHead loadImageAtURLString:imageStr placeholderImage:[UIImage imageNamed:@"default_bg120x120.png"]];
        self.textSign.text=[response objectForKeyNotNull:@"sign"];
        self.labIntro.text=[response objectForKeyNotNull:@"intro"];
        
        NSString *sex11=[response objectForKeyNotNull:@"sex"];
        if (sex11.intValue==1) {
            self.btnMan.selected=YES;
            self.btnWoman.selected=NO;
        }else{
            self.btnWoman.selected=YES;
            self.btnMan.selected=NO;
        }
        
        
    }
    if ([tag isEqual:@"update_info"]) {
            [TSMessage showNotificationInViewController:self title:[response objectForKeyNotNull:@"message"] subtitle:nil type:TSMessageNotificationTypeSuccess];
        [self performBlock:^{
            [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
            [self.navigationController popViewControllerAnimated:YES];
        }afterDelay:1.0];
    }
}

- (IBAction)actMan:(id)sender {
    self.btnMan.selected=YES;
    self.btnWoman.selected=NO;
    sex=1;
}

- (IBAction)actWoman:(id)sender {
    self.btnWoman.selected=YES;
    self.btnMan.selected=NO;
    sex=2;
}
@end

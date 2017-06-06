//
//  UserMyViewController.m
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserMyViewController.h"
#import "UserAccountViewController.h"
#import "UserRecommendViewController.h"
#import "UserFollowViewController.h"
#import "UserShareViewController.h"
#import "UserAbountUSViewController.h"
#import "UserDeclareViewController.h"
#import "UserHelpLisViewController.h"
#import "UserInfoChangeViewController.h"
#import "TSMessage.h"
#import "IQKeyboardManager.h"
#import "CityListViewController.h"

@interface UserMyViewController (){
    NSString *token11;
    NSString *cityID11;
    NSString *cityName11;
    
    NSString *str;
}

@end

@implementation UserMyViewController

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
    [self setNavBarTitle:@"我的"];
    // Do any additional setup after loading the view from its nib.
    
    [self.scrollView addSubview:self.viewMy];
    [self.scrollView setContentSize:CGSizeMake(320, 512)];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    //设置图片变圆
    CALayer *lay = self.imageHead.layer;
    [lay setMasksToBounds:YES];
    [lay setCornerRadius:30.0];
    
    self.viewHead.hidden=YES;
    self.scrollView.hidden=YES;
    
    [self getLocation];
}

-(void)callBackByLocation:(CLLocation *)newLocation{
    
    Api *api=[[Api alloc]init:self tag:@"get_gsp_city"];
    [api get_gsp_city:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] lng:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude]];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    if ([AppDelegate sharedAppDelegate].isNeedrefreshUserInfo) {
        if ([self isLogin]) {
           
            [self showLoadingView];
            Api *api=[[Api alloc]init:self tag:@"get_user_info"];
            [api get_user_info];
        }else{
            self.scrollView.hidden=YES;
            [[AppDelegate sharedAppDelegate] presentToLoginView:self];
        }
    }
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
    if ([tag isEqual:@"get_user_info"]) {
        
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=NO;
        
        self.labName.text=[response objectForKeyNotNull:@"nick"];
        self.labUID.text=[NSString stringWithFormat:@"UID:%@",[response objectForKeyNotNull:@"uid"]];
        
        [self.labName sizeToFit];
        [MSViewFrameUtil setHeight:20 UI:self.labName];
        int width=self.labName.frame.size.width;
        [MSViewFrameUtil setLeft:90+width+2 UI:self.imageSex];
        
        NSString *avatar=[response objectForKeyNotNull:@"avatar"];
        [self.imageHead loadImageAtURLString:avatar placeholderImage:[UIImage imageNamed:@"default_bg120x120.png"]];
        
        NSString *sex=[response objectForKeyNotNull:@"sex"];
        if (sex.intValue==1) {
            [self.imageSex setImage:[UIImage imageNamed:@"boy_n.png"]];
        }else{
            [self.imageSex setImage:[UIImage imageNamed:@"girl_n.png"]];
        }
        
        self.scrollView.hidden=NO;
        self.viewHead.hidden=NO;
    }
    if ([tag isEqual:@"get_gsp_city"]) {
        
        self.labCity.text=[NSString stringWithFormat:@"当前所在城市:%@",[response objectForKeyNotNull:@"name"]];
        
    }
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//账号设置
- (IBAction)actSetting:(id)sender {
    UserAccountViewController *viewCtrl=[[UserAccountViewController alloc]initWithNibName:@"UserAccountViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//我来推荐
- (IBAction)actRecommend:(id)sender {
    UserRecommendViewController *viewCtrl=[[UserRecommendViewController alloc]initWithNibName:@"UserRecommendViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//我的关注
- (IBAction)actAttention:(id)sender {
    UserFollowViewController *viewCtrl=[[UserFollowViewController alloc]initWithNibName:@"UserFollowViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
 
}

//分享账号设置
- (IBAction)actShareSetting:(id)sender {
    UserShareViewController *viewCtrl=[[UserShareViewController alloc]initWithNibName:@"UserShareViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];

}

//关于乐活旅行
- (IBAction)actAboutLeHuo:(id)sender {
    UserAbountUSViewController *viewCtrl=[[UserAbountUSViewController alloc]initWithNibName:@"UserAbountUSViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];

}

//清除缓存
- (IBAction)actClean:(id)sender {
    
    token11=[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    cityID11=[[NSUserDefaults standardUserDefaults]objectForKey:@"cityID"];
    cityName11=[[NSUserDefaults standardUserDefaults]objectForKey:@"cityName"];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"确认清理所有缓存？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag=100;
    [alert show];
}

//遍历文件夹获得文件夹大小，返回多少M
- (float ) folderSizeAtPath:(NSString*) folderPath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if (![manager fileExistsAtPath:folderPath]) return 0;
    NSEnumerator *childFilesEnumerator = [[manager subpathsAtPath:folderPath] objectEnumerator];
    NSString* fileName;
    long long folderSize = 0;
    while ((fileName = [childFilesEnumerator nextObject]) != nil){
        NSString* fileAbsolutePath = [folderPath stringByAppendingPathComponent:fileName];
        folderSize += [self fileSizeAtPath:fileAbsolutePath];
    }
    return folderSize/(1024.0*1024.0);
}

- (long long) fileSizeAtPath:(NSString*) filePath{
    NSFileManager* manager = [NSFileManager defaultManager];
    if ([manager fileExistsAtPath:filePath]){
        return [[manager attributesOfItemAtPath:filePath error:nil] fileSize];
    }
    return 0;
}

//免责申明
- (IBAction)actReponse:(id)sender {
    UserDeclareViewController *viewCtrl=[[UserDeclareViewController alloc]initWithNibName:@"UserDeclareViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//帮助说明
- (IBAction)actHelp:(id)sender {
    UserHelpLisViewController *viewCtrl=[[UserHelpLisViewController alloc]initWithNibName:@"UserHelpLisViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//点击头像
- (IBAction)actUserInfo:(id)sender {
    UserInfoChangeViewController *viewCtrl=[[UserInfoChangeViewController alloc]initWithNibName:@"UserInfoChangeViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];

}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==alertView.cancelButtonIndex) {
        return;
    }
    
    if (alertView.tag==100) {
       /* NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [paths lastObject];
        NSString *str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self folderSizeAtPath:path]];
        NSLog(@"%@",str);
        NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:path];
        for (NSString *p in files) {
            NSError *error;
            NSString *Path = [path stringByAppendingPathComponent:p];
            if ([[NSFileManager defaultManager] fileExistsAtPath:Path]) {
                [[NSFileManager defaultManager] removeItemAtPath:Path error:&error];
            }
        }
        
        [self showAlert:str];*/
        
        NSArray *paths = NSSearchPathForDirectoriesInDomains(NSLibraryDirectory, NSUserDomainMask, YES);
        NSString *path = [paths lastObject];
        str = [NSString stringWithFormat:@"缓存已清除%.1fM", [self folderSizeAtPath:path]];
        
        dispatch_async(
                       
                       dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                       , ^{
                           
                           NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                           
                           NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                           
                           NSLog(@"files :%d",[files count]);
                           
                           for (NSString *p in files) {
                               
                               NSError *error;
                               
                               NSString *path = [cachPath stringByAppendingPathComponent:p];
                               
                               if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                                   
                                   [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                                   
                               }
                               
                           }
                           
                           [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    }
}



-(void)clearCacheSuccess
{
    
    [self showAlert:str];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"isFirstShow"];
    [[NSUserDefaults standardUserDefaults]setObject:token11 forKey:@"token"];
    [[NSUserDefaults standardUserDefaults]setObject:cityID11 forKey:@"cityID"];
    [[NSUserDefaults standardUserDefaults]setObject:cityName11 forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end

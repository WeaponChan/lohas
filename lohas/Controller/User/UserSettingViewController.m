//
//  UserSettingViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/29.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "UserSettingViewController.h"
#import "UserAccountViewController.h"
#import "UserRecommendViewController.h"
#import "UserFollowViewController.h"
#import "UserShareViewController.h"
#import "UserAbountUSViewController.h"
#import "UserDeclareViewController.h"
#import "UserHelpLisViewController.h"
#import "UserBlackViewController.h"
#import "TSMessage.h"

@interface UserSettingViewController (){
    NSString *token11;
    NSString *cityID11;
    NSString *cityName11;
    
    NSString *str;

}

@end

@implementation UserSettingViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"设置"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self getUsetInfo];
}

-(void)getUsetInfo{
    Api *api=[[Api alloc]init:self tag:@"get_user_info"];
    [api get_user_info];
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
        
        NSString *is_open=[response objectForKeyNotNull:@"is_open"];
        if (is_open.intValue==1) {
            self.tripSwitch.on=YES;
        }else{
            self.tripSwitch.on=NO;
        }
        
    }
    
    else if ([tag isEqual:@"isOpen"]){
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actSetting:(id)sender {
    UserAccountViewController *viewCtrl=[[UserAccountViewController alloc]initWithNibName:@"UserAccountViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actAttention:(id)sender {
    UserFollowViewController *viewCtrl=[[UserFollowViewController alloc]initWithNibName:@"UserFollowViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}

- (IBAction)actBlack:(id)sender {
    UserBlackViewController *viewCtrl=[[UserBlackViewController alloc]initWithNibName:@"UserBlackViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actShare:(id)sender {
    UserShareViewController *viewCtrl=[[UserShareViewController alloc]initWithNibName:@"UserShareViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actAbout:(id)sender {
    UserAbountUSViewController *viewCtrl=[[UserAbountUSViewController alloc]initWithNibName:@"UserAbountUSViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actClean:(id)sender {
    token11=[[NSUserDefaults standardUserDefaults]objectForKey:@"token"];
    cityID11=[[NSUserDefaults standardUserDefaults]objectForKey:@"cityID"];
    cityName11=[[NSUserDefaults standardUserDefaults]objectForKey:@"cityName"];
    
    UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"确认清理所有缓存？" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认", nil];
    alert.tag=100;
    [alert show];
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


-(void)clearCacheSuccess
{
    
    [self showAlert:str];
    
    [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"isFirstShow"];
    [[NSUserDefaults standardUserDefaults]setObject:token11 forKey:@"token"];
    [[NSUserDefaults standardUserDefaults]setObject:cityID11 forKey:@"cityID"];
    [[NSUserDefaults standardUserDefaults]setObject:cityName11 forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}


- (IBAction)actOutResponse:(id)sender {
    UserDeclareViewController *viewCtrl=[[UserDeclareViewController alloc]initWithNibName:@"UserDeclareViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actProblem:(id)sender {
    UserHelpLisViewController *viewCtrl=[[UserHelpLisViewController alloc]initWithNibName:@"UserHelpLisViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actSwitch:(id)sender {
    
    if (!self.tripSwitch.on) {
        Api *api=[[Api alloc]init:self tag:@"isOpen"];
        [api isOpen:@"0"];
    }
    else{
        Api *api=[[Api alloc]init:self tag:@"isOpen"];
        [api isOpen:@"1"];
    }

    
}
@end

//
//  AppDelegate.m
//  diecai
//
//  Created by DaVinci Shen on 14-03-30.
//  Copyright (c) 2014年 xundianbao. All rights reserved.
//

#import "AppDelegate.h"
#import "Api.h"
#import "DBConnection.h"
#import "TabHomeViewController.h"
#import "IQKeyboardManager.h"
#import "UserSigninViewController.h"
#import "CityListViewController.h"
#import "MobClick.h"

#import <ShareSDK/ShareSDK.h>
#import "WXApi.h"
//#import <TencentOpenAPI/QQApi.h>
#import <TencentOpenAPI/QQApiInterface.h>
#import <TencentOpenAPI/TencentOAuth.h>
#import <QZoneConnection/ISSQZoneApp.h>
#import "WeiboSDK.h"
#import "NewTabMainViewController.h"

BMKMapManager* _mapManager;
@implementation AppDelegate

- (BOOL)application:(UIApplication *)application didFinishLaunchingWithOptions:(NSDictionary *)launchOptions
{
    
    // 要使用百度地图，请先启动BaiduMapManager
    _mapManager = [[BMKMapManager alloc]init];
    BOOL ret = [_mapManager start:@"OEoGhj9Wcez7OLD3QQO1V1fY" generalDelegate:self];
    
    if (!ret) {
        NSLog(@"manager start failed!");
    }

    self.isFirstIn=YES;
    
    self.isNeedrefreshUserInfo=YES;
    self.isNeedrefreshCollectList=NO;
    self.isNeedReloadGuide=YES;
    
    [NSThread sleepForTimeInterval:1.0];
    
    [self.window addSubview:self.navigation.view];
    [self.window makeKeyAndVisible];
    
    self.window = [[UIWindow alloc] initWithFrame:[[UIScreen mainScreen] bounds]];
    
    [self autoKeyBoard];
    [self initialShare];
    [self openTabHomeCtrl];
    
    [self.window makeKeyAndVisible];
    
    self.selectAddress=@"";
    
    [MobClick startWithAppkey:@"55dbfd1b67e58ede9400785d" reportPolicy:BATCH   channelId:@""];
    NSString *version = [[[NSBundle mainBundle] infoDictionary] objectForKey:@"CFBundleShortVersionString"];
    [MobClick setAppVersion:version];
    
    return YES;
}

- (void) initialShare
{
    [ShareSDK registerApp:@"cdc794040982"];
    
    [ShareSDK ssoEnabled:YES];
    
    [ShareSDK importWeChatClass:[WXApi class]];
    //导入QQ互联和QQ好友分享需要的外部库类型，如果不需要QQ空间SSO和QQ好友分享可以不调用此方法
    [ShareSDK importQQClass:[QQApiInterface class] tencentOAuthCls:[TencentOAuth class]];
    
    //导入人人网需要的外部库类型,如果不需要人人网SSO可以不调用此方法
    //  [ShareSDK importRenRenClass:[RennClient class]];
    
    //添加新浪微博应用
//    [ShareSDK connectSinaWeiboWithAppKey:@"3731643401"
//                               appSecret:@"9dc487c41cc523ab1081c49b5641953c"
//                             redirectUri:@"http://www.lohas-travel.com"];
    
    // 当使用新浪微博客户端分享的时候需要按照下面的方法来初始化新浪的平台
    [ShareSDK  connectSinaWeiboWithAppKey:@"3731643401"
                                appSecret:@"9dc487c41cc523ab1081c49b5641953c"
                              redirectUri:@"http://www.lohas-travel.com"
                              weiboSDKCls:[WeiboSDK class]];
    
    
    //连接短信分享
    /* [ShareSDK connectSMS];
     
     [ShareSDK connectRenRenWithAppId:@"474276"
     appKey:@"c26f3f6270c94ea0aeb94ae9c6f1fe68"
     appSecret:@"06e82b3071534a55b366a79c4646c168"
     renrenClientClass:[RennClient class]];*/
    
    /*[ShareSDK connectQZoneWithAppKey:@"1104785384"
                           appSecret:@"6NL2wnlLoOdSjc3X"
                   qqApiInterfaceCls:[QQApiInterface class]
                     tencentOAuthCls:[TencentOAuth class]];*/
    
    //添加QQ应用  注册网址  http://mobile.qq.com/api/
    /*[ShareSDK connectQQWithQZoneAppKey:@"1104785384"
                     qqApiInterfaceCls:[QQApiInterface class]
                       tencentOAuthCls:[TencentOAuth class]];*/
    
    [ShareSDK connectWeChatWithAppId:@"wxc07d63ee24ed29b0" wechatCls:[WXApi class]];
    
    [ShareSDK connectWeChatWithAppId:@"wxc07d63ee24ed29b0"   //微信APPID
                           appSecret:@"27c669dfccaf2374ffa3c749642f1219"  //微信APPSecret
                           wechatCls:[WXApi class]];
    
    /*//添加腾讯微博应用 注册网址 http://dev.t.qq.com
     [ShareSDK connectTencentWeiboWithAppKey:@"801567049"                                  appSecret:@"2858d29d3fc571a2b6640097c1cc50a2"
     redirectUri:@"http://www.17yueding.com"];*/
    
    
    /*id<ISSQZoneApp> app =(id<ISSQZoneApp>)[ShareSDK getClientWithType:ShareTypeQQSpace];
    [app setIsAllowWebAuthorize:YES];*/
    
}

- (BOOL)application:(UIApplication *)application
      handleOpenURL:(NSURL *)url
{
    return [ShareSDK handleOpenURL:url
                        wxDelegate:self];
}

- (BOOL)application:(UIApplication *)application
            openURL:(NSURL *)url
  sourceApplication:(NSString *)sourceApplication
         annotation:(id)annotation
{
    return [ShareSDK handleOpenURL:url
                 sourceApplication:sourceApplication
                        annotation:annotation
                        wxDelegate:self];
}


- (void)openTabHomeCtrl
{
    /*TabHomeViewController * tabHomeViewController = [[TabHomeViewController alloc] initWithNibName:@"TabHomeViewController" bundle:nil];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:tabHomeViewController];
    self.window.rootViewController = navigationController;*/
    
    self.tabBarController = [[MainTabViewController alloc] init];
    self.window.rootViewController = self.tabBarController;
    [self.window makeKeyAndVisible];
    
   /* NewTabMainViewController * tabHomeViewController = [[NewTabMainViewController alloc] initWithNibName:@"NewTabMainViewController" bundle:nil];
    UINavigationController * navigationController = [[UINavigationController alloc] initWithRootViewController:tabHomeViewController];
    self.window.rootViewController = navigationController;*/

}

- (void)openCityListCtrl
{
    CityListViewController *viewCtrl=[[CityListViewController alloc]initWithNibName:@"CityListViewController" bundle:nil];
    viewCtrl.isRootView = true;
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:viewCtrl];
    self.window.rootViewController = navCtrl;
    [self.window makeKeyAndVisible];
}


//去登录
-(void)presentToLoginView:(MSViewController*)view{
   
    UserSigninViewController *viewCtrl=[[UserSigninViewController alloc]initWithNibName:@"UserSigninViewController" bundle:nil];
    UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:viewCtrl];
    [view presentViewController:navCtrl animated:YES completion:nil];
    
}

+ (AppDelegate *)sharedAppDelegate
{
    return (AppDelegate *) [UIApplication sharedApplication].delegate;
}

//键盘自适应
-(void)autoKeyBoard{
    //Enabling keyboard manager
    [[IQKeyboardManager sharedManager] setEnable:YES];
    
    [[IQKeyboardManager sharedManager] setKeyboardDistanceFromTextField:44];
	//Enabling autoToolbar behaviour. If It is set to NO. You have to manually create UIToolbar for keyboard.
	[[IQKeyboardManager sharedManager] setEnableAutoToolbar:YES];
    
	//Setting toolbar behavious to IQAutoToolbarBySubviews. Set it to IQAutoToolbarByTag to manage previous/next according to UITextField's tag property in increasing order.
	[[IQKeyboardManager sharedManager] setToolbarManageBehaviour:IQAutoToolbarBySubviews];
    
    //Resign textField if touched outside of UITextField/UITextView.
    [[IQKeyboardManager sharedManager] setShouldResignOnTouchOutside:YES];
    
    //Giving permission to modify TextView's frame
    [[IQKeyboardManager sharedManager] setCanAdjustTextView:NO];
}

- (void)applicationWillResignActive:(UIApplication *)application
{
    // Sent when the application is about to move from active to inactive state. This can occur for certain types of temporary interruptions (such as an incoming phone call or SMS message) or when the user quits the application and it begins the transition to the background state.
    // Use this method to pause ongoing tasks, disable timers, and throttle down OpenGL ES frame rates. Games should use this method to pause the game.
}

- (void)applicationDidEnterBackground:(UIApplication *)application
{
    // Use this method to release shared resources, save user data, invalidate timers, and store enough application state information to restore your application to its current state in case it is terminated later.
    // If your application supports background execution, this method is called instead of applicationWillTerminate: when the user quits.
    
    dispatch_async(
                   
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       
                       for (NSString *p in files) {
                           
                           NSError *error;
                           
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                               
                           }
                           
                       }
                       
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});
    
}

- (void)applicationWillEnterForeground:(UIApplication *)application
{
    // Called as part of the transition from the background to the inactive state; here you can undo many of the changes made on entering the background.
}

- (void)applicationDidBecomeActive:(UIApplication *)application
{
    // Restart any tasks that were paused (or not yet started) while the application was inactive. If the application was previously in the background, optionally refresh the user interface.
}

- (void)applicationWillTerminate:(UIApplication *)application
{
    // Called when the application is about to terminate. Save data if appropriate. See also applicationDidEnterBackground:.
    
    /*dispatch_async(
                   
                   dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0)
                   , ^{
                       
                       NSString *cachPath = [NSSearchPathForDirectoriesInDomains(NSCachesDirectory, NSUserDomainMask, YES) objectAtIndex:0];
                       
                       NSArray *files = [[NSFileManager defaultManager] subpathsAtPath:cachPath];
                       
                       for (NSString *p in files) {
                           
                           NSError *error;
                           
                           NSString *path = [cachPath stringByAppendingPathComponent:p];
                           
                           if ([[NSFileManager defaultManager] fileExistsAtPath:path]) {
                               
                               [[NSFileManager defaultManager] removeItemAtPath:path error:&error];
                               
                           }
                           
                       }
                       
                       [self performSelectorOnMainThread:@selector(clearCacheSuccess) withObject:nil waitUntilDone:YES];});*/
}

-(void)clearCacheSuccess{
    
    NSLog(@"clear success");
    
    
}

#pragma mark - City本地存储
//判断城市是否存在
- (BOOL)hasCity
{
    NSString *cityID = [[NSUserDefaults standardUserDefaults]objectForKey:@"cityID"];
    NSString *cityName = [[NSUserDefaults standardUserDefaults]objectForKey:@"cityName"];
    
    if (cityID && cityName) {
        return true;
    }else{
        return false;
    }
}
//获取本地城市名称
- (NSString*)getCityName
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"cityName"];
}
//获取本地城市ID
- (NSString*)getCityID
{
    return [[NSUserDefaults standardUserDefaults]objectForKey:@"cityID"];
}
//本地存储城市信息
- (void)setCityByName:(NSString*)cityName ID:(NSString*)cityID
{
    [[NSUserDefaults standardUserDefaults]setObject:cityID forKey:@"cityID"];
    [[NSUserDefaults standardUserDefaults]setObject:cityName forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults]synchronize];
}

@end

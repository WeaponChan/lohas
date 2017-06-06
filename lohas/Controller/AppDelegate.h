//
//  AppDelegate.h
//  diecai
//
//  Created by DaVinci Shen on 13-12-26.
//  Copyright (c) 2014年 xundianbao. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "SIDownloadManager.h"
#import "HTTPServer.h"
#import <CoreLocation/CoreLocation.h>
#import "BMapKit.h"
#import "MainTabViewController.h"

@class MSViewController;

@interface AppDelegate : UIResponder <UIApplicationDelegate,BMKGeneralDelegate>

@property (strong, nonatomic) UIWindow *window;
@property (nonatomic, retain) UINavigationController *navigation;

@property (strong, nonatomic) MainTabViewController *tabBarController;

@property(copy,nonatomic)CLLocation *ownLocation;

@property BOOL isFirstIn;

+ (AppDelegate *)sharedAppDelegate;

@property BOOL isNeedrefreshUserInfo;
@property BOOL isNeedrefreshCollectList;
@property BOOL isNeedrefshTrip;
@property BOOL isNeedReloadGuide;
@property BOOL isNeedRefreshDynamic;

@property(copy,nonatomic)NSString *selectAddress;

//打开首页
- (void)openTabHomeCtrl;
//去登录
- (void)presentToLoginView:(MSViewController*)view;
//判断城市是否存在
- (BOOL)hasCity;
//获取本地城市名称
- (NSString*)getCityName;
//获取本地城市ID
- (NSString*)getCityID;
//本地存储城市信息
- (void)setCityByName:(NSString*)cityName ID:(NSString*)cityID;
//键盘自适应
-(void)autoKeyBoard;
@end

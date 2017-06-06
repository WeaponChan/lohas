//
//  MSViewController.h
//
//  Created by xmload shen on 12-1-4.
//  Copyright 2012年 __MyCompanyName__. All rights reserved.
//

#import <UIKit/UIKit.h>
#import "AppDelegate.h"
#import "MSNavigationBar.h"
#import "MBProgressHUD.h"
#import "MSUIUtils.h"
#import "MSStringUtil.h"
#import "MSColorUtils.h"
#import "MSViewFrameUtil.h"
#import "MSDictionaryUtil.h"
#import "Api.h"
#import <CoreLocation/CoreLocation.h>

@interface MSViewController : UIViewController<MBProgressHUDDelegate,UIImagePickerControllerDelegate,CLLocationManagerDelegate>
{
    UIView *loadingView;
    UIActivityIndicatorView *indicatorView;
    UILabel *loadingTips;
    UIView *naviTitleView;
    UILabel *labCustomTitle;
    UIColor *labCustomTitleColor;
    
    float latitude, longitude;
    
    MBProgressHUD* HUD;
    UIColor* loadingColor;
    
    BOOL openKeyboardNotification;
    BOOL isKeyboardShowing;
    UIView *viewCloseKeyboard;
    
}

@property(assign, nonatomic) BOOL isModal;
@property(nonatomic, retain) id callbackData;


//经纬度
@property(retain,nonatomic)CLLocationManager *locManager;

//设置标题栏
- (void)setNavBarTitle:(NSString *)title;
- (void)setNavBarImg:(NSString *)imgName;

//设置标题栏按钮
- (void)addNavBar_LeftBtn:(NSString*)imageName action:(SEL)action;
- (void)addNavBar_LeftBtn:(UIImage*)btnImage Highlight:(UIImage*)highlightImage action:(SEL)action;
- (void)addNavBar_LeftBtnWithTitle:(NSString*)title action:(SEL)action;

- (void)addNavBar_RightBtn:(NSString*)imageName action:(SEL)action;
- (void)addNavBar_RightBtn:(UIImage*)btnImage Highlight:(UIImage*)highlightImage action:(SEL)action;
- (void)addNavBar_RightBtnWithTitle:(NSString*)title action:(SEL)action;

//关闭键盘
- (void)openKeyboardNotification;
- (void)setMainViewTapCloseKeyboard:(UIView *)view;
- (void)keyboardWillShowUIToDo:(float)keyboardHeight;//子类重写此函数
- (void)keyboardWillHideUIToDo;//子类重写此函数

//窗体加载进度
- (void)showLoadingView;
- (void)closeLoadingView;

//动态对象加载进度
- (UIActivityIndicatorView *)showLoadingByView:(UIView *)view Indicator:(UIActivityIndicatorView *)indicator;
- (void)CloseLoadingByView:(UIActivityIndicatorView *)indicator;

//对话框
- (void)showAlert:(NSString*)title message:(NSString*)msg tag:(int)tag;
- (void)showOKAlert:(NSString*)title tag:(int)tag;
- (void)showAlert:(NSString*)title;
- (void)showMessage:(NSString*)message;
- (void)showInputAlert:(NSString*)title message:(NSString*)msg tag:(int)tag;

//
-(void)selectVideoPicker:(int)maximumDuration;
- (void)takePhoto;
- (void)LocalPhoto;
//拍照
- (void)selectPhotoPicker;
- (void)pickerCallback:(UIImage *)img;//子类重写此函数

//市场
- (void)appStore_openApp;
- (void)appStore_rateApp;
- (NSString*)getAppleID;
- (NSString*)getVersion;

//消息广播
- (void) postNotification:(NSString*)notification;

-(void)phonecall:(NSString*)tel;
-(void)openWebview:(NSString*)url;

//创建对象
- (id)newViewControllerWithIdentifier:(NSString*)identifier;
- (id)newViewWithNibNamed:(NSString *)name owner:(id)owner;

-(void)showVideoConfirmAlert:(id)delegate title:(NSString*)title;
-(void)callback;



//支付宝
-(void)alipay:(NSString*)data;
-(void)paymentResult:(NSString *)result;;
//延迟调用
- (void)performBlock:(void (^)(void))block afterDelay:(NSTimeInterval)delay;
//问候语
- (NSString*)getWelcomeStrWithTime;
//将时间戳转换成NSDate,加上时区偏移,时间位数（bit＝10：年月日，bit＝19，年月日时间）
-(NSString*)zoneChange1:(NSString*)spString bit:(int)bit;
//比较2个时间的大小
-(BOOL)judgeTwoDate:(NSString*)firstDate secondDate:(NSString*)secondDate;
//uialert
-(void)alert:(NSString*)title message:(NSString*)message cancelName:(NSString*)cancelName titleName:(NSString*)titleName tag:(int)tag;
//获取日期
-(NSString*)getNowDate;
//获取现在时间
-(NSString*)getNowTime;
//获取前一天或后一天 tag 1:后一天 0:前一天
-(NSString*)getLastOrNextDate:(NSString*)date tag:(int)tag;
//获取星期几
-(NSString*)getWeek:(NSString*)date;
//是否登录
-(BOOL)isLogin;
//获取某个日期几天之后的日期
-(NSString*)getNextSomeDay:(NSString*)date index:(int)index;
//获取2个日期间隔天数
-(NSString*)getInterval:(NSString*)sdate edate:(NSString*)edate;
//获取经纬度
-(void)getLocation;
//苹果手机版本ios？
-(float)getIOSDevice;
//去登录
-(void)presentToLoginView:(MSViewController*)view;
//裁剪图片
-(UIImage *) getImageFromURL:(NSString *)fileURL;
- (UIImage *)cutImage:(UIImage*)image imageView:(UIImageView*)imageView;

@end

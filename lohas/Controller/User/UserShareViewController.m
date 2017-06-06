//
//  UserShareViewController.m
//  lohas
//
//  Created by juyuan on 14-12-5.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserShareViewController.h"
#import "ShareSdkUtils.h"
#import <ShareSDK/ShareSDK.h>
#import "WXShareViewController.h"
#import "SinaShareViewController.h"

@interface UserShareViewController (){
    NSString *mainUrl;
    
    NSDictionary *shareDic;
}

@end

@implementation UserShareViewController

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
    [self setNavBarTitle:@"分享"];
    // Do any additional setup after loading the view from its nib.
    
    self.image1.image=[ShareSDK getClientIconWithType:ShareTypeWeixiSession];
     self.image2.image=[ShareSDK getClientIconWithType:ShareTypeWeixiTimeline];
    self.image3.image=[ShareSDK getClientIconWithType:ShareTypeSinaWeibo];
    
    Api *api=[[Api alloc]init:self tag:@"share"];
    [api share];
    
    Api *api2=[[Api alloc]init:self tag:@"shareUrl"];
    [api2 shareUrl];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    if ([tag isEqual:@"share"]) {
        mainUrl=[response objectForKeyNotNull:@"url"];
    }
    else if ([tag isEqual:@"shareUrl"]){
        shareDic=response;
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actShare1:(id)sender {
    
    id<ISSContent> publishContent = nil;
    id<ISSContent> smspublishContent = nil;
    id cimage = nil;
    id delegate=nil;
    
    //cimage = [ShareSDK imageWithUrl:@"http://gonghui.juyuanchuangshi.com/assets/front/images/logo.png"];
    cimage = [UIImage imageNamed:@"76.png"];
    
   // NSString *str=[ShareSdkUtils getShareUrl:SHARE_SITE itemid:nil];
   // NSString *SUrl=@"http://a.app.qq.com/o/simple.jsp?pkgname=com.lohas.app";
    
    NSString *SUrl=[shareDic objectForKeyNotNull:@"download"];
    
    NSString *content=[NSString stringWithFormat:@"%@",SUrl];
    
    //构造分享内容
    publishContent = [ShareSDK content:content
                        defaultContent:content
                                 image:cimage
                                 title:@"乐活旅行"
                                   url:SUrl
                           description:content
                             mediaType:SSPublishContentMediaTypeNews];
    
    NSString* smscontent = [NSString stringWithFormat:@"%@ [乐活旅行]", content];
    
    smspublishContent = [ShareSDK content:smscontent
                           defaultContent:smscontent
                                    image:cimage
                                    title:@"乐活旅行"
                                      url:SUrl
                              description:smscontent
                                mediaType:SSPublishContentMediaTypeText];
    
    //定制微信朋友圈信息
    [publishContent addWeixinTimelineUnitWithType:INHERIT_VALUE
                                          content:INHERIT_VALUE
                                            title:content
                                              url:SUrl
                                            image:INHERIT_VALUE
                                     musicFileUrl:nil
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    //创建容器
    id<ISSContainer> container = [ShareSDK container];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    /*[ShareSDK shareContent:publishContent
                      type:ShareTypeWeixiSession
               authOptions:authOptions
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(@"分享成功");
                            if(delegate) {
                                if ([delegate respondsToSelector:@selector(share_callback:)])
                                {
                                    [delegate performSelector:@selector(share_callback:) withObject:statusInfo];
                                }
                            }
                            
                        } else if (state == SSPublishContentStateFail)
                        {
                            NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                            
                        }
                    }];*/
    
    WXShareViewController *viewCtrl=[[WXShareViewController alloc]initWithNibName:@"WXShareViewController" bundle:nil];
    viewCtrl.content=content;
    viewCtrl.title=@"乐活旅行";
    viewCtrl.url=SUrl;
    viewCtrl.image=nil;
    viewCtrl.shareImage=cimage;
    viewCtrl.textStr=@"全国最靠谱,集自由行、团队旅游产品、资讯及点评的旅行软件，让您“懂旅行、爱旅行”…";
    [self.navigationController pushViewController:viewCtrl animated:YES];

    
}

- (IBAction)actShare2:(id)sender {
    
    id<ISSContent> publishContent = nil;
    id<ISSContent> smspublishContent = nil;
    id cimage = nil;
    id delegate=nil;
    
    //cimage = [ShareSDK imageWithUrl:@"http://gonghui.juyuanchuangshi.com/assets/front/images/logo.png"];
    //cimage = [UIImage imageNamed:@"76.png"];
    
    cimage = [ShareSDK pngImageWithImage:[UIImage imageNamed:@"76.png"]];
    
    //NSString *str=[ShareSdkUtils getShareUrl:SHARE_SITE itemid:nil];
   // NSString *SUrl=@"http://a.app.qq.com/o/simple.jsp?pkgname=com.lohas.app";
    
     NSString *SUrl=[shareDic objectForKeyNotNull:@"download"];
    
    NSString *content=[NSString stringWithFormat:@"%@",SUrl];
    
    //构造分享内容
    publishContent = [ShareSDK content:content
                        defaultContent:content
                                 image:cimage
                                 title:@"乐活旅行"
                                   url:SUrl
                           description:content
                             mediaType:SSPublishContentMediaTypeNews];
    
    NSString* smscontent = [NSString stringWithFormat:@"%@ [乐活旅行]", content];
    
    smspublishContent = [ShareSDK content:smscontent
                           defaultContent:smscontent
                                    image:cimage
                                    title:@"乐活旅行"
                                      url:SUrl
                              description:smscontent
                                mediaType:SSPublishContentMediaTypeText];
    
    //定制微信朋友圈信息
    [publishContent addWeixinTimelineUnitWithType:INHERIT_VALUE
                                          content:INHERIT_VALUE
                                            title:@"全国最靠谱,集自由行、团队旅游产品、资讯及点评的旅行软件，让您“懂旅行、爱旅行”…"
                                              url:SUrl
                                            image:INHERIT_VALUE
                                     musicFileUrl:nil
                                          extInfo:nil
                                         fileData:nil
                                     emoticonData:nil];
    
    //创建容器
    id<ISSContainer> container = [ShareSDK container];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];
    
    [ShareSDK clientShareContent:publishContent
                            type:ShareTypeWeixiTimeline
                   statusBarTips:NO
                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                              
                              if (state == SSPublishContentStateSuccess)
                              {
                                  NSLog(@"分享成功");
                                  if(delegate) {
                                      if ([delegate respondsToSelector:@selector(share_callback:)])
                                      {
                                          [delegate performSelector:@selector(share_callback:) withObject:statusInfo];
                                      }
                                  }
                                  
                              } else if (state == SSPublishContentStateFail)
                              {
                                  NSLog(@"分享失败,错误码:%d,错误描述:%@", [error errorCode], [error errorDescription]);
                              }
                          }];
    
}

- (IBAction)actShare3:(id)sender {
    id<ISSContent> publishContent = nil;
    id<ISSContent> smspublishContent = nil;
    id cimage = nil;
    id delegate=nil;
    
    //cimage = [ShareSDK imageWithUrl:@"http://gonghui.juyuanchuangshi.com/assets/front/images/logo.png"];
    cimage = [UIImage imageNamed:@"76.png"];
    
    //NSString *str=[ShareSdkUtils getShareUrl:SHARE_SITE itemid:nil];
   // NSString *SUrl=@"http://a.app.qq.com/o/simple.jsp?pkgname=com.lohas.app";
    
    NSString *SUrl=[shareDic objectForKeyNotNull:@"download"];
    
    NSString *content=[NSString stringWithFormat:@"%@",SUrl];
    
    SinaShareViewController *viewCtrl=[[SinaShareViewController alloc]initWithNibName:@"SinaShareViewController" bundle:nil];
    viewCtrl.content=content;
    viewCtrl.title=@"乐活旅行";
    viewCtrl.url=SUrl;
    viewCtrl.image=nil;
    viewCtrl.shareImage=cimage;
    viewCtrl.textStr=@"全国最靠谱,集自由行、团队旅游产品、资讯及点评的旅行软件，让您“懂旅行、爱旅行”…";
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

@end

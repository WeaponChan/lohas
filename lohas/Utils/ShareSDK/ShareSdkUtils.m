//
//  ShareSdkUtils.m
//  chuanmei
//
//  Created by mudboy on 14-9-11.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "ShareSdkUtils.h"
#import <ShareSDK/ShareSDK.h>
#import "Api.h"
#import "SinaShareViewController.h"
#import "WXShareViewController.h"

@implementation ShareSdkUtils
@synthesize textStr;

+(NSString*) getShareUrl:(int)type itemid:(NSNumber*)itemid
{
    NSString* str = nil;
    
    NSString* userid = [[NSUserDefaults standardUserDefaults] objectForKey:@"userid"];
    
    if(type==SHARE_GOODS) {
        str = @"goods";
    } else if(type==SHARE_EVENT) {
        str = @"event";
    } else if(type==SHARE_COUPON) {
        str = @"coupon";
    } else if(type==SHARE_ENROLL) {
        str = @"enroll";
    } else if(type==SHARE_SITE) {
        return [NSString stringWithFormat:@""];
    } else if(type==SHARE_LOTTERY) {
        return [NSString stringWithFormat:@""];
    }
    
    if(str) {
        return [NSString stringWithFormat:@""];
    }
    return nil;
}

+(void) share:(NSString*)title url:(NSString*)url content:(NSString*)content image:(NSString*)image delegate:(id)delegate parentView:(MSViewController*)parentView shareImage:(UIImage*)shareImage textStr:(NSString*)textStr
{
    
    NSLog(@"textStr====%@",textStr);
    
    id<ISSContent> publishContent = nil;
    
    id<ISSContent> smspublishContent = nil;
    
    id cimage = nil;
    if(shareImage) {
        cimage = [ShareSDK pngImageWithImage:shareImage];
    } else if(image && image.length>0) {
        cimage = [ShareSDK imageWithUrl:image];
    }
    
    if(cimage) {
        NSLog(@"has image:%@", cimage);
        
        //构造分享内容
        publishContent = [ShareSDK content:content
                            defaultContent:content
                                     image:cimage
                                     title:title
                                       url:url
                               description:content
                                 mediaType:SSPublishContentMediaTypeNews];
        
        NSString* smscontent = [NSString stringWithFormat:@"%@ [乐活旅行]", content];
        
        smspublishContent = [ShareSDK content:smscontent
                            defaultContent:smscontent
                                     image:cimage
                                     title:title
                                       url:url
                               description:smscontent
                                 mediaType:SSPublishContentMediaTypeText];
        
    } else {
        NSLog(@"no image");
        //构造分享内容
        publishContent = [ShareSDK content:content
                            defaultContent:content
                                     image:cimage
                                     title:title
                                       url:url
                               description:content
                                 mediaType:SSPublishContentMediaTypeText];
        
        NSString* smscontent = [NSString stringWithFormat:@"%@ [乐活旅行]", content];
        
        smspublishContent = [ShareSDK content:smscontent
                               defaultContent:smscontent
                                        image:cimage
                                        title:title
                                          url:url
                                  description:smscontent
                                    mediaType:SSPublishContentMediaTypeText];
    }
    

    NSString *str11;
    if (textStr.length>0) {
        str11=textStr;
    }else{
        str11=@"我在乐活旅行上发现了一个不错的东东，你也来看看吧......";
    }
    
    //定制微信朋友圈信息
    [publishContent addWeixinTimelineUnitWithType:INHERIT_VALUE
                                          content:INHERIT_VALUE
                                            title:str11
                                              url:url
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
    
    
    //自定义新浪微博分享菜单项
    id<ISSShareActionSheetItem> sinaItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeSinaWeibo]
                                                                              icon:[ShareSDK getClientIconWithType:ShareTypeSinaWeibo]
                                                                      clickHandler:^{
                                                                          
                                                                          SinaShareViewController *viewCtrl=[[SinaShareViewController alloc]initWithNibName:@"SinaShareViewController" bundle:nil];
                                                                          viewCtrl.content=content;
                                                                          viewCtrl.title=title;
                                                                          viewCtrl.url=url;
                                                                          viewCtrl.image=image;
                                                                          viewCtrl.shareImage=shareImage;
                                                                          viewCtrl.textStr=textStr;
                                                                          [parentView.navigationController pushViewController:viewCtrl animated:YES];
                                                                          
                                                                          
                                                                          
                                                                        /*  [ShareSDK shareContent:publishContent
                                                                                            type:ShareTypeSinaWeibo
                                                                                     authOptions:authOptions
                                                                                   statusBarTips:NO
                                                                                          result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                              
                                                                                              if (state == SSPublishContentStateSuccess)
                                                                                              {
                                                                                                  NSLog(@"分享成功");
                                                                                                  
                                                                                                  [parentView showAlert:@"分享成功"];
                                                                                                  
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
                                                                      }];
    
    id<ISSShareActionSheetItem> wxtItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeWeixiTimeline]
                                                                             icon:[ShareSDK getClientIconWithType:ShareTypeWeixiTimeline]
                                                                     clickHandler:^{
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
                                                                     }];
    
    
  /*  //自定义QQ空间分享菜单项
    id<ISSShareActionSheetItem> qzoneItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeQQSpace]
                                                                               icon:[ShareSDK getClientIconWithType:ShareTypeQQSpace]
                                                                       clickHandler:^{
                                                                           [ShareSDK shareContent:publishContent
                                                                                             type:ShareTypeQQSpace
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
                                                                                           }];
                                                                       }];*/
    
  /*  //自定义QQ好友
    id<ISSShareActionSheetItem> qqfriendItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeQQ]
                                                                               icon:[ShareSDK getClientIconWithType:ShareTypeQQ]
                                                                       clickHandler:^{
                                                                           [ShareSDK shareContent:publishContent
                                                                                             type:ShareTypeQQ
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
                                                                                           }];
                                                                       }];*/
    
  /*
    //自定义人人网分享菜单项
    id<ISSShareActionSheetItem> rrItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeRenren]
                                                                            icon:[ShareSDK getClientIconWithType:ShareTypeRenren]
                                                                    clickHandler:^{
                                                                        [ShareSDK shareContent:publishContent
                                                                                          type:ShareTypeRenren
                                                                                   authOptions:authOptions
                                                                                 statusBarTips:NO
                                                                                        result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                                                                            
                                                                                            if (state == SSPublishContentStateSuccess)
                                                                                            {
                                                                                                NSLog(@"分享成功");
                                                                                                
                                                                                                [parentView showAlert:@"分享成功"];
                                                                                                
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
                                                                    }];*/
    
    
    id<ISSShareActionSheetItem> wxsItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeWeixiSession]
                                                                             icon:[ShareSDK getClientIconWithType:ShareTypeWeixiSession]
                                                                     clickHandler:^{
                                                                         /*[ShareSDK clientShareContent:publishContent
                                                                                                 type:ShareTypeWeixiSession
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
                                                                         viewCtrl.title=title;
                                                                         viewCtrl.url=url;
                                                                         viewCtrl.image=image;
                                                                         viewCtrl.shareImage=shareImage;
                                                                         viewCtrl.textStr=textStr;
                                                                         [parentView.navigationController pushViewController:viewCtrl animated:YES];
                                                                         
                                                                         
                                                                     }];
    
    /*
    //自定义新浪微博分享菜单项(短信)
    id<ISSShareActionSheetItem> smsItem = [ShareSDK shareActionSheetItemWithTitle:[ShareSDK getClientNameWithType:ShareTypeSMS]
                                                                              icon:[ShareSDK getClientIconWithType:ShareTypeSMS]
                                                                      clickHandler:^{
                                                                          [ShareSDK shareContent:smspublishContent
                                                                                            type:ShareTypeSMS
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
                                                                                          }];
                                                                      }];*/
    
    
    NSArray *shareList = nil;
    
    shareList = [ShareSDK customShareListWithType:
                 wxsItem,
                 //qzoneItem,
                 wxtItem,
                 //qqfriendItem,
                 sinaItem,
                // rrItem,
                // smsItem,
                 nil];
    
    [ShareSDK showShareActionSheet:container
                         shareList:shareList
                           content:publishContent
                     statusBarTips:NO
                       authOptions:authOptions
                      shareOptions:[ShareSDK defaultShareOptionsWithTitle:nil
                                                          oneKeyShareList:[NSArray defaultOneKeyShareList]
                                                           qqButtonHidden:NO
                                                    wxSessionButtonHidden:NO
                                                   wxTimelineButtonHidden:NO
                                                     showKeyboardOnAppear:NO
                                                        shareViewDelegate:nil
                                                      friendsViewDelegate:nil
                                                    picViewerViewDelegate:nil]
                            result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                                
                                if (state == SSPublishContentStateSuccess)
                                {
                                    NSLog(@"发表成功");
                                }
                                else if (state == SSPublishContentStateFail)
                                {
                                    NSLog(@"发布失败!error code == %d, error code == %@", [error errorCode], [error errorDescription]);
                                }
                            }];
    
    
}
@end

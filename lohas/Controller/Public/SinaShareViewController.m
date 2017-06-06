//
//  SinaShareViewController.m
//  lohas
//
//  Created by Juyuan123 on 15/12/3.
//  Copyright © 2015年 juyuan. All rights reserved.
//

#import "SinaShareViewController.h"
#import <ShareSDK/ShareSDK.h>
#import "TSMessage.h"
#import "IQKeyboardManager.h"

@interface SinaShareViewController ()<UITextViewDelegate>

@end

@implementation SinaShareViewController
@synthesize title,url,image,shareImage,content,textStr;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"分享到新浪微博"];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [TSMessage setDefaultViewController:self.navigationController];
    
    self.btnShare.layer.cornerRadius=4;
    self.btnShare.layer.masksToBounds=YES;
    [self.btnShare setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2ALPHA];
    [self.btnShare addBtnAction:@selector(actShare) target:self];
    
    if (textStr.length>0) {
        self.textView.text=textStr;
    }else{
        self.textView.text=@"";
        self.textView.text=@"我在乐活旅行上发现了一个不错的东东，你也来看看吧......";
    }
    
}

-(void)viewWillAppear:(BOOL)animated{

    [self.textView resignFirstResponder];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

-(void)textViewDidBeginEditing:(UITextView *)textView{

    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)actShare{
    
    content=[NSString stringWithFormat:@"%@  %@", self.textView.text,content] ;
    
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

    //创建容器
    id<ISSContainer> container = [ShareSDK container];
    
    id<ISSAuthOptions> authOptions = [ShareSDK authOptionsWithAutoAuth:YES
                                                         allowCallback:YES
                                                         authViewStyle:SSAuthViewStyleFullScreenPopup
                                                          viewDelegate:nil
                                               authManagerViewDelegate:nil];

    
    [ShareSDK shareContent:publishContent
                      type:ShareTypeSinaWeibo
               authOptions:authOptions
             statusBarTips:NO
                    result:^(ShareType type, SSResponseState state, id<ISSPlatformShareInfo> statusInfo, id<ICMErrorInfo> error, BOOL end) {
                        
                        if (state == SSPublishContentStateSuccess)
                        {
                            NSLog(@"分享成功");
                            
                            [TSMessage showNotificationInViewController:self title:@"分享成功" subtitle:nil type:TSMessageNotificationTypeSuccess];
                            
                            [self performBlock:^{
                                [self.navigationController popViewControllerAnimated:YES];
                            }afterDelay:1.0];
                            
                            
                        } else if (state == SSPublishContentStateFail)
                        {
                            NSLog(@"分享失败,错误码:%ld,错误描述:%@", (long)[error errorCode], [error errorDescription]);
                            
                              [TSMessage showNotificationInViewController:self title:@"分享失败" subtitle:nil type:TSMessageNotificationTypeError];
                        }
                    }];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actCancel:(id)sender {
    
    [TSMessage showNotificationInViewController:self title:@"取消授权成功" subtitle:nil type:TSMessageNotificationTypeSuccess];
    
    [ShareSDK cancelAuthWithType:ShareTypeSinaWeibo];
}
@end

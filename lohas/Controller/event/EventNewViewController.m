//
//  EventNewViewController.m
//  lohas
//
//  Created by Juyuan123 on 15/5/9.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "EventNewViewController.h"
#import "TSMessage.h"
#import "ReviewViewController.h"
#import "WrongListViewController.h"
#import "ShareSdkUtils.h"

@interface EventNewViewController ()<reviewDelegate>{
    BOOL isBack;
    NSDictionary *comment_numDic;
    NSArray *photoList;
    
    NSDictionary *responseDic;
}

@end

@implementation EventNewViewController
@synthesize eventID,headDic;

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
     [self setNavBarTitle:@"活动详情"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self reloadcomment_num];

}

-(void)reloadcomment_num{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"comment_num"];
    [api comment_num:eventID type:6];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    
    if ([tag isEqual:@"get_activity_info"]) {
        
        responseDic=response;
        
        [self closeLoadingView];
        NSMutableArray *array=[[NSMutableArray alloc]init];
        for (int i=0; i<=3; i++) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"type"];
            [array addObject:dic];
        }
        
        NSArray *comment_lists=[response objectForKeyNotNull:@"comment_lists"];
        int j=4;
        for (NSMutableDictionary *list in comment_lists) {
            [list setObject:[NSString stringWithFormat:@"%d",j] forKey:@"type"];
            [array addObject:list];
            
        }
        
        NSMutableDictionary *dict=[[NSMutableDictionary alloc]init];
        [dict setObject:[NSString stringWithFormat:@"5"] forKey:@"type"];
        [array addObject:dict];
        
        self.mEventViewList.array=array;
        self.mEventViewList.HeadDic=headDic;
        self.mEventViewList.countryInfo=response;
        self.mEventViewList.selectID=eventID;
        
        self.mEventViewList.comment_numDic=comment_numDic;
        if (isBack) {
            [self.mEventViewList refreshData];
        }else{
            self.mEventViewList.isHideMore=YES;
            [self.mEventViewList initial:self];
        }

    }
    
    else if ([tag isEqual:@"comment_num"]){
        
        comment_numDic=response;
        
        Api *api=[[Api alloc]init:self tag:@"get_activity_info"];
        [api get_activity_info:eventID];
    }
    
    else if ([tag isEqual:@"photo_list"]){
        [self closeLoadingView];
        photoList=response;
        
    }
    
    else if ([tag isEqual:@"sibmit_photo"]){
        [self closeLoadingView];
        [TSMessage showNotificationInViewController:self title:@"上传成功,正在审核中" subtitle:nil type:TSMessageNotificationTypeSuccess];
    }
    else if ([tag isEqual:@"apiInfo"]){
        NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhone"];
        
        NSString* title11 = [responseDic objectForKeyNotNull:@"title"];
        NSString* url = [response objectForKeyNotNull:@"url"];
        NSString *SUrl=[NSString stringWithFormat:@"%@?type=6&invite_tel=%@&id=%@",url,phone,[responseDic objectForKeyNotNull:@"id"]];
        
        NSString *content=[NSString stringWithFormat:@"%@ %@",[responseDic objectForKeyNotNull:@"title"],SUrl];
        //NSString *content=@"我在乐活旅行上发现了一个不错的东东，你也来看看吧......";
        
        NSArray *picture_lists=[headDic objectForKeyNotNull:@"picture_lists"];
        NSString *firstPic;
        if (picture_lists.count>0) {
            firstPic=[picture_lists[0] objectForKeyNotNull:@"image"];
        }
        
        if(firstPic.length==0){
            
            MSImageView *img=[[MSImageView alloc]init];
            [img loadImageAtURLString:@"" placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
            
                            [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:img.image textStr:nil];
           
        }else{
            
                                        [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:nil];
            
         /*   UIImage *imageS=[self getImageFromURL:firstPic];
            if (!imageS) {
                imageS=[UIImage imageNamed:@"default_bg180x180.png"];
                
                            [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:imageS textStr:nil];
                
            }
            else{
                            [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:nil];
            }*/

        }
    }
    
}

//点评
- (IBAction)actComment:(id)sender {
    
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    ReviewViewController *viewCtrl=[[ReviewViewController alloc]initWithNibName:@"ReviewViewController" bundle:nil];
    viewCtrl.type=6;
    viewCtrl.subID=[headDic objectForKeyNotNull:@"id"];
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//提交纠错
- (IBAction)actWrong:(id)sender {
    
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    WrongListViewController *viewCtrl=[[WrongListViewController alloc]initWithNibName:@"WrongListViewController" bundle:nil];
    viewCtrl.subID=[headDic objectForKeyNotNull:@"id"];
    viewCtrl.type=6;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//发图
- (IBAction)actPicture:(id)sender {
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    [self selectPhotoPicker];
}

//分享
- (IBAction)actShare:(id)sender {
    
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    Api *api=[[Api alloc]init:self tag:@"apiInfo"];
    [api apiInfo:@"6"];
    
}

-(void)pickerCallback:(UIImage *)img
{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"sibmit_photo"];
    [api sibmit_photo:eventID type:6 avatar:img];
    
}

-(void)reviewBack{
    isBack=YES;
    [self reloadcomment_num];
}

-(void)getMore:(BOOL)isHide{
    if (isHide) {
        self.mEventViewList.isHideMore=NO;
    }else{
        self.mEventViewList.isHideMore=YES;
    }
    
    [self.mEventViewList refreshData];
}

-(void)refresh{
    Api *api=[[Api alloc]init:self tag:@"comment_num"];
    [api comment_num:eventID type:6];
}

@end

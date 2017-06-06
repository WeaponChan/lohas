//
//  HotelViewController.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "HotelViewController.h"
#import "PhotoShowViewController.h"
#import "ReviewViewController.h"
#import "WrongListViewController.h"
#import "TSMessage.h"
#import "ShareSdkUtils.h"

@interface HotelViewController ()<reviewDelegate>{
    NSDictionary *responseItem;
    BOOL isBack;
    NSDictionary *comment_numDic;

}

@end

@implementation HotelViewController
@synthesize hotelID,listItem;

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

    [self setNavBarTitle:@"酒店详情"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    isBack=NO;
    [self reloadcomment_num];
    
}

-(void)reloadcomment_num{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"comment_num"];
    [api comment_num:hotelID type:3];
}

//获取酒店详情
-(void)getHotelInfo{
    
    if (!self.sdate) {
        self.sdate=[self getNowDate];
    }
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_hotel_info"];
    [api get_hotel_info:hotelID];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"get_hotel_info"]) {
        
        responseItem=response;
        
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
        
        self.mHotelViewList.array=array;
        self.mHotelViewList.HeadDic=listItem;
        self.mHotelViewList.countryInfo=response;
        self.mHotelViewList.selectID=hotelID;
        self.mHotelViewList.comment_numDic=comment_numDic;
        if (isBack) {
            [self.mHotelViewList refreshData];
        }else{
            self.mHotelViewList.isHideMore=YES;
            [self.mHotelViewList initial:self];
        }

        
    }
    else if ([tag isEqual:@"comment_num"]){
        
        comment_numDic=response;
        
        [self getHotelInfo];
    }

    else if ([tag isEqual:@"get_wrong_lists"]){
        
        NSLog(@"res==%@",response);
        
    }
    else if ([tag isEqual:@"sibmit_photo"]){
        [TSMessage showNotificationInViewController:self title:@"上传成功,正在审核中" subtitle:nil type:TSMessageNotificationTypeSuccess];
    }
    
    else if ([tag isEqual:@"apiInfo"]){
        NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhone"];
        
        NSString* title11 = [responseItem objectForKeyNotNull:@"title"];
        NSString* url = [response objectForKeyNotNull:@"url"];
        NSString *SUrl=[NSString stringWithFormat:@"%@?type=3&invite_tel=%@&id=%@",url,phone,[responseItem objectForKeyNotNull:@"id"]];
        
        NSString *content=[NSString stringWithFormat:@"%@ %@",title11,SUrl];
        
        /* NSArray *picture_lists=[HeadDic objectForKeyNotNull:@"picture_lists"];
         NSString *firstPic;
         if (picture_lists.count>0) {
         firstPic=[picture_lists[0] objectForKeyNotNull:@"image"];
         }*/
        
        NSString *firstPic=[listItem objectForKeyNotNull:@"image"];
        
        if(firstPic.length==0){
            
            MSImageView *img=[[MSImageView alloc]init];
            [img loadImageAtURLString:@"" placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
            
            [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:img.image textStr:nil];
        }else{
            
                                       [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:nil];
            
           /* UIImage *imageS=[self getImageFromURL:firstPic];
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

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//发图
- (IBAction)actPostPicture:(id)sender {
    
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    [self selectPhotoPicker];
    
}

-(void)pickerCallback:(UIImage *)img
{
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"sibmit_photo"];
    [api sibmit_photo:hotelID type:3 avatar:img];
    
}

//纠错
- (IBAction)actErrorCorrect:(id)sender {
    
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    WrongListViewController *viewCtrl=[[WrongListViewController alloc]initWithNibName:@"WrongListViewController" bundle:nil];
    viewCtrl.subID=[responseItem objectForKeyNotNull:@"id"];
    viewCtrl.type=3;
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}

//点评
- (IBAction)actComment:(id)sender {
    
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    ReviewViewController *viewCtrl=[[ReviewViewController alloc]initWithNibName:@"ReviewViewController" bundle:nil];
    viewCtrl.type=3;
    viewCtrl.delegate=self;
    viewCtrl.subID=[responseItem objectForKeyNotNull:@"id"];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)reviewBack{
    isBack=YES;
    [self reloadcomment_num];
}

//分享
- (IBAction)actShare:(id)sender {
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    Api *api=[[Api alloc]init:self tag:@"apiInfo"];
    [api apiInfo:@"3"];
}

-(void)getMore:(BOOL)isHide{
    if (isHide) {
        self.mHotelViewList.isHideMore=NO;
    }else{
        self.mHotelViewList.isHideMore=YES;
    }
    
    [self.mHotelViewList refreshData];
}

-(void)refresh{
    Api *api=[[Api alloc]init:self tag:@"comment_num"];
    [api comment_num:hotelID type:3];
}

@end

//
//  CountryViewController.m
//  lohas
//
//  Created by juyuan on 14-12-9.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "CountryViewController.h"
#import "TSMessage.h"
#import "ReviewViewController.h"
#import "WrongListViewController.h"
#import "ShareSdkUtils.h"

@interface CountryViewController ()<reviewDelegate>{
    BOOL isBack;
    NSDictionary *comment_numDic;
    NSArray *photoList;
    NSDictionary *responseItem;
}

@end

@implementation CountryViewController
@synthesize countryID,HeadDic;

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
    [self setNavBarTitle:@"乡村游详情"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    isBack=NO;
    
    [self reloadcomment_num];
}

-(void)reloadcomment_num{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"comment_num"];
    [api comment_num:countryID type:1];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    
    if ([tag isEqual:@"get_country_info"]) {
        
        responseItem=response;
        
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
        
        self.mCountryViewList.array=array;
        self.mCountryViewList.HeadDic=HeadDic;
        self.mCountryViewList.countryInfo=response;
        self.mCountryViewList.selectID=countryID;
        
        self.mCountryViewList.comment_numDic=comment_numDic;
        if (isBack) {
            [self.mCountryViewList refreshData];
        }else{
            self.mCountryViewList.isHideMore=YES;
            [self.mCountryViewList initial:self];
        }
 
        
    }
    
    else if ([tag isEqual:@"comment_num"]){
        
        comment_numDic=response;
        
        Api *api=[[Api alloc]init:self tag:@"get_country_info"];
        [api get_country_info:countryID];
    }
    
    else if ([tag isEqual:@"photo_list"]){
        photoList=response;
      [self closeLoadingView];

    }
    
    else if ([tag isEqual:@"sibmit_photo"]){
        [self closeLoadingView];
        [TSMessage showNotificationInViewController:self title:@"上传成功,正在审核中" subtitle:nil type:TSMessageNotificationTypeSuccess];
    }
    
    else if ([tag isEqual:@"apiInfo"]){
        NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhone"];
        
        NSString* title11 = [responseItem objectForKeyNotNull:@"title"];
        NSString* url = [response objectForKeyNotNull:@"url"];
        NSString *SUrl=[NSString stringWithFormat:@"%@?type=1&invite_tel=%@&id=%@",url,phone,[responseItem objectForKeyNotNull:@"id"]];
        
        NSString *content=[NSString stringWithFormat:@"%@ %@",title11,SUrl];
        
        /* NSArray *picture_lists=[HeadDic objectForKeyNotNull:@"picture_lists"];
         NSString *firstPic;
         if (picture_lists.count>0) {
         firstPic=[picture_lists[0] objectForKeyNotNull:@"image"];
         }*/
        
        NSString *firstPic=[HeadDic objectForKeyNotNull:@"image"];
        
        if(firstPic.length==0){
            
            MSImageView *img=[[MSImageView alloc]init];
            [img loadImageAtURLString:@"" placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
            
            [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:img.image textStr:nil];
        }else{
                                       [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:nil];
            
          /*  UIImage *imageS=[self getImageFromURL:firstPic];
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

//点评
- (IBAction)actComment:(id)sender {
    
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    ReviewViewController *viewCtrl=[[ReviewViewController alloc]initWithNibName:@"ReviewViewController" bundle:nil];
    viewCtrl.type=1;
    viewCtrl.subID=[HeadDic objectForKeyNotNull:@"id"];
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
    viewCtrl.subID=[HeadDic objectForKeyNotNull:@"id"];
    viewCtrl.type=1;
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

- (IBAction)actShare:(id)sender {
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    Api *api=[[Api alloc]init:self tag:@"apiInfo"];
    [api apiInfo:@"1"];
}

-(void)pickerCallback:(UIImage *)img
{
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"sibmit_photo"];
    [api sibmit_photo:countryID type:1 avatar:img];
 
}

-(void)reviewBack{
    isBack=YES;
    [self reloadcomment_num];
}

-(void)getMore:(BOOL)isHide{
    
    if (isHide) {
        self.mCountryViewList.isHideMore=NO;
    }else{
        self.mCountryViewList.isHideMore=YES;
    }
    
    [self.mCountryViewList refreshData];
}

-(void)refresh{
    Api *api=[[Api alloc]init:self tag:@"comment_num"];
    [api comment_num:countryID type:1];
}

@end

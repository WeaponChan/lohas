//
//  ShopViewController.m
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "ShopViewController.h"
#import "ReviewViewController.h"
#import "TSMessage.h"
#import "WrongListViewController.h"
#import "ShareSdkUtils.h"

@interface ShopViewController ()<reviewDelegate>{
    BOOL isBack;
    NSArray *wrongList;
    NSDictionary *comment_numDic;
    NSDictionary *responseDic;
}

@end

@implementation ShopViewController
@synthesize responseItem,title;

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
    
    [self setNavBarTitle:@"购物详情"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self reloadcomment_num];
    
    // Do any additional setup after loading the view from its nib.
    isBack=NO;
}

-(void)reloadcomment_num{
    [self showLoadingView];
    
    NSString *shopId=[responseItem objectForKeyNotNull:@"id"];
    if (shopId.length==0) {
        shopId=[responseItem objectForKeyNotNull:@"shop_id"];
    }
    
    Api *api=[[Api alloc]init:self tag:@"comment_num"];
    [api comment_num:shopId type:5];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    
    if ([tag isEqual:@"get_shopping_info"]) {
        
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

        self.mShopViewList.array=array;
        self.mShopViewList.infoItem=response;
        self.mShopViewList.responseItem=responseItem;
        self.mShopViewList.comment_numDic=comment_numDic;
        self.mShopViewList.seID=[responseItem objectForKeyNotNull:@"id"];
        if (isBack) {
            [self.mShopViewList refreshData];
        }else{
            self.mShopViewList.isHideMore=YES;
            [self.mShopViewList initial:self];
        }
        Api *api=[[Api alloc]init:self tag:@"get_wrong_lists"];
        [api get_wrong_lists];
        
    }
    else if ([tag isEqual:@"comment_num"]){
        
        comment_numDic=response;
        
        NSString *shopId=[responseItem objectForKeyNotNull:@"id"];
        if (shopId.length==0) {
            shopId=[responseItem objectForKeyNotNull:@"shop_id"];
        }
        
        Api *api=[[Api alloc]init:self tag:@"get_shopping_info"];
        [api get_shopping_info:shopId];
    }
    else if ([tag isEqual:@"get_wrong_lists"]){
        [self closeLoadingView];
        wrongList=response;
        
    }
    else if ([tag isEqual:@"sibmit_photo"]){
        [self closeLoadingView];
        [TSMessage showNotificationInViewController:self title:@"上传成功,正在审核中" subtitle:nil type:TSMessageNotificationTypeSuccess];
    }
    else if ([tag isEqual:@"apiInfo"]){
        NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhone"];
        
        NSString* title11 = [responseDic objectForKeyNotNull:@"title"];
        NSString* url = [response objectForKeyNotNull:@"url"];
        NSString *SUrl=[NSString stringWithFormat:@"%@?type=5&invite_tel=%@&id=%@",url,phone,[responseDic objectForKeyNotNull:@"id"]];
        
        NSString *content=[NSString stringWithFormat:@"%@ %@",title11,SUrl];
        
        /* NSArray *picture_lists=[HeadDic objectForKeyNotNull:@"picture_lists"];
         NSString *firstPic;
         if (picture_lists.count>0) {
         firstPic=[picture_lists[0] objectForKeyNotNull:@"image"];
         }*/
        
        NSString *firstPic=[responseItem objectForKeyNotNull:@"image"];
        
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
            }else{
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
    viewCtrl.type=5;
    viewCtrl.subID=[responseItem objectForKeyNotNull:@"id"];
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)reviewBack{
    isBack=YES;
    [self reloadcomment_num];
}

//提交纠错
- (IBAction)actCommitWrong:(id)sender {
    
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        return;
    }
    
    WrongListViewController *viewCtrl=[[WrongListViewController alloc]initWithNibName:@"WrongListViewController" bundle:nil];
    viewCtrl.subID=[responseItem objectForKeyNotNull:@"id"];
    viewCtrl.type=5;
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
    [api apiInfo:@"5"];
}

-(void)pickerCallback:(UIImage *)img
{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"sibmit_photo"];
    [api sibmit_photo:[responseItem objectForKeyNotNull:@"id"] type:5 avatar:img];
    
}

-(void)getMore:(BOOL)isHide{
    if (isHide) {
        self.mShopViewList.isHideMore=NO;
    }else{
        self.mShopViewList.isHideMore=YES;
    }
    
    [self.mShopViewList refreshData];
}

-(void)refresh{
    
    NSString *shopId=[responseItem objectForKeyNotNull:@"id"];
    if (shopId.length==0) {
        shopId=[responseItem objectForKeyNotNull:@"shop_id"];
    }
    
    Api *api=[[Api alloc]init:self tag:@"comment_num"];
    [api comment_num:shopId type:5];
}

@end

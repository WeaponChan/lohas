//
//  OtherTripViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "OtherTripViewController.h"
#import "ShareSdkUtils.h"
#import "AddTripViewController.h"
#import "mainAddList.h"
#import "FocusTripDeleteCell.h"

@interface OtherTripViewController (){
    NSDictionary *item;
    NSMutableArray *listArr;
    NSString *tripid ;
    NSString *userid ;
}

@end

@implementation OtherTripViewController
@synthesize tripID,isOther,userID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"行程列表"];
    if(!isOther){
        [self addNavBar_RightBtn:[UIImage imageNamed:@"delete.png"] Highlight:[UIImage imageNamed:@"delete.png"] action:@selector(actDelete)];
        [self addNavBar_RightSecondBtn];
    }
    
    [self.mOtherTripList setTableHeaderView:self.viewHead];
    [self.mOtherTripList setTableFooterView:self.btnView];
    self.btnEdit.layer.cornerRadius = 4.f;
    self.btnEdit.layer.masksToBounds = YES;
    
    
    self.mOtherTripList.isOther=isOther;
    self.mOtherTripList.isDetial=YES;
    self.mOtherTripList.tripID=tripID;
    [self.mOtherTripList initial:self];
    
}

-(void)viewWillAppear:(BOOL)animated{
    
    if ([AppDelegate sharedAppDelegate].isNeedrefshTrip) {
        [AppDelegate sharedAppDelegate].isNeedrefshTrip=NO;
        [self.mOtherTripList refreshData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)requestedSuccess:(NSDictionary*)diction{
    item=diction;
    self.labTitle.text=[diction objectForKeyNotNull:@"title"];
    listArr = (NSMutableArray*)[diction objectForKeyNotNull:@"list"];
    tripid = [diction objectForKeyNotNull:@"id"];
    userid = [diction objectForKeyNotNull:@"user_id"];
    NSString *loginID = [[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    if ([userid isEqual:loginID]) {
        self.btnEdit.hidden = NO;
    }else{
        self.btnEdit.hidden = YES;
    }
    
}

- (IBAction)actEdit:(id)sender {
   AddTripViewController *viewCtrl=[[AddTripViewController alloc]initWithNibName:@"AddTripViewController" bundle:nil];
    
    viewCtrl.isEdit = YES;
    viewCtrl.Title = self.labTitle.text;
    viewCtrl.listarr11 = listArr;
    viewCtrl.tripiD = tripid;

    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}

//收藏
- (void)addNavBar_RightSecondBtn{
    btnFav = [MSButtonToAction buttonWithType:UIButtonTypeCustom];
    btnFav.autoresizingMask = UIViewAutoresizingFlexibleRightMargin | UIViewAutoresizingFlexibleLeftMargin | UIViewAutoresizingFlexibleBottomMargin | UIViewAutoresizingFlexibleTopMargin;
    
    if ([MSUIUtils getIOSVersion] < 7.0){
        btnFav.frame = CGRectMake(186.0, 0.0, 40, 44);
        labCustomTitle.frame = CGRectMake(0, 0, 186.0, 44);
        naviTitleView.frame = CGRectMake(0, 0, 226, 44);
        labCustomTitle.font = [UIFont systemFontOfSize:18.0];
    }else{
        btnFav.frame = CGRectMake(166.0, 0.0, 40, 44);
        labCustomTitle.frame = CGRectMake(0, 0, 156.0, 44);
        labCustomTitle.font = [UIFont systemFontOfSize:18.0];
        naviTitleView.frame = CGRectMake(0, 0, 196, 44);
    }
    
    [btnFav setImage:[UIImage imageNamed:@"nShare.png"] forState:UIControlStateNormal];
    [btnFav setImage:[UIImage imageNamed:@"nShare.png"] forState:UIControlStateHighlighted];
    
    [btnFav setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2ALPHA];
    [btnFav addBtnAction:@selector(actDoFav) target:self];
    
    [naviTitleView addSubview:btnFav];
}

//分享
-(void)actDoFav{
    Api *api=[[Api alloc]init:self tag:@"share"];
    [api share];
}

//删除
-(void)actDelete{
    
    [self showAlert:@"确认删除?" message:nil tag:1];
    
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    
    if(buttonIndex==alertView.cancelButtonIndex){
        return;
    }
    
    if(alertView.tag==1){
        Api *api=[[Api alloc]init:self tag:@"journeyDel"];
        [api journeyDel:tripID];
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo = YES;
    }
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    
    if ([tag isEqual:@"share"]){
        
        NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhone"];
        
        NSString* title11 = [item objectForKeyNotNull:@"title"];
        NSString* url = [response objectForKeyNotNull:@"url"];
        NSString *SUrl=[NSString stringWithFormat:@"%@?type=1&invite_tel=%@&id=%@",url,phone,[item objectForKeyNotNull:@"id"]];
        
        NSString *content=[NSString stringWithFormat:@"%@ %@",title11,SUrl];
        
        /* NSArray *picture_lists=[HeadDic objectForKeyNotNull:@"picture_lists"];
         NSString *firstPic;
         if (picture_lists.count>0) {
         firstPic=[picture_lists[0] objectForKeyNotNull:@"image"];
         }*/
        
        NSString *firstPic;
        NSArray *list=[item objectForKeyNotNull:@"list"];
        if (list.count>0) {
            NSDictionary *dic=list[0];
            firstPic=[dic objectForKeyNotNull:@"image"];
        }
        
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
    else if ([tag isEqual:@"journeyDel"]){
        [AppDelegate sharedAppDelegate].isNeedrefshTrip=YES;
        [self.navigationController popViewControllerAnimated:YES];
        
    }
    
}




@end

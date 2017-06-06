//
//  DynamicDetailViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/24.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicDetailViewController.h"
#import "DyCommentCell.h"
#import "IQKeyboardManager.h"
#import "DynamicUserInfoViewController.h"
#import "DynamicJubaoListViewController.h"
#import "TSMessage.h"
#import "ShareSdkUtils.h"
#import "DynamicZanListViewController.h"
#import "FullyLoaded.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "NewUserViewController.h"
#import "DynamicCommentListViewController.h"

@interface DynamicDetailViewController ()<UIActionSheetDelegate>{
    int page;
    
    int top;
    
    NSDictionary *saidDic;
    NSDictionary *shareDic;
    
}

@end

@implementation DynamicDetailViewController
@synthesize dynamicID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"动态详情"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    self.btnSend.layer.cornerRadius=4;
    self.btnSend.layer.masksToBounds=YES;
    
    self.imageHead.layer.cornerRadius=20;
    self.imageHead.layer.masksToBounds=YES;
     
    Api *api2=[[Api alloc]init:self tag:@"shareUrl"];
    [api2 shareUrl];
    
    self.scrollView.hidden=YES;
    [self getDynamicDetail];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [self openKeyboardNotification];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

//显示软键盘处理函数，子类重写
- (void)keyboardWillShowUIToDo:(float)keyboardHeight{
    NSLog(@"super.keyboardWillShowUIToDo 子类未重写");
    
    CGFloat offset=self.view.frame.size.height-50-keyboardHeight;
    
    [UIView animateWithDuration:1.0 animations:^{
        
        CGRect frame=self.viewBottom.frame;
        frame.origin.y=offset;
        self.viewBottom.frame=frame;
        
    }];
    
}

//关闭软键盘处理函数，子类重写
- (void)keyboardWillHideUIToDo{
    NSLog(@"super.keyboardWillHideUIToDo 子类未重写");
    
    [self.textComment resignFirstResponder];
    self.viewBottom.hidden=YES;
}

-(void)getDynamicDetail{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"saidDetail"];
    [api saidDetail:dynamicID];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"saidDetail"]) {
        
        saidDic=response;
        
        NSString *user_id=[response objectForKeyNotNull:@"user_id"];
        NSString *loginid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        if ([user_id isEqual:loginid]) {
            [self addNavBar_RightBtn:[UIImage imageNamed:@"delete.png"] Highlight:[UIImage imageNamed:@"delete.png"] action:@selector(actDelete)];
            self.btnJubao.hidden=YES;
        }
        
        NSDictionary *uInfo=[response objectForKeyNotNull:@"uInfo"];
        NSString *avatar=[uInfo objectForKeyNotNull:@"avatar"];
        [self.imageHead setContentScaleFactor:[[UIScreen mainScreen] scale]];
        self.imageHead.contentMode =  UIViewContentModeScaleAspectFill;
        self.imageHead.clipsToBounds  = YES;
        [self.imageHead loadImageAtURLString:avatar placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
        self.labName.text=[uInfo objectForKeyNotNull:@"nick"];
        self.labTime.text=[response objectForKeyNotNull:@"created_at"];
        NSString *image=[response objectForKeyNotNull:@"image"];
        
        UIImage *img = [[FullyLoaded sharedFullyLoaded] imageForURL:[NSURL URLWithString:image]];
        
        int width =img.size.width/img.size.height*194;
        if (width>SCREENWIDTH-10) {
            width=SCREENWIDTH-10;
        }
        [MSViewFrameUtil setWidth:width UI:self.imageMain];
        [MSViewFrameUtil setWidth:width UI:self.btnImage];
        
        [self.imageMain loadImageAtURLString:image placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
        self.labInfo.text=[response objectForKeyNotNull:@"content"];
        [self.labInfo sizeToFit];
        int height = self.labInfo.frame.size.height;
        [MSViewFrameUtil setTop:60+height+10 UI:self.imageMain];
        
        NSString *address=[response objectForKeyNotNull:@"address"];
        if (address.length==0) {
            self.labAddress.hidden=YES;
            [MSViewFrameUtil setHeight:60+height+10+194+8+26+8+20+3+20 UI:self.viewMain];
        }else{
            self.labAddress.text=[NSString stringWithFormat:@"地址:%@",address];
            [MSViewFrameUtil setTop:60+height+10+194+3 UI:self.labAddress];
            [MSViewFrameUtil setHeight:60+height+10+194+20+8+26+8+20+3+20 UI:self.viewMain];
        }
        
        NSString *good_num=[response objectForKeyNotNull:@"good_num"];
        self.labZanNum.text=[NSString stringWithFormat:@"%@个赞",good_num];
        NSString *comment_num=[response objectForKeyNotNull:@"comment_num"];
        self.labCommentNum.text=[NSString stringWithFormat:@"所有%@条评论",comment_num];
        
        /*if (good_num.intValue>0) {
            [self.imageSmall setBackgroundImage:[UIImage imageNamed:@"a_40.png"] forState:UIControlStateNormal];
        }else{
            [self.imageSmall setBackgroundImage:[UIImage imageNamed:@"a_401.png"] forState:UIControlStateNormal];
        }  */      
        
        NSNumber *idGood=[response objectForKeyNotNull:@"idGood"];
        if (idGood.intValue==1) {
            [self.btnZan setBackgroundImage:[UIImage imageNamed:@"a_01.png"] forState:UIControlStateNormal];
            [self.imageSmall setBackgroundImage:[UIImage imageNamed:@"a_40.png"] forState:UIControlStateNormal];
            
        }else{
            [self.btnZan setBackgroundImage:[UIImage imageNamed:@"aa_01.png"] forState:UIControlStateNormal];
            [self.imageSmall setBackgroundImage:[UIImage imageNamed:@"a_401.png"] forState:UIControlStateNormal];
        }
        
        page=1;
        top=self.viewMain.frame.size.height;
        
        for (UIView *subView in self.scrollView.subviews) {
            if (subView.tag==1000) {
                [subView removeFromSuperview];
            }
        }
        
        Api *api=[[Api alloc]init:self tag:@"saidCommentList"];
        [api saidCommentList:page limit:10 said_id:dynamicID];
    }
    else if ([tag isEqual:@"saidCommentList"]){
        NSArray *items=[response objectForKeyNotNull:@"items"];
        
        for (NSDictionary *dic in items) {
            NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DyCommentCell" owner:self options: nil];
            DyCommentCell *ViewImage = (DyCommentCell *)[nib objectAtIndex: 0];
            [ViewImage updateInfo:dic];
            [self.scrollView addSubview:ViewImage];
            top = [MSViewFrameUtil setTop:top UI:ViewImage];
        }
        
        [self.scrollView addSubview:self.viewSeeMore];
        
        NSNumber *more=[response objectForKeyNotNull:@"more"];
        if (more.intValue==0) {
            self.viewSeeMore.hidden=YES;
        }else{
            self.viewSeeMore.hidden=NO;
           top = [MSViewFrameUtil setTop:top UI:self.viewSeeMore];
        }
        
        [self.scrollView setContentSize:CGSizeMake(320, top)];
        
        self.scrollView.hidden=NO;
        
        page++;
        
    }
    else if ([tag isEqual:@"saidComment"]){
        
        self.textComment.text=@"";
        
        [self getDynamicDetail];
    }
    else if ([tag isEqual:@"submitBlack"]){
        [TSMessage showNotificationInViewController:self title:@"成功拉入黑名单" subtitle:nil type:TSMessageNotificationTypeSuccess];
    }
    else if ([tag isEqual:@"goodAction"]){
        [self getDynamicDetail];
    }
    else if ([tag isEqual:@"delMySaid"]){
        [AppDelegate sharedAppDelegate].isNeedRefreshDynamic=YES;
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
        [self.navigationController popViewControllerAnimated:YES];
    }
    else if ([tag isEqual:@"shareUrl"]){
        shareDic=response;
    }
    else if ([tag isEqual:@"share"]){
        
        NSString *phone=[[NSUserDefaults standardUserDefaults]objectForKey:@"loginPhone"];
        
        NSString* title11 = [saidDic objectForKeyNotNull:@"content"];
        NSString* url = [response objectForKeyNotNull:@"url"];
       // NSString *SUrl=[NSString stringWithFormat:@"%@?type=1&invite_tel=%@&id=%@",url,phone,[saidDic objectForKeyNotNull:@"id"]];
        
       // NSString *SUrl=@"http://a.app.qq.com/o/simple.jsp?pkgname=com.lohas.app";
        NSString *SUrl=[shareDic objectForKeyNotNull:@"download"];
        
        NSString *content=[NSString stringWithFormat:@"%@ %@",title11,SUrl];
        
        /* NSArray *picture_lists=[HeadDic objectForKeyNotNull:@"picture_lists"];
         NSString *firstPic;
         if (picture_lists.count>0) {
         firstPic=[picture_lists[0] objectForKeyNotNull:@"image"];
         }*/
        
        NSString *firstPic=[saidDic objectForKeyNotNull:@"image"];
        
        if(firstPic.length==0){
            
            MSImageView *img=[[MSImageView alloc]init];
            [img loadImageAtURLString:@"" placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
            
            [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:img.image textStr:@"快乐需要分享，您的旅行好友给您点赞、评论和分享，还不知道？那就赶快来试试吧…"];
        }else{
            
                                        [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:@"快乐需要分享，您的旅行好友给您点赞、评论和分享，还不知道？那就赶快来试试吧…"];
            
         /*   UIImage *imageS=[self getImageFromURL:firstPic];
            if (!imageS) {
                imageS=[UIImage imageNamed:@"default_bg180x180.png"];
                            [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:imageS textStr:@"快乐需要分享，您的旅行好友给您点赞、评论和分享，还不知道？那就赶快来试试吧…"];
            }else{
                            [ShareSdkUtils share:title11 url:SUrl content:content image:firstPic delegate:nil parentView:self shareImage:nil textStr:@"快乐需要分享，您的旅行好友给您点赞、评论和分享，还不知道？那就赶快来试试吧…"];
            }*/
            
        }
        
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//
-(void)actDelete{    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"delMySaid"];
    [api delMySaid:dynamicID];
}

- (IBAction)actSeeMore:(id)sender {
    Api *api=[[Api alloc]init:self tag:@"saidCommentList"];
    [api saidCommentList:page limit:10 said_id:dynamicID];
}

- (IBAction)actWriteComment:(id)sender {
    self.viewBottom.hidden=NO;
    [self.textComment becomeFirstResponder];
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >=50) {
        return NO;
    }
    return YES;
}

- (IBAction)actSendComment:(id)sender {
    
    [self.textComment resignFirstResponder];
    self.viewBottom.hidden=YES;
    if (self.textComment.text.length == 0) {
        [self showAlert:@"评论不能为空"];
        [self.textComment resignFirstResponder];
    }else{
        Api *api=[[Api alloc]init:self tag:@"saidComment"];
        [api saidComment:self.textComment.text said_id:dynamicID];
    }
}

- (IBAction)beginEdit:(id)sender {
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

- (IBAction)actClickHead:(id)sender {
    
    NSString *loginid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSString *userID = [saidDic objectForKeyNotNull:@"user_id"];
    
    if ([userID isEqual:loginid]) {
        NewUserViewController *viewCtrl=[[NewUserViewController alloc]initWithNibName:@"NewUserViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed=YES;
        viewCtrl.isOtherIn=YES;
        [self.navigationController pushViewController:viewCtrl animated:YES];
       
        
    }else{
    DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
    viewCtrl.user_id=[saidDic objectForKeyNotNull:@"user_id"];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
    }
}

- (IBAction)actJubao:(id)sender {
    UIActionSheet *sheet=[[UIActionSheet alloc]initWithTitle:nil delegate:self cancelButtonTitle:@"取消" destructiveButtonTitle:@"拉入黑名单" otherButtonTitles:@"举报", nil];
    [sheet showInView:self.view];
}

- (void) actionSheet:(UIActionSheet *)actionSheet clickedButtonAtIndex:(NSInteger)buttonIndex{
    
    //举报
    if (buttonIndex==1) {
        DynamicJubaoListViewController *viewCtrl=[[DynamicJubaoListViewController alloc]initWithNibName:@"DynamicJubaoListViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed=YES;
        viewCtrl.typeID=dynamicID;
        viewCtrl.type=@"1";
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    else if (buttonIndex==0){
        Api *api=[[Api alloc]init:self tag:@"submitBlack"];
        [api submitBlack:[saidDic objectForKeyNotNull:@"user_id"]];
    }
}

- (IBAction)actZan:(id)sender {
    
    NSNumber *idGood=[saidDic objectForKeyNotNull:@"idGood"];
    if (idGood.intValue==1) {
        Api *api=[[Api alloc]init:self tag:@"goodAction"];
        [api goodAction:dynamicID type:@"2"];
    }else{
        Api *api=[[Api alloc]init:self tag:@"goodAction"];
        [api goodAction:dynamicID type:@"1"];
    }
    
    
}

- (IBAction)actShare:(id)sender {
    Api *api=[[Api alloc]init:self tag:@"share"];
    [api share];
}

- (IBAction)actZanpeo:(id)sender {
    
    DynamicZanListViewController *viewCtrl=[[DynamicZanListViewController alloc]initWithNibName:@"DynamicZanListViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    viewCtrl.said_id=[saidDic objectForKeyNotNull:@"id"];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actImage:(id)sender {
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    
    // 替换为中等尺寸图片
    
    NSString * getImageStrUrl = [NSString stringWithFormat:@"%@",[saidDic objectForKeyNotNull:@"image"]];
    MJPhoto *photo = [[MJPhoto alloc] init];
    photo.url = [NSURL URLWithString: getImageStrUrl ]; // 图片路径
    photo.srcImageView = self.imageMain;
    [photos addObject:photo];
    
    // 2.显示相册
    NSString *index=@"0";
    MJPhotoBrowser *browser = [[MJPhotoBrowser alloc] init];
    browser.currentPhotoIndex = index.intValue ; // 弹出相册时显示的第一张图片是？
    browser.photos = photos; // 设置所有的图片
    [browser show];
    
}

- (IBAction)actClickComment:(id)sender {
    DynamicCommentListViewController *ViewCtrl=[[DynamicCommentListViewController alloc]initWithNibName:@"DynamicCommentListViewController" bundle:nil];
    ViewCtrl.hidesBottomBarWhenPushed=YES;
    ViewCtrl.said_id=[saidDic objectForKeyNotNull:@"id"];
    [self.navigationController pushViewController:ViewCtrl animated:YES];
    
}
@end

//
//  DyMessageCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/25.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DyMessageCell.h"
#import "DynamicViewController.h"
#import "DynamicCommentListViewController.h"
#import "DynamicZanListViewController.h"
#import "DynamicUserInfoViewController.h"
#import "DynamicDetailViewController.h"
#import "NewUserViewController.h"


@implementation DyMessageCell{
    NSNumber *isAttention;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.imageHead.layer.cornerRadius=20;
    self.imageHead.layer.masksToBounds=YES;
    
    self.labTitle.text=[item objectForKeyNotNull:@"nick"];
    self.labInfo.text=[item objectForKeyNotNull:@"message"];
    
    NSString *avatar=[item objectForKeyNotNull:@"avatar"];
    [self.imageHead loadImageAtURLString:avatar placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
    NSString *picture=[item objectForKeyNotNull:@"picture"];
    if (picture.length>0) {
        [self.imageDynamic loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
    }else{        
        self.imageDynamic.hidden=YES;
    }

    self.btnAttention.layer.cornerRadius=4;
    self.btnAttention.layer.masksToBounds=YES;
    NSString *type=[item objectForKeyNotNull:@"type"];
    if (type.intValue==5) {
        self.btnDyDetail.hidden = YES;
        isAttention=[item objectForKeyNotNull:@"isAttention"];
        if (isAttention.intValue==0) {

        }else{
            [self.btnAttention setTitle:@"取消关注" forState:UIControlStateNormal];
            [self.btnAttention setBackgroundColor:[UIColor grayColor]];
            
        }
    }else{
        self.btnDyDetail.hidden = NO;
        self.btnAttention.hidden=YES;
    }
    
    NSString *t_user_id=[item objectForKeyNotNull:@"t_user_id"];
    NSString *f_user_id=[item objectForKeyNotNull:@"f_user_id"];
    if ([t_user_id isEqual:f_user_id]) {
        self.btnAttention.hidden=YES;
    }
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 60;
}

- (IBAction)actAttention:(id)sender {
    
    if ([parent isKindOfClass:[DynamicViewController class]]) {
        DynamicViewController *viewCtrl=(DynamicViewController*)parent;
        if (isAttention.intValue==0) {
            [viewCtrl refreshMessage:[item objectForKeyNotNull:@"f_user_id"] type:@"1"];
        }else{
            [viewCtrl refreshMessage:[item objectForKeyNotNull:@"f_user_id"] type:@"2"];
        }        
    }
    
}

- (IBAction)actClick:(id)sender {
    
     NSString *type=[item objectForKeyNotNull:@"type"];
    //评论通知
    if (type.intValue==1) {
        DynamicCommentListViewController *ViewCtrl=[[DynamicCommentListViewController alloc]initWithNibName:@"DynamicCommentListViewController" bundle:nil];
        ViewCtrl.hidesBottomBarWhenPushed=YES;
        ViewCtrl.said_id=[item objectForKeyNotNull:@"said_id"];
        [parent.navigationController pushViewController:ViewCtrl animated:YES];
    }
    //新关注通知
    else if (type.intValue==5){
        
    }
    //点赞通知
    else if (type.intValue==2){
        DynamicZanListViewController *viewCtrl=[[DynamicZanListViewController alloc]initWithNibName:@"DynamicZanListViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed=YES;
        viewCtrl.said_id=[item objectForKeyNotNull:@"said_id"];
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
}

- (IBAction)actClickHead:(id)sender {
   
    /*
    DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
    viewCtrl.user_id=[item objectForKeyNotNull:@"f_user_id"];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
     */
    NSString *loginid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSString *userID = [item objectForKeyNotNull:@"f_user_id"];
    
    if ([userID isEqual:loginid]) {
        
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
        
        NewUserViewController *viewCtrl=[[NewUserViewController alloc]initWithNibName:@"NewUserViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed=YES;
        viewCtrl.isOtherIn=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
        [viewCtrl showLoadingView];
        
    }else{
        
        DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
        viewCtrl.user_id=[item objectForKeyNotNull:@"f_user_id"];
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
        
    }
    
}

- (IBAction)actDyDetail:(id)sender {
    DynamicDetailViewController *viewCtrl = [[DynamicDetailViewController alloc] initWithNibName:@"DynamicDetailViewController" bundle:nil];
    viewCtrl.dynamicID = [item objectForKeyNotNull:@"said_id"];
    viewCtrl.hidesBottomBarWhenPushed  = YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
}
@end

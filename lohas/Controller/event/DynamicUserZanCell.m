//
//  DynamicUserZanCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicUserZanCell.h"
#import "DynamicZanListViewController.h"
#import "NewUserViewController.h"

#import "DynamicUserInfoViewController.h"
@implementation DynamicUserZanCell{
    NSNumber *isAttention;
    NSString *userID;
}
@synthesize isFocus,isFans;

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.imageHead.layer.cornerRadius=20;
    self.imageHead.layer.masksToBounds=YES;
    self.btnAttention.layer.cornerRadius=4;
    self.btnAttention.layer.masksToBounds=YES;
    
    NSString *avatar=[item objectForKeyNotNull:@"avatar"];
    [self.imageHead loadImageAtURLString:avatar placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
    
    self.labName.text=[item objectForKeyNotNull:@"nick"];
    self.labInfo.text=[item objectForKeyNotNull:@"sign"];
    
    isAttention=[item objectForKeyNotNull:@"isAttention"];
    if (isAttention.intValue==0) {
        
    }else{
        [self.btnAttention setTitle:@"取消关注" forState:UIControlStateNormal];
        [self.btnAttention setBackgroundColor:[UIColor grayColor]];
        
    }
    
    if (isFans || isFocus) {
        self.btnAttention.hidden=NO;
    }else{
        
        NSString *Sid=[item objectForKeyNotNull:@"id"];
        NSString *userId=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
        if (![Sid isEqual:userId]) {
            self.btnAttention.hidden=NO;
        }else{
            self.btnAttention.hidden=YES;
            [MSViewFrameUtil setWidth:254 UI:self.labInfo];
        }
        
    }
    
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 60;
}

- (IBAction)actAttention:(id)sender {
    
  
    
    if ([parent isKindOfClass:[DynamicZanListViewController class]]) {
        if (isFans) {
            NSString *f_user_id=[item objectForKeyNotNull:@"f_user_id"];
            if (f_user_id.length==0) {
                f_user_id=[item objectForKeyNotNull:@"id"];
            }
            
            DynamicZanListViewController *viewCtrl=(DynamicZanListViewController*)parent;
            if (isAttention.intValue==0) {
                [viewCtrl refreshMessage:f_user_id type:@"1"];
            }else{
                [viewCtrl refreshMessage:f_user_id type:@"2"];
                
            }

        }
        
        else{
            NSString *t_user_id=[item objectForKeyNotNull:@"t_user_id"];
            if (t_user_id.length==0) {
                t_user_id=[item objectForKeyNotNull:@"id"];
            }
        
            DynamicZanListViewController *viewCtrl=(DynamicZanListViewController*)parent;
            if (isAttention.intValue==0) {
                [viewCtrl refreshMessage:t_user_id type:@"1"];
            }
            else{
                [viewCtrl refreshMessage:t_user_id type:@"2"];
            
            }
         
        }
        
    }
    
    
}

- (IBAction)actClickHead:(id)sender {
    
    NSString *loginid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    userID = [item objectForKeyNotNull:@"t_user_id"];
    if (userID.length==0) {
        userID=[item objectForKeyNotNull:@"id"];
    }
    
    if ([userID isEqual:loginid]) {
        
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
        
        NewUserViewController *viewCtrl=[[NewUserViewController alloc]initWithNibName:@"NewUserViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed=YES;
        viewCtrl.isOtherIn=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
        [viewCtrl showLoadingView];
        
    }else{
        
        if (isFans) {
            NSString *f_user_id=[item objectForKeyNotNull:@"f_user_id"];
            if (f_user_id.length==0) {
                f_user_id=[item objectForKeyNotNull:@"id"];
            }
            
            DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
            viewCtrl.user_id=f_user_id;
            viewCtrl.hidesBottomBarWhenPushed=YES;
            [parent.navigationController pushViewController:viewCtrl animated:YES];
        }
        else{
            NSString *t_user_id=[item objectForKeyNotNull:@"t_user_id"];
            if (t_user_id.length==0) {
                t_user_id=[item objectForKeyNotNull:@"id"];
            }
            
            DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
            viewCtrl.user_id=t_user_id;
            viewCtrl.hidesBottomBarWhenPushed=YES;
            [parent.navigationController pushViewController:viewCtrl animated:YES];
        }
        
    }
    
    /*
    if (isFans) {
        NSString *f_user_id=[item objectForKeyNotNull:@"f_user_id"];
        if (f_user_id.length==0) {
            f_user_id=[item objectForKeyNotNull:@"id"];
        }
        
        DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
        viewCtrl.user_id=f_user_id;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else{
        NSString *t_user_id=[item objectForKeyNotNull:@"t_user_id"];
        if (t_user_id.length==0) {
            t_user_id=[item objectForKeyNotNull:@"id"];
        }
    
        DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
        viewCtrl.user_id=t_user_id;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
     */
}

@end

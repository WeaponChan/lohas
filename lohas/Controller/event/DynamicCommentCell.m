//
//  DynamicCommentCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/26.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicCommentCell.h"
#import "DynamicUserInfoViewController.h"
#import "NewUserViewController.h"

@implementation DynamicCommentCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.imageHead.layer.cornerRadius=20;
    self.imageHead.layer.masksToBounds=YES;
    
    self.labName.text=[item objectForKeyNotNull:@"nick"];
    self.labInfo.text=[item objectForKeyNotNull:@"content"];
    self.labTime.text=[item objectForKeyNotNull:@"created_at"];
    
    NSString *avatar=[item objectForKeyNotNull:@"avatar"];
    [self.imageHead loadImageAtURLString:avatar placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
    
    [MSViewFrameUtil setWidth:SCREENWIDTH-90 UI:self.labInfo];
    [self.labInfo sizeToFit];
    int height = self.labInfo.frame.size.height;
    [MSViewFrameUtil setHeight:37+height+10 UI:self.viewMain];

}

+ (int)Height:(NSDictionary *)itemData{
    NSString* content=[itemData objectForKeyNotNull:@"content"];
    int height = [MSViewFrameUtil getLabHeight:content FontSize:12 Width:SCREENWIDTH-90];
    
    return 37+height+11;
}

- (IBAction)actClickHead:(id)sender {
    /*
    DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
    viewCtrl.user_id=[item objectForKeyNotNull:@"user_id"];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
     */
    
    NSString *loginid=[[NSUserDefaults standardUserDefaults]objectForKey:@"userid"];
    NSString *userID = [item objectForKeyNotNull:@"user_id"];
    
    if ([userID isEqual:loginid]) {
        
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
        
        NewUserViewController *viewCtrl=[[NewUserViewController alloc]initWithNibName:@"NewUserViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed=YES;
        viewCtrl.isOtherIn=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
        [viewCtrl showLoadingView];
        
    }else{
        
        DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
        viewCtrl.user_id=[item objectForKeyNotNull:@"user_id"];
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
        
    }
}
@end

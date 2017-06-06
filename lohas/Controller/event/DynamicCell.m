//
//  DynamicCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicCell.h"
#import "DyCommentCell.h"
#import "DynamicViewController.h"
#import "DynamicDetailViewController.h"
#import "DynamicUserInfoViewController.h"
#import "DynamicCommentListViewController.h"
#import "DynamicZanListViewController.h"
#import "FullyLoaded.h"
#import "MJPhoto.h"
#import "MJPhotoBrowser.h"
#import "NewUserViewController.h"

@implementation DynamicCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    
    [super update:itemData Parent:parentCtrl];
    
    self.imageHead.layer.cornerRadius=20;
    self.imageHead.layer.masksToBounds=YES;
    
    NSString *avatar=[item objectForKeyNotNull:@"avatar"];
    
    [self.imageHead setContentScaleFactor:[[UIScreen mainScreen] scale]];
    self.imageHead.contentMode =  UIViewContentModeScaleAspectFill;
    self.imageHead.clipsToBounds  = YES;
    [self.imageHead loadImageAtURLString:avatar placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
    self.labName.text=[item objectForKeyNotNull:@"nick"];
    self.labTime.text=[item objectForKeyNotNull:@"created_at"];
    NSString *image=[item objectForKeyNotNull:@"picture"];
    

    UIImage *img = [[FullyLoaded sharedFullyLoaded] imageForURL:[NSURL URLWithString:image]];
    
    int width =img.size.width/img.size.height*194;
    if (width>SCREENWIDTH-10) {
        width=SCREENWIDTH-10;
    }
    [MSViewFrameUtil setWidth:width UI:self.imageMain];
    [MSViewFrameUtil setWidth:width UI:self.btnImage];

    [self.imageMain loadImageAtURLString:image placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
    
    self.labInfo.text=[item objectForKeyNotNull:@"content"];
    [MSViewFrameUtil setWidth:SCREENWIDTH-20 UI:self.labInfo];
    [self.labInfo sizeToFit];
    
    int height = self.labInfo.frame.size.height;
    height = [MSViewFrameUtil setTop:58+height+10 UI:self.imageMain];
    NSString *address=[item objectForKeyNotNull:@"address"];
    if (address.length==0) {
        self.labAddress.hidden=YES;
    }else{
        self.labAddress.text=[NSString stringWithFormat:@"地址:%@",address];
        height=[MSViewFrameUtil setTop:height+3 UI:self.labAddress];
    }
    
    height = [MSViewFrameUtil setTop:7+height UI:self.viewSub];
    
    NSString *good_num=[item objectForKeyNotNull:@"good_num"];
    self.labZanNum.text=[NSString stringWithFormat:@"%@个赞",good_num];
    NSString *comment_num=[item objectForKeyNotNull:@"comment_num"];
    self.labCommentNum.text=[NSString stringWithFormat:@"所有%@条评论",comment_num];
    
    /*if (good_num.intValue>0) {
        [self.imageSmall setBackgroundImage:[UIImage imageNamed:@"a_40.png"] forState:UIControlStateNormal];
    }else{
        [self.imageSmall setBackgroundImage:[UIImage imageNamed:@"a_401.png"] forState:UIControlStateNormal];
    }*/
    
    NSArray *commentList=[item objectForKeyNotNull:@"commentList"];
    for (NSDictionary *dic in commentList) {
        NSArray *nib = [[NSBundle mainBundle] loadNibNamed:@"DyCommentCell" owner:self options: nil];
        DyCommentCell *ViewImage = (DyCommentCell *)[nib objectAtIndex: 0];
        [ViewImage updateInfo:dic];
        [self.viewMain addSubview:ViewImage];
        height = [MSViewFrameUtil setTop:height UI:ViewImage];
    }
    
    NSNumber *idGood=[item objectForKeyNotNull:@"idGood"];
    if (idGood.intValue==1) {
        [self.btnZan setBackgroundImage:[UIImage imageNamed:@"a_01.png"] forState:UIControlStateNormal];
        [self.imageSmall setBackgroundImage:[UIImage imageNamed:@"a_40.png"] forState:UIControlStateNormal];
        
    }else{
        [self.btnZan setBackgroundImage:[UIImage imageNamed:@"aa_01.png"] forState:UIControlStateNormal];
        [self.imageSmall setBackgroundImage:[UIImage imageNamed:@"a_401.png"] forState:UIControlStateNormal];
    }
    
    [MSViewFrameUtil setHeight:height UI:self.viewMain];
    
}

+ (int)Height:(NSDictionary *)itemData{
    
    NSString *content = [itemData objectForKeyNotNull:@"content"];
    int height = [MSViewFrameUtil getLabHeight:content FontSize:14 Width:SCREENWIDTH-20];
    height=58+height+10+194+10+82;
    NSArray *commentList=[itemData objectForKeyNotNull:@"commentList"];
    
    int commentHeight=0;
    
    for (NSDictionary *dic in commentList) {
        NSString *info=[dic objectForKeyNotNull:@"content"];
        
        UILabel *label=[[UILabel alloc]initWithFrame:CGRectMake(0, 0, SCREENWIDTH-20, 20)];
        [label setFont:[UIFont systemFontOfSize:12]];
        label.text=[NSString stringWithFormat:@"%@:",[dic objectForKeyNotNull:@"nick"]];
        [label sizeToFit];
        int width = label.frame.size.width;
        
       commentHeight =commentHeight + 10 + [MSViewFrameUtil getLabHeight:info FontSize:12 Width:SCREENWIDTH-(10+width+5+10)];
        
    }
    
    NSString *address=[itemData objectForKeyNotNull:@"address"];
    if (address.length==0) {
        return height+commentHeight+10;
    }else{
        return height+commentHeight+10+20;
    }
    
    
}

- (IBAction)actComment:(id)sender {
    if ([parent isKindOfClass:[DynamicViewController class]]) {
        DynamicViewController *viewCtr=(DynamicViewController*)parent;
        [viewCtr sendComment:[item objectForKeyNotNull:@"id"]];
    }
    
}

-(BOOL)textField:(UITextField *)textField shouldChangeCharactersInRange:(NSRange)range replacementString:(NSString *)string{
    if (range.location >=50) {
        return NO;
    }
    return YES;
}

- (IBAction)actJubao:(id)sender {
    
    if ([parent isKindOfClass:[DynamicViewController class]]) {
        DynamicViewController *viewCtr=(DynamicViewController*)parent;
        [viewCtr juBao:[item objectForKeyNotNull:@"id"] userid:[item objectForKey:@"user_id"]];
    }
}

- (IBAction)actZan:(id)sender {
    NSNumber *idGood=[item objectForKeyNotNull:@"idGood"];
    if (idGood.intValue==1) {
        if ([parent isKindOfClass:[DynamicViewController class]]) {
            DynamicViewController *viewCtr=(DynamicViewController*)parent;
            [viewCtr actZan:[item objectForKeyNotNull:@"id"] type:@"2"];
        }
    }else{
        
        if ([parent isKindOfClass:[DynamicViewController class]]) {
            DynamicViewController *viewCtr=(DynamicViewController*)parent;
            [viewCtr actZan:[item objectForKeyNotNull:@"id"] type:@"1"];
        }
    }
    
}

- (IBAction)actZanpeo:(id)sender {
    
    DynamicZanListViewController *viewCtrl=[[DynamicZanListViewController alloc]initWithNibName:@"DynamicZanListViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    viewCtrl.said_id=[item objectForKeyNotNull:@"id"];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actShare:(id)sender {
    if ([parent isKindOfClass:[DynamicViewController class]]) {
        DynamicViewController *viewCtr=(DynamicViewController*)parent;
        [viewCtr actShare:[item objectForKeyNotNull:@"id"] saidItem:item];
    }
}

- (IBAction)actClick:(id)sender {
    DynamicDetailViewController *viewCtrl=[[DynamicDetailViewController alloc]initWithNibName:@"DynamicDetailViewController" bundle:nil];
    viewCtrl.dynamicID=[item objectForKeyNotNull:@"id"];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actClickHead:(id)sender {
    
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

- (IBAction)actClickComment:(id)sender {
    DynamicCommentListViewController *ViewCtrl=[[DynamicCommentListViewController alloc]initWithNibName:@"DynamicCommentListViewController" bundle:nil];
    ViewCtrl.hidesBottomBarWhenPushed=YES;
    ViewCtrl.said_id=[item objectForKeyNotNull:@"id"];
    [parent.navigationController pushViewController:ViewCtrl animated:YES];
}

- (IBAction)actClickImage:(id)sender {
    
    NSMutableArray *photos = [NSMutableArray arrayWithCapacity:1];
    
    // 替换为中等尺寸图片
    
    NSString * getImageStrUrl = [NSString stringWithFormat:@"%@",[item objectForKeyNotNull:@"picture"]];
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

@end

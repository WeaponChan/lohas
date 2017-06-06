//
//  HotelTitleCell.m
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//



#import "HotelTitleCell.h"
#import "HotelBookingListViewController.h"
#import "TSMessage.h"
#import "PhotoShowViewController.h"
#import "WapViewController.h"

@implementation HotelTitleCell
@synthesize responseItem,ListItem;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{

    [super update:itemData Parent:parentCtrl];
    
    
    bannerView = (EventBanner *)[parent newViewWithNibNamed:@"EventBanner" owner:self];
    [self.viewBanner addSubview:bannerView];
    [bannerView initial:parent];
    
    NSString *book_url=[responseItem objectForKeyNotNull:@"book_url"];
    if (book_url.length==0 || [book_url isEqual:@"无"]) {
        self.btnOrder.hidden=YES;
    }
    
    self.btnOrder.layer.cornerRadius=4;
    [self.btnOrder setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnOrder addBtnAction:@selector(actOrder) target:self];
    
    self.labTitle.text=[responseItem objectForKeyNotNull:@"title"];
   // [self.labTitle sizeToFit];
   // int height=self.labTitle.frame.size.height;
   
    self.labCommentNum.text=[NSString stringWithFormat:@"%@点评",[responseItem objectForKeyNotNull:@"comment_count"]];
    
    NSString *price=[responseItem objectForKeyNotNull:@"price"];
    self.labPrice.text=[NSString stringWithFormat:@"%.2f",price.floatValue];
    [self.labPrice sizeToFit];
    int width=self.labPrice.frame.size.width;
    [MSViewFrameUtil setLeft:20+width+2 UI:self.labTag];
    
    NSArray *piclist=[responseItem objectForKeyNotNull:@"pics"];
    NSMutableArray *list=[[NSMutableArray alloc]init];
    if (piclist.count>0) {
        int j=0;
        for (NSString *str in piclist) {
            NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
            [dic setObject:str forKey:@"image"];
            [dic setObject:[NSString stringWithFormat:@"%d",j] forKey:@"index"];
            [list addObject:dic];
            j++;
        }
    }else{
        NSString *image=[responseItem objectForKeyNotNull:@"image"];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:image forKey:@"image"];
        [dic setObject:@"0" forKey:@"index"];
        [list addObject:dic];
    }

    [bannerView reload:list];
    
   // [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg640x320.png"]];
    
    NSString *distance=[ListItem objectForKeyNotNull:@"distance"];
    if (distance.doubleValue<0 || !distance) {
        self.labDistance.hidden=YES;
    }else{
        self.labDistance.text=[NSString stringWithFormat:@"%.1fkm",distance.doubleValue];
        if (distance.intValue>500) {
            self.labDistance.text=@">500km";
        }
    }
    
    //收藏
    NSString *is_collect=[responseItem objectForKeyNotNull:@"is_collect"];
    if (is_collect.intValue==0) {
        self.btnFave.selected=NO;
    }else{
        self.btnFave.selected=YES;
    }
    
    //星星评分
    NSArray *imageStarList=[[NSArray alloc]initWithObjects:self.imageStar1,self.imageStar2,self.imageStar3,self.imageStar4,self.imageStar5, nil];
    NSString *comment_avg=[responseItem objectForKeyNotNull:@"comment_avg"];
    int pointInt=comment_avg.intValue;
    int i=0;
    for (UIImageView *imageS in imageStarList) {
        if (i<pointInt) {
            [imageS setImage:[UIImage imageNamed:@"widget_valume_star_o.png"]];
        }
        else{
            [imageS setImage:[UIImage imageNamed:@"widget_valume_star_n.png"]];
        }
        i++;
    }
    if (comment_avg.doubleValue>pointInt) {
        UIImageView *imageE=[imageStarList objectAtIndex:pointInt];
        [imageE setImage:[UIImage imageNamed:@"widget_valume_star_0.5.png"]];
    }
    
}

//立即预订
-(void)actOrder{
    
    if (![parent isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:parent];
        return;
    }
    
    WapViewController *viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.linkStr=[responseItem objectForKeyNotNull:@"book_url"];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
   /* HotelBookingListViewController *viewCtrl=[[HotelBookingListViewController alloc]initWithNibName:@"HotelBookingListViewController" bundle:nil];
    viewCtrl.responseItem=responseItem;
    viewCtrl.ListItem=ListItem;
    viewCtrl.edate=self.edate;
    viewCtrl.sdate=self.sdate;
    [parent.navigationController pushViewController:viewCtrl animated:YES];*/
}

+ (int)Height:(NSDictionary *)itemData{
    return 292;
}

//收藏
- (IBAction)actFave:(id)sender {
    
    if (![parent isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:parent];
        return;
    }
    
    [parent showLoadingView];
    if (self.btnFave.selected) {
        Api *api=[[Api alloc]init:self tag:@"del_collect"];
        [api del_collect:[responseItem objectForKeyNotNull:@"id"] type:3];
    }else{
        Api *api=[[Api alloc]init:self tag:@"collect"];
        [api collect:[responseItem objectForKeyNotNull:@"id"] type:3 lat:[responseItem objectForKeyNotNull:@"lat"] lng:[responseItem objectForKeyNotNull:@"lng"]];
    }
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [parent closeLoadingView];
    [TSMessage showNotificationInViewController:parent title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [parent closeLoadingView];
    if ([tag isEqual:@"collect"]) {
        [TSMessage showNotificationInViewController:parent title:[response objectForKeyNotNull:@"message"] subtitle:nil type:TSMessageNotificationTypeSuccess];
        self.btnFave.selected=YES;
    }else if ([tag isEqual:@"del_collect"]){
        [TSMessage showNotificationInViewController:parent title:[response objectForKeyNotNull:@"message"] subtitle:nil type:TSMessageNotificationTypeSuccess];
        self.btnFave.selected=NO;
    }
}

//相册
- (IBAction)actGetPhoto:(id)sender {
    PhotoShowViewController *viewCtrl=[[PhotoShowViewController alloc]initWithNibName:@"PhotoShowViewController" bundle:nil];
    viewCtrl.type=3;
    viewCtrl.caID=[responseItem objectForKeyNotNull:@"id"];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

@end

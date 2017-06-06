//
//  CountryTitleCell.m
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "CountryTitleCell.h"
#import "TSMessage.h"
#import "PhotoShowViewController.h"
#import "WapViewController.h"

@implementation CountryTitleCell{
    int type;
}
@synthesize countryInfo,headDic,photoList,categoryStr;

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
    
    if ([categoryStr isEqual:@"food"]) {
        type=4;
        self.labInfoText.text=@"餐厅信息";
        self.labPriceTitle.text=@"价格：¥";
        
    }else{
        type=1;
    }
    
    bannerView = (EventBanner *)[parent newViewWithNibNamed:@"EventBanner" owner:self];
    [self.viewBanner addSubview:bannerView];
    [bannerView initial:parent];
    
    NSString *book_url=[countryInfo objectForKeyNotNull:@"book_url"];
    if (book_url.length==0 || [book_url isEqual:@"无"]) {
        self.btnBooking.hidden=YES;
    }
    
    self.btnBooking.layer.cornerRadius=4.0;
    [self.btnBooking setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnBooking addBtnAction:@selector(actBooking) target:self];
    
    self.labTitle.text=[countryInfo objectForKeyNotNull:@"title"];
    
    NSArray *piclist=[countryInfo objectForKeyNotNull:@"pics"];
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
        NSString *image=[countryInfo objectForKeyNotNull:@"image"];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:image forKey:@"image"];
        [dic setObject:@"0" forKey:@"index"];
        [list addObject:dic];
    }
    [bannerView reload:list];
    
    //[self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg640x320.png"]];
    
    NSString *comment_count=[countryInfo objectForKeyNotNull:@"comment_count"];
    self.labComment.text=[NSString stringWithFormat:@"%@点评",comment_count];
    
    NSString *distance=[headDic objectForKeyNotNull:@"distance"];
    self.labDistance.text=[NSString stringWithFormat:@"%.1fkm",distance.doubleValue];
    if (distance.intValue<0 || !distance) {
        self.labDistance.hidden=YES;
    }
    if (distance.intValue>500) {
        self.labDistance.text=@">500km";
    }
    
    //收藏
    NSString *is_collect=[countryInfo objectForKeyNotNull:@"is_collect"];
    if (is_collect.intValue==0) {
        self.btnFav.selected=NO;
    }else{
        self.btnFav.selected=YES;
    }
    
    //价钱
    self.labPrice.text=[countryInfo objectForKeyNotNull:@"price"];
    [self.labPrice sizeToFit];
    [MSViewFrameUtil setHeight:30 UI:self.labPrice];
    int width=self.labPrice.frame.size.width;
    [MSViewFrameUtil setLeft:width+60 UI:self.labPriceTail];
    
    //星星评分
    NSArray *imageStarList=[[NSArray alloc]initWithObjects:self.imageStar1,self.imageStar2,self.imageStar3,self.imageStar4,self.imageStar5, nil];
    NSString *comment_avg=[countryInfo objectForKeyNotNull:@"comment_avg"];
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

+ (int)Height:(NSDictionary *)itemData{
    return 292;
}

//预订
-(void)actBooking{
    
    if (![parent isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:parent];
        return;
    }
    
    WapViewController *viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.linkStr=[countryInfo objectForKeyNotNull:@"book_url"];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
    /* SceneryBookingListViewController *viewCtrl=[[SceneryBookingListViewController alloc]initWithNibName:@"SceneryBookingListViewController" bundle:nil];
     [parent.navigationController pushViewController:viewCtrl animated:YES];*/
    
}

//收藏
- (IBAction)actFav:(id)sender {
    
    if (![parent isLogin]) {
        [[AppDelegate sharedAppDelegate]presentToLoginView:parent];
        return;
    }
    
      [parent showLoadingView];
    if (self.btnFav.selected) {
        Api *api=[[Api alloc]init:self tag:@"del_collect"];
        [api del_collect:[countryInfo objectForKeyNotNull:@"id"] type:type];
    }else{
        Api *api=[[Api alloc]init:self tag:@"collect"];
        [api collect:[countryInfo objectForKeyNotNull:@"id"] type:type lat:[countryInfo objectForKeyNotNull:@"lat"] lng:[countryInfo objectForKeyNotNull:@"lng"]];
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
        self.btnFav.selected=YES;
        
        [AppDelegate sharedAppDelegate].isNeedrefreshCollectList=YES;
        
    }else if ([tag isEqual:@"del_collect"]){
        [TSMessage showNotificationInViewController:parent title:[response objectForKeyNotNull:@"message"] subtitle:nil type:TSMessageNotificationTypeSuccess];
        self.btnFav.selected=NO;
        
        [AppDelegate sharedAppDelegate].isNeedrefreshCollectList=YES;
        
    }
}

//相册
- (IBAction)actGetPhoto:(id)sender {
    PhotoShowViewController *viewCtrl=[[PhotoShowViewController alloc]initWithNibName:@"PhotoShowViewController" bundle:nil];
    viewCtrl.type=type;
    viewCtrl.caID=[countryInfo objectForKeyNotNull:@"id"];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}



@end

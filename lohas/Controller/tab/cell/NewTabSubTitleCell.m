//
//  NewTabSubTitleCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "NewTabSubTitleCell.h"
#import "CountryViewController.h"
#import "SceneryViewController.h"
#import "FoodViewController.h"
#import "ShopViewController.h"
#import "EventViewController.h"
#import "HotelViewController.h"
#import "DiscoverDetailViewController.h"
#import "DestinationViewController.h"

@implementation NewTabSubTitleCell
@synthesize category_id,isDiscover;

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    if ([parent isKindOfClass:[DiscoverDetailViewController class]]) {
        
        [self setBackgroundColor:[UIColor whiteColor]];
        self.viewBottomLine.hidden=YES;
    }
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    //self.labSubTitle.text=[item objectForKeyNotNull:@"desc"];
    
    NSString *picture=[item objectForKeyNotNull:@"image"];
    [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
    
    NSString *price=[item objectForKeyNotNull:@"price"];
    self.labPrice.text=[NSString stringWithFormat:@"%.2f",price.floatValue];
    [self.labPrice sizeToFit];
    int width=self.labPrice.frame.size.width;
    [MSViewFrameUtil setLeft:118+width+2 UI:self.labPeople];
    
    UIImage *img1 = [UIImage imageNamed:@"ding.png"];
    // UIImage *img2 = [UIImage imageNamed:@"2.png"];
    NSString *book_url = [item objectForKeyNotNull:@"book_url"];
    
    if (book_url.length==0 || [book_url isEqual:@"无"]) {
        NSLog(@"book_url为空");
        
    }else{
        //        [self.labTitle sizeToFit];
        //        [MSViewFrameUtil setWidth:148 UI:self.labTitle];
        self.infoImage.image = img1;
    }
    
    
    NSString *comment_count=[item objectForKeyNotNull:@"comment_num"];
    self.labComment.text=[NSString stringWithFormat:@"%@点评",comment_count];
    
    NSString *distance=[item objectForKeyNotNull:@"distance"];
    self.labDistance.text=[NSString stringWithFormat:@"%.1fkm",distance.doubleValue];
    if (distance.intValue>500) {
        self.labDistance.text=@">500km";
    }else if (distance.intValue<0){
        self.labDistance.hidden=YES;
    }
    
    NSArray *imageStarList=[[NSArray alloc]initWithObjects:self.imageStar1,self.imageStar2,self.imageStar3,self.imageStar4,self.imageStar5, nil];
    NSString *comment_avg=[item objectForKeyNotNull:@"comment_avg"];
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
    
    NSArray *category_list=[item objectForKeyNotNull:@"category_list"];
    NSString *cateStr=@"";
    for (NSDictionary *dic in category_list) {
        NSString *title=[dic objectForKeyNotNull:@"title"];
        
        if (cateStr.length==0) {
            cateStr=title;
        }else{
            cateStr=[NSString stringWithFormat:@"%@ %@",cateStr,title];
        }
        
    }
    
    self.labSubTitle.text=cateStr;
    
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 110;
}

- (IBAction)actClick:(id)sender {
    
    NSString *shopCategory=[item objectForKeyNotNull:@"shopCategory"];
    if (shopCategory.length==0) {
        shopCategory=category_id;
    }
    
    if (shopCategory.intValue==1) {
        CountryViewController *viewCtrl=[[CountryViewController alloc]initWithNibName:@"CountryViewController" bundle:nil];
        viewCtrl.countryID=[item objectForKeyNotNull:@"id"];
        viewCtrl.HeadDic=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    if (shopCategory.intValue==2) {
        SceneryViewController *viewCtrl=[[SceneryViewController alloc]initWithNibName:@"SceneryViewController" bundle:nil];
        viewCtrl.countryID=[item objectForKeyNotNull:@"id"];
        viewCtrl.HeadDic=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(shopCategory.intValue==3){
        HotelViewController *viewCtrl=[[HotelViewController alloc]initWithNibName:@"HotelViewController" bundle:nil];
        viewCtrl.hotelID=[item objectForKeyNotNull:@"id"];
        viewCtrl.listItem=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(shopCategory.intValue==4){
        FoodViewController *viewCtrl=[[FoodViewController alloc]initWithNibName:@"FoodViewController" bundle:nil];
        viewCtrl.countryID=[item objectForKeyNotNull:@"id"];
        viewCtrl.HeadDic=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(shopCategory.intValue==5){
        ShopViewController *viewCtrl=[[ShopViewController alloc]initWithNibName:@"ShopViewController" bundle:nil];
        viewCtrl.responseItem=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(shopCategory.intValue==6){
        EventViewController *viewCtrl=[[EventViewController alloc]initWithNibName:@"EventViewController" bundle:nil];
        viewCtrl.eventID=[item objectForKeyNotNull:@"id"];
        viewCtrl.headDic=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    //目的地
    else if (shopCategory.intValue==7){
        DestinationViewController *viewCtrl=[[DestinationViewController alloc]initWithNibName:@"DestinationViewController" bundle:nil];
        viewCtrl.responseItem=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
}
@end

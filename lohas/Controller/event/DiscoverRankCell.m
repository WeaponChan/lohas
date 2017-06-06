//
//  DiscoverRankCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DiscoverRankCell.h"
#import "CountryViewController.h"
#import "SceneryViewController.h"
#import "FoodViewController.h"
#import "ShopViewController.h"
#import "EventViewController.h"
#import "HotelViewController.h"
#import "DestinationViewController.h"

@implementation DiscoverRankCell
@synthesize category_id;

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.labNum.layer.cornerRadius=4;
    self.labNum.layer.masksToBounds=YES;
    
    self.labNum.text=[item objectForKeyNotNull:@"index"];
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    
    NSString *picture=[item objectForKeyNotNull:@"image"];
    
    [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
    
    if (SCREENWIDTH>320) {
        [MSViewFrameUtil setHeight:170 UI:self.imageHead];
    }
    
}

+ (int)Height:(NSDictionary *)itemData{
    
     if (SCREENWIDTH>320) {
         return 230;
     }
    
    return 210;
}

- (IBAction)actClick:(id)sender {
    
    if (category_id.intValue==1) {
        CountryViewController *viewCtrl=[[CountryViewController alloc]initWithNibName:@"CountryViewController" bundle:nil];
        viewCtrl.countryID=[item objectForKeyNotNull:@"id"];
        viewCtrl.HeadDic=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
   else if (category_id.intValue==2) {
        SceneryViewController *viewCtrl=[[SceneryViewController alloc]initWithNibName:@"SceneryViewController" bundle:nil];
        viewCtrl.countryID=[item objectForKeyNotNull:@"id"];
        viewCtrl.HeadDic=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(category_id.intValue==3){
        HotelViewController *viewCtrl=[[HotelViewController alloc]initWithNibName:@"HotelViewController" bundle:nil];
        viewCtrl.hotelID=[item objectForKeyNotNull:@"id"];
        viewCtrl.listItem=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(category_id.intValue==4){
        FoodViewController *viewCtrl=[[FoodViewController alloc]initWithNibName:@"FoodViewController" bundle:nil];
        viewCtrl.countryID=[item objectForKeyNotNull:@"id"];
        viewCtrl.HeadDic=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(category_id.intValue==5){
        ShopViewController *viewCtrl=[[ShopViewController alloc]initWithNibName:@"ShopViewController" bundle:nil];
        viewCtrl.responseItem=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(category_id.intValue==6){
        EventViewController *viewCtrl=[[EventViewController alloc]initWithNibName:@"EventViewController" bundle:nil];
        viewCtrl.eventID=[item objectForKeyNotNull:@"id"];
        viewCtrl.headDic=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    //目的地
    else if (category_id.intValue==7){
        DestinationViewController *viewCtrl=[[DestinationViewController alloc]initWithNibName:@"DestinationViewController" bundle:nil];
        viewCtrl.responseItem=item;
        viewCtrl.hidesBottomBarWhenPushed=YES;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    
}
@end

//
//  FocusTripDeleteCell.m
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "FocusTripDeleteCell.h"
#import "AddTripViewController.h"
#import "CountryViewController.h"
#import "SceneryViewController.h"
#import "FoodViewController.h"
#import "ShopViewController.h"
#import "EventViewController.h"
#import "HotelViewController.h"

@implementation FocusTripDeleteCell
@synthesize isEdit;
- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    self.labName.text=[item objectForKeyNotNull:@"title"];
    
    NSString *distance=[item objectForKeyNotNull:@"distance"];
    if (distance.doubleValue<0) {
        self.labDistance.hidden=YES;
    }else{
        self.labDistance.text=[NSString stringWithFormat:@"%.1fkm",distance.floatValue];
        if (distance.floatValue>500) {
            self.labDistance.text=@">500km";
        }
    }
    
    self.labComment.text=[NSString stringWithFormat:@"%@点评",[item objectForKeyNotNull:@"comment_num"]];
    
    NSString *picture=[item objectForKeyNotNull:@"image"];
    [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
    
    NSString *price=[item objectForKeyNotNull:@"price"];
    self.labPrice.text=[NSString stringWithFormat:@"%.2f",price.floatValue];
    [self.labPrice sizeToFit];
    int width=self.labPrice.frame.size.width;
    [MSViewFrameUtil setLeft:88+width+2 UI:self.labPeople];
    
    //星星评分
    NSArray *imageStarList=[[NSArray alloc]initWithObjects:self.imageStar1,self.imageStar2,self.imageStar3,self.imageStar4,self.imageStar5, nil];
    NSString *comment_avg=[item objectForKeyNotNull:@"score"];
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
    
    NSString *tripDate=[item objectForKeyNotNull:@"tripDate"];
    if (tripDate) {
        
        NSArray *array=[tripDate componentsSeparatedByString:@" "];
        self.labTime.text=[NSString stringWithFormat:@"%@\n%@",array[0],array[1]];
        
    }else{
        NSString *date=[parent getNowDate];
        NSString *time=[parent getNowTime];
        
        self.labTime.text=[NSString stringWithFormat:@"%@\n%@",date,time];
    }

}

+ (int)Height:(NSDictionary *)itemData{
    return 80;
}

- (IBAction)actSelectTime:(id)sender {
    
    if (isEdit) {
        
        if ([parent isKindOfClass:[AddTripViewController class]]) {
            AddTripViewController *viewCtrl=(AddTripViewController*)parent;
            [viewCtrl deleteTrip:[item objectForKeyNotNull:@"shop_id"]];
        }
        
    }else{
    
    if ([parent isKindOfClass:[AddTripViewController class]]) {
        AddTripViewController *viewCtrl=(AddTripViewController*)parent;
        [viewCtrl selectTime:[item objectForKeyNotNull:@"id"]];
    }
    }
}

- (IBAction)actDelete:(id)sender {
    
    if (isEdit) {
        
        if ([parent isKindOfClass:[AddTripViewController class]]) {
            AddTripViewController *viewCtrl=(AddTripViewController*)parent;
            [viewCtrl deleteTrip:[item objectForKeyNotNull:@"shop_id"]];
        }

    }else{
        
        if ([parent isKindOfClass:[AddTripViewController class]]) {
            AddTripViewController *viewCtrl=(AddTripViewController*)parent;
            [viewCtrl deleteTrip:[item objectForKeyNotNull:@"id"]];
            }
        }
    
    
}

- (IBAction)actClick:(id)sender {
    
    NSString *shopCategory=[item objectForKeyNotNull:@"type"];
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
    
}


@end

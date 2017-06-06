//
//  TopCell.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "TopCell.h"
#import "TopBussinessViewController.h"
#import "HotelViewController.h"
#import "CountryViewController.h"
#import "SceneryViewController.h"
#import "FoodViewController.h"
#import "ShopViewController.h"
#import "EventViewController.h"

@implementation TopCell
@synthesize headDic;

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
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    //[self.labTitle sizeToFit];
    self.labNum.layer.cornerRadius = 4.f;
    self.labNum.layer.masksToBounds = YES;
    self.labNum.text = [item objectForKeyNotNull:@"index"];
    NSString *picture=[item objectForKeyNotNull:@"image"];
    [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg640x320.png"]];
}

+ (int)Height:(NSDictionary *)itemData{
    return 195;
}

- (IBAction)actTop:(id)sender {
    
    NSString *category_id=[headDic objectForKeyNotNull:@"category_id"];
    
    if (category_id.intValue==1) {
        CountryViewController *viewCtrl=[[CountryViewController alloc]initWithNibName:@"CountryViewController" bundle:nil];
        viewCtrl.countryID=[item objectForKeyNotNull:@"id"];
        viewCtrl.HeadDic=item;
        [parent.navigationController pushViewController:viewCtrl animated:YES];

    }
    if (category_id.intValue==2) {
        SceneryViewController *viewCtrl=[[SceneryViewController alloc]initWithNibName:@"SceneryViewController" bundle:nil];
        viewCtrl.countryID=[item objectForKeyNotNull:@"id"];
        viewCtrl.HeadDic=item;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(category_id.intValue==3){
        HotelViewController *viewCtrl=[[HotelViewController alloc]initWithNibName:@"HotelViewController" bundle:nil];
        viewCtrl.hotelID=[item objectForKeyNotNull:@"id"];
        viewCtrl.listItem=item;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(category_id.intValue==4){
        FoodViewController *viewCtrl=[[FoodViewController alloc]initWithNibName:@"FoodViewController" bundle:nil];
        viewCtrl.countryID=[item objectForKeyNotNull:@"id"];
        viewCtrl.HeadDic=item;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(category_id.intValue==5){
        ShopViewController *viewCtrl=[[ShopViewController alloc]initWithNibName:@"ShopViewController" bundle:nil];
        viewCtrl.responseItem=item;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    else if(category_id.intValue==6){
        EventViewController *viewCtrl=[[EventViewController alloc]initWithNibName:@"EventViewController" bundle:nil];
        viewCtrl.eventID=[item objectForKeyNotNull:@"id"];
        viewCtrl.headDic=item;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
    
    /*
    TopBussinessViewController *viewCtrl=[[TopBussinessViewController alloc]initWithNibName:@"TopBussinessViewController" bundle:nil];
    viewCtrl.HeadDic=headDic;
    viewCtrl.NextDic=item;
    [parent.navigationController pushViewController:viewCtrl animated:YES];*/

}
@end

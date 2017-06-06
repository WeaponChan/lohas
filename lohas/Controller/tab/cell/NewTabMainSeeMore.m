//
//  NewTabMainSeeMore.m
//  lohas
//
//  Created by Juyuan123 on 16/2/22.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "NewTabMainSeeMore.h"
#import "CityListViewController.h"
#import "NewCityListViewController.h"

@implementation NewTabMainSeeMore

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    [MSViewFrameUtil setBorder:1 Color:MS_RGB(23, 76, 128) UI:self.btnSeeMore];
    self.btnSeeMore.layer.cornerRadius=4;
    self.btnSeeMore.layer.masksToBounds=YES;
}

+ (int)Height:(NSDictionary *)itemData{
    return 90;
}

- (IBAction)actSeemore:(id)sender {
    /*CityListViewController *viewCtrl=[[CityListViewController alloc]initWithNibName:@"CityListViewController" bundle:nil];
    viewCtrl.isRootView = false;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:TRUE];*/
    
    NewCityListViewController *viewCtrl=[[NewCityListViewController alloc]initWithNibName:@"NewCityListViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:TRUE];
    
}
@end

//
//  DiscoverMainCell.m
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DiscoverMainCell.h"
#import "DiscoverRankListViewController.h"
#import "subDiscoverListViewController.h"


@implementation DiscoverMainCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    NSString *picture=[item objectForKeyNotNull:@"picture"];
    [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
    
    self.labSub.text=[item objectForKeyNotNull:@"area2Nmae"];
    self.labMain.text=[item objectForKeyNotNull:@"area1Name"];
    
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 192;
}

- (IBAction)actClick:(id)sender {
}

- (IBAction)actClickSub:(id)sender {
    subDiscoverListViewController *viewCtrl=[[subDiscoverListViewController alloc]initWithNibName:@"subDiscoverListViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    viewCtrl.rankID=[item objectForKeyNotNull:@"area2"];
    viewCtrl.typeID=[item objectForKeyNotNull:@"category_id"];
    viewCtrl.mainTitle=self.labSub.text;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actClickMain:(id)sender {
    subDiscoverListViewController *viewCtrl=[[subDiscoverListViewController alloc]initWithNibName:@"subDiscoverListViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    viewCtrl.rankID=[item objectForKeyNotNull:@"area1"];
    viewCtrl.typeID=[item objectForKeyNotNull:@"category_id"];
    viewCtrl.mainTitle=self.labMain.text;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
}

@end

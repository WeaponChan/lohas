//
//  subDiscoverRankCell.m
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "subDiscoverRankCell.h"
#import "DiscoverRankListViewController.h"

@implementation subDiscoverRankCell
@synthesize category_id;

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];
    
    NSString *image=[item objectForKeyNotNull:@"image"];
    if (image.length==0) {
        image=[item objectForKeyNotNull:@"picture"];
    }
    [self.imageHead loadImageAtURLString:image placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    
    if(SCREENWIDTH>320){
        [MSViewFrameUtil setHeight:180 UI:self.imageHead];
    }
    
}


+ (int)Height:(NSDictionary *)itemData{
    
    if(SCREENWIDTH>320){
        return 216;
    }
    
    return 196;
}

- (IBAction)actClick:(id)sender {
    
    DiscoverRankListViewController *viewCtrl=[[DiscoverRankListViewController alloc]initWithNibName:@"DiscoverRankListViewController" bundle:nil];
    viewCtrl.interest_id=[item objectForKeyNotNull:@"id"];
    viewCtrl.category_id=category_id;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    viewCtrl.mainTitle=self.labTitle.text;
    viewCtrl.imageView=self.imageHead.image;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
}
@end

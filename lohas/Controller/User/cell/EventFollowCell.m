//
//  EventFollowCell.m
//  lohas
//
//  Created by Juyuan123 on 15/5/22.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "EventFollowCell.h"
#import "EventNewViewController.h"

@implementation EventFollowCell
@synthesize isNeehideDistance;

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    [self.btnEvent setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnEvent addBtnAction:@selector(actEvent:) target:self];
    
    if (isNeehideDistance) {
        //self.labDistance.hidden=YES;
    }
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    
    NSString *create_time=[item objectForKeyNotNull:@"create_time"];
    self.labSubTitle.text=[NSString stringWithFormat:@"发布时间:%@",[parent zoneChange1:create_time bit:10]];
    
    NSArray *picture_lists=[item objectForKeyNotNull:@"picture_lists"];
    if (picture_lists.count>0) {
        NSString *picture=[picture_lists[0] objectForKeyNotNull:@"image"];
        [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
    }
    
    NSString *distance=[item objectForKeyNotNull:@"distance"];
    if (distance.doubleValue<0) {
        self.labDistance.hidden=YES;
    }else{
        self.labDistance.text=[NSString stringWithFormat:@"%.1fkm",distance.floatValue];
        if (distance.floatValue>500) {
            self.labDistance.text=@">500km";
        }
    }
    
    self.labComment.text=[NSString stringWithFormat:@"%@点评",[item objectForKeyNotNull:@"comment_count"]];
    
    //星星评分
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
    
}

//按钮点击
- (void)actEvent:(id)sender {
    
    EventNewViewController *viewCtrl=[[EventNewViewController alloc]initWithNibName:@"EventNewViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.eventID=[item objectForKeyNotNull:@"id"];
    viewCtrl.headDic=item;
    [parent.navigationController pushViewController:viewCtrl animated:TRUE];
}



+ (int)Height:(NSDictionary *)itemData{
    return 110;
}


@end

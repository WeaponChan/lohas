//
//  EventListCell.m
//  lohas
//
//  Created by juyuan on 15-2-14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "EventListCell.h"
#import "EventViewController.h"
#import "EventNewViewController.h"

@implementation EventListCell
@synthesize isNeehideDistance;

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}


- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl
{
    [super update:itemData Parent:parentCtrl];

    if (isNeehideDistance) {
        self.labDistance.hidden=YES;
    }
    
    [self.btnEvent setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnEvent addBtnAction:@selector(actEvent:) target:self];
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    NSString *create_time=[item objectForKeyNotNull:@"create_time"];
    self.labTime.text=[parent zoneChange1:create_time bit:10];
    
    NSArray *category_list=[item objectForKeyNotNull:@"category_list"];
    //    if(category_list.count==0){
    //        return;
    //    }
    
    NSString *cateStr=@"";
    for (NSDictionary *dic in category_list) {
        NSString *title=[dic objectForKeyNotNull:@"title"];
        
        if (cateStr.length==0) {
            cateStr=title;
        }else{
            cateStr=[NSString stringWithFormat:@"%@ %@",cateStr,title];
        }
        
    }

    
    
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
    
    NSArray *picture_lists=[item objectForKeyNotNull:@"picture_lists"];
    if (picture_lists.count>0) {
        NSDictionary *dic=picture_lists[0];
        NSString *picture=[dic objectForKeyNotNull:@"image"];
        if(picture.length==0){
            picture=[dic objectForKeyNotNull:@"picture"];
        }
        [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
    }
  
    NSString *distance=[item objectForKeyNotNull:@"distance"];
    if (distance.doubleValue<0) {
        self.labDistance.hidden=YES;
    }else{
        self.labDistance.text=[NSString stringWithFormat:@"%.1fkm",distance.floatValue];
        if (distance.intValue>500) {
            self.labDistance.text=@">500km";
        }
    }
    
    self.labSubTitle.text=cateStr;
    
    NSString *price=[item objectForKeyNotNull:@"price"];
    self.labPrice.text=[NSString stringWithFormat:@"%.2f",price.floatValue];
    [self.labPrice sizeToFit];
    int width=self.labPrice.frame.size.width;
    [MSViewFrameUtil setLeft:118+width+2 UI:self.labPeople];
    
    
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
    
    [self.labTime sizeToFit];
    [MSViewFrameUtil setTop:10 UI:self.labTime];
    
    
    
    [self.labTime sizeToFit];
    [MSViewFrameUtil setTop:10 UI:self.labTime];
    
//    [self.labTitle sizeToFit];
//   
//    int height = [MSViewFrameUtil setTop:10 UI:self.labTitle];
//    [MSViewFrameUtil setHeight:height+10 UI:self.viewInfo];
    
    
}
//按钮点击
- (void)actEvent:(id)sender {
    
//    EventViewController *viewCtrl=[[EventViewController alloc]initWithNibName:@"EventViewController" bundle:nil];
//    viewCtrl.hidesBottomBarWhenPushed = YES;
//    viewCtrl.eventID=[item objectForKeyNotNull:@"id"];
//    viewCtrl.headDic=item;
//    [parent.navigationController pushViewController:viewCtrl animated:TRUE];
    
    EventNewViewController *viewCtrl=[[EventNewViewController alloc]initWithNibName:@"EventNewViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.eventID=[item objectForKeyNotNull:@"id"];
    viewCtrl.headDic=item;
    [parent.navigationController pushViewController:viewCtrl animated:TRUE];
}

+ (int)Height:(NSDictionary *)itemData{
    
//    NSString *str=[itemData objectForKeyNotNull:@"title"];
//    int height = [MSViewFrameUtil getLabHeight:str FontSize:14 Width:304];
//    
//    return 165+10+height+10;
    return 110;
}

@end

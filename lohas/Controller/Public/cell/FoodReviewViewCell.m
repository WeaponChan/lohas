//
//  ReviewViewCell.m
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodReviewViewCell.h"
#import "DynamicUserInfoViewController.h"

#define SCREENHEIGHT [UIScreen mainScreen].bounds.size.height
#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@implementation FoodReviewViewCell

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
    
    NSString *score=[item objectForKeyNotNull:@"score"];
    self.labScore.text=[NSString stringWithFormat:@"%@分",score];
    
    NSString *nick=[item objectForKeyNotNull:@"nick"];
    self.labName.text=[NSString stringWithFormat:@"%@",nick];
    [self.labName sizeToFit];
    [MSViewFrameUtil setHeight:20 UI:self.labName];
    int width=self.labName.frame.size.width;
    width=[MSViewFrameUtil setLeft:60+width UI:self.imageSex];
    width=[MSViewFrameUtil setLeft:width+10 UI:self.labPingFen];
    [MSViewFrameUtil setLeft:width UI:self.labScore];
    
    self.labContent.text=[item objectForKeyNotNull:@"content"];
    [self.labContent sizeToFit];
    //int height=self.labContent.frame.size.height;
    int height=[MSViewFrameUtil getLabHeight:self.labContent.text FontSize:14 Width:SCREENWIDTH-70];
    [MSViewFrameUtil setHeight:height+2 UI:self.labContent];
    if (self.labContent.text.length==0) {
        [MSViewFrameUtil setHeight:80 UI:self.viewMain];
    }else{
        [MSViewFrameUtil setHeight:35+height+10 UI:self.viewMain];
    }
    
    self.imageHead.layer.cornerRadius=20;
    NSString *avatar=[item objectForKeyNotNull:@"avatar"];
    [self.imageHead loadImageAtURLString:avatar placeholderImage:[UIImage imageNamed:@"default_bg80x80.png"]];
    
    NSString *create_time=[item objectForKeyNotNull:@"create_time"];
    self.labTime.text=[parent zoneChange1:create_time bit:10];
    
    NSString *sex=[item objectForKeyNotNull:@"sex"];
    if (sex.intValue==1) {
        [self.imageSex setImage:[UIImage imageNamed:@"boy_n.png"]];
    }else{
        [self.imageSex setImage:[UIImage imageNamed:@"girl_n.png"]];
    }
    
}

+ (int)Height:(NSDictionary *)itemData{
    
    NSString *str=[itemData objectForKeyNotNull:@"content"];
    int height = [MSViewFrameUtil getLabHeight:str FontSize:14 Width:SCREENWIDTH-70];
    
    if (str.length==0) {
        return 80;
    }
    
    return 35+height+10;
}

- (IBAction)actImageHead:(id)sender {
    
    DynamicUserInfoViewController *viewCtrl=[[DynamicUserInfoViewController alloc]initWithNibName:@"DynamicUserInfoViewController" bundle:nil];
    viewCtrl.user_id=[item objectForKeyNotNull:@"user_id"];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

@end

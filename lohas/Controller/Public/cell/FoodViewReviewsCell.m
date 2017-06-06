//
//  FoodViewReviewsCell.m
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodViewReviewsCell.h"

@implementation FoodViewReviewsCell
@synthesize comment_numDic,infoDic,headDic;

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

    NSString *comment_count=[infoDic objectForKeyNotNull:@"comment_count"];
    if(!comment_count){
        comment_count=[infoDic objectForKeyNotNull:@"comment_num"];
    }
    self.labComment.text=[NSString stringWithFormat:@"%@点评",comment_count];
    
    self.labNum1.text=[comment_numDic objectForKeyNotNull:@"very_good_num"];
    self.labNum2.text=[comment_numDic objectForKeyNotNull:@"good_num"];
    self.labNum3.text=[comment_numDic objectForKeyNotNull:@"general_num"];
    self.labNum4.text=[comment_numDic objectForKeyNotNull:@"bad_num"];
    
    //蓝条
    float totalCount=comment_count.floatValue;
    float a;
    float b;
    float c;
    float d;
    if (totalCount==0) {
        a=0;
        b=0;
        c=0;
        d=0;
    }else{
        a=self.labNum1.text.floatValue/totalCount*160;
        b=self.labNum2.text.floatValue/totalCount*160;
        c=self.labNum3.text.floatValue/totalCount*160;
        d=self.labNum4.text.floatValue/totalCount*160;
    }

    
    [MSViewFrameUtil setWidth:a UI:self.labLine1];
    [MSViewFrameUtil setWidth:b UI:self.labLine2];
    [MSViewFrameUtil setWidth:c UI:self.labLine3];
    [MSViewFrameUtil setWidth:d UI:self.labLine4];
    
    //星星评分
    NSArray *imageStarList=[[NSArray alloc]initWithObjects:self.imageStar1,self.imageStar2,self.imageStar3,self.imageStar4,self.imageStar5, nil];
    NSString *comment_avg=[infoDic objectForKeyNotNull:@"comment_avg"];
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

+ (int)Height:(NSDictionary *)itemData{
    return 206;
}

@end

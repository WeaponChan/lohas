//
//  TripAddInfoCell.m
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "TripAddInfoCell.h"
#import "MyFocusTripViewController.h"

@implementation TripAddInfoCell
@synthesize selectList;

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
    [MSViewFrameUtil setLeft:94+width+2 UI:self.labPeople];

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
    
    NSString *selected=[item objectForKeyNotNull:@"selected"];
    if ([selected isEqual:@"YES"]) {
        self.imageSelect.hidden=NO;
    }else{
        self.imageSelect.hidden=YES;
    }
}

+ (int)Height:(NSDictionary *)itemData{
    return 80;
}

- (IBAction)actSelect:(id)sender {
    NSString *selected=[item objectForKeyNotNull:@"selected"];
    if ([selected isEqual:@"YES"]) {
        
        NSString *id=[item objectForKeyNotNull:@"id"];
        for (NSMutableDictionary *dic in selectList) {
            NSString *subID=[dic objectForKeyNotNull:@"id"];
            if ([id isEqual:subID]) {
                [selectList removeObject:dic];
                break;
            }
        }
    }else{
        [selectList addObject:item];
    }
    
    if ([parent isKindOfClass:[MyFocusTripViewController class]]) {
        MyFocusTripViewController *viewCtrl=(MyFocusTripViewController*)parent;
        [viewCtrl.mAddTripList refreshData];
    }
    
}

@end

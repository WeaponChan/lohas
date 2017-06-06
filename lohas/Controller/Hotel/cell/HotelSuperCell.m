//
//  HotelSuperCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "HotelSuperCell.h"
#import "HotelViewController.h"
#import "HotelSearchSuperViewController.h"

@implementation HotelSuperCell
@synthesize isNeehideDistance;


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
    
    if (isNeehideDistance) {
        self.labDistance.hidden=YES;
    }
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
   // self.labSubTitle.text=[item objectForKeyNotNull:@"desc"];
    NSString *star = [item objectForKeyNotNull:@"star"];
    self.labSubTitle.text = [NSString stringWithFormat:@"%@星级",star];
    NSString *picture=[item objectForKeyNotNull:@"image"];
    [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
    
    NSString *price=[item objectForKeyNotNull:@"price"];
    self.labPrice.text=[NSString stringWithFormat:@"%.2f",price.floatValue];
    [self.labPrice sizeToFit];
    int width=self.labPrice.frame.size.width;
    [MSViewFrameUtil setLeft:118+width+2 UI:self.labPeople];
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

+ (int)Height:(NSDictionary *)itemData{
    return 110;
}


- (IBAction)actClick:(id)sender {
    
    HotelViewController *viewCtrl=[[HotelViewController alloc]initWithNibName:@"HotelViewController" bundle:nil];
    viewCtrl.hotelID=[item objectForKeyNotNull:@"id"];
    viewCtrl.sdate=self.sdate;
    viewCtrl.edate=self.edate;
    viewCtrl.listItem=item;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}
@end

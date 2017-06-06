//
//  SceneryListCell.m
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "SceneryListCell.h"
#import "SceneryViewController.h"
#import "WapViewController.h"

@implementation SceneryListCell
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
    //NSLog(@"res%@",item);
    if (isNeehideDistance) {
       // self.labDistance.hidden=YES;
    }
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    self.labSubTitle.text=[item objectForKeyNotNull:@"desc"];
    
    NSString *picture=[item objectForKeyNotNull:@"image"];
    [self.imageHead loadImageAtURLString:picture placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
    
    NSString *score=[item objectForKeyNotNull:@"comment_count"];
    self.labComment.text=[NSString stringWithFormat:@"%@点评",score];
    
    NSString *distance=[item objectForKeyNotNull:@"distance"];
    if (distance.doubleValue<0) {
        self.labDistance.hidden=YES;
    }else{
        self.labDistance.text=[NSString stringWithFormat:@"%.1fkm",distance.floatValue];
        if (distance.intValue>500) {
            self.labDistance.text=@">500km";
        }
    }
    
    NSString *price=[item objectForKeyNotNull:@"price"];
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

    self.labPrice.text=[NSString stringWithFormat:@"%.2f",price.floatValue];
    [self.labPrice sizeToFit];
    int width=self.labPrice.frame.size.width;
    [MSViewFrameUtil setLeft:118+width+2 UI:self.labPeople];
    
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
    
    NSArray *category_list=[item objectForKeyNotNull:@"category_list"];
    NSString *cateStr=@"";
    for (NSDictionary *dic in category_list) {
        NSString *title=[dic objectForKeyNotNull:@"title"];
        
        if (cateStr.length==0) {
            cateStr=title;
        }else{
            cateStr=[NSString stringWithFormat:@"%@ %@",cateStr,title];
        }
        
    }
    
    self.labSubTitle.text=cateStr;
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 110;
}

- (IBAction)actClick:(id)sender {
    /*
    NSString *str=[NSString stringWithFormat:@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=651&productid=%@&sourceid=&sid=467134&allianceid=26524&ouid=",[item objectForKeyNotNull:@"poi"]];
    WapViewController *viewctrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewctrl.linkStr=str;
    viewctrl.title=self.labTitle.text;
    [parent.navigationController pushViewController:viewctrl animated:YES];*/
    
    SceneryViewController *viewCtrl=[[SceneryViewController alloc]initWithNibName:@"SceneryViewController" bundle:nil];
    viewCtrl.countryID=[item objectForKeyNotNull:@"id"];
    viewCtrl.HeadDic=item;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
    
    
    
}
@end
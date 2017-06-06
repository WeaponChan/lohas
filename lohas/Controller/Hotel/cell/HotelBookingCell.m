//
//  HotelBookingCell.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "HotelBookingCell.h"
#import "WapViewController.h"

@implementation HotelBookingCell

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
    
    NSLog(@"item%@",item);
    
    [self.btnClick setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnClick addBtnAction:@selector(actClick) target:self];
    
    self.labTitle.text=[item objectForKeyNotNull:@"Name"];
    
    NSString *AmountBeforeTax=[item objectForKeyNotNull:@"AmountBeforeTax"];
    NSString *ListPrice=[item objectForKeyNotNull:@"ListPrice"];
    
    double inteval=ListPrice.doubleValue-AmountBeforeTax.doubleValue;
    
    if (inteval<=0) {
    self.labPrice.text=[NSString stringWithFormat:@"￥%.2f",AmountBeforeTax.doubleValue];
      self.labSubtitle.text=[NSString stringWithFormat:@"市场价￥%.2f",AmountBeforeTax.doubleValue];
    }else{
        self.labPrice.text=[NSString stringWithFormat:@"￥%.2f",AmountBeforeTax.doubleValue];
        self.labSubtitle.text=[NSString stringWithFormat:@"市场价￥%.2f",ListPrice.doubleValue];
    }
   
    [self.labPrice sizeToFit];
    int width=self.labPrice.frame.size.width;
    [MSViewFrameUtil setLeft:10+width+1 UI:self.labTag];
    
}

-(void)actClick{
    
    NSString *intval = [parent getInterval:self.sdate edate:self.edate];
    NSString *HotelId = [self.ListItem objectForKeyNotNull:@"HotelId"];
    
    NSArray *dateList=[self.sdate componentsSeparatedByString:@"-"];
    NSString *startDate=[NSString stringWithFormat:@"%@%@%@",dateList[0],dateList[1],dateList[2]];
    
    NSString *str=[NSString stringWithFormat:@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=13&sid=467134&allianceid=26524&ouid=&HotelID=%@&ATime=%@&Days=%@&Sales=",HotelId,startDate,intval];
    NSLog(@"str==%@",str);
    WapViewController *viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.linkStr=str;
    viewCtrl.title=self.headTitle;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 60;
}

@end

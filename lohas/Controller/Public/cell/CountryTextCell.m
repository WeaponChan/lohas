
//
//  CountryTextCell.m
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "CountryTextCell.h"
#import "CountryViewController.h"
#import "FoodViewController.h"
#import "ShopViewController.h"
#import "DestinationViewController.h"

@implementation CountryTextCell
@synthesize countryInfo,isHideMore;

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
    
    self.labDescribe.text=[countryInfo objectForKeyNotNull:@"desc"];
    [self.labDescribe sizeToFit];
    //int height=self.labDescribe.frame.size.height;
    
    int height=[MSViewFrameUtil getLabHeight:self.labDescribe.text FontSize:14 Width:SCREENWIDTH-20];
    
    [MSViewFrameUtil setWidth:300 UI:self.labDescribe];
    [MSViewFrameUtil setTop:10 UI:self.labDescribe];
    
    [MSViewFrameUtil setHeight:height+2 UI:self.labDescribe];
    
    if (height>135 && isHideMore) {
        
        [MSViewFrameUtil setWidth:270 UI:self.labDescribe];
        [MSViewFrameUtil setHeight:135 UI:self.labDescribe];
        
        self.btnGetMore.hidden=NO;
        self.btnGetMore.selected=NO;
        self.btnMore.hidden=NO;
        
    }else if(height>135 && isHideMore==NO){
        [MSViewFrameUtil setWidth:270 UI:self.labDescribe];
 
        height=[MSViewFrameUtil getLabHeight:self.labDescribe.text FontSize:14 Width:SCREENWIDTH-50];
        [MSViewFrameUtil setHeight:height+2 UI:self.labDescribe];
        
        self.btnGetMore.selected=YES;
        self.btnGetMore.hidden=NO;
        self.btnMore.hidden=NO;
    }else{
        
        self.btnGetMore.selected=YES;
        self.btnGetMore.hidden=YES;
        self.btnMore.hidden=YES;
    }
    
    
}

+ (int)Height:(NSDictionary *)itemData isHide:(BOOL)isHide{
    
    NSString *desc=[itemData objectForKeyNotNull:@"desc"];
    
    int height=[MSViewFrameUtil getLabHeight:desc FontSize:14 Width:SCREENWIDTH-20];
    
    if (height>135 && isHide) {
        return 10+134+10;
    }else if (height>135 && isHide==NO){
        height=[MSViewFrameUtil getLabHeight:desc FontSize:14 Width:SCREENWIDTH-50];
        
    }
    
    return 10+height+10;
}

- (IBAction)actGetMore:(id)sender {
    
    if ([parent isKindOfClass:[FoodViewController class]]) {
        FoodViewController *viewCtrl=(FoodViewController*)parent;
        [viewCtrl getMore:isHideMore];
    }
    else if ([parent isKindOfClass:[ShopViewController class]]){
        ShopViewController *viewCtrl=(ShopViewController*)parent;
        [viewCtrl getMore:isHideMore];
    }
    else if ([parent isKindOfClass:[DestinationViewController class]]){
        DestinationViewController *viewCtrl=(DestinationViewController*)parent;
        [viewCtrl getMore:isHideMore];
    }
    else{
        CountryViewController *viewCtrl=(CountryViewController*)parent;
        [viewCtrl getMore:isHideMore];
    }
    
}
@end

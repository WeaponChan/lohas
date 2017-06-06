//
//  FoodHotelCell.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "HotelTextCell.h"
#import "HotelViewController.h"

@implementation HotelTextCell
@synthesize responseItem,isHideMore;

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
    
    self.labDes.text=[responseItem objectForKeyNotNull:@"desc"];
    [self.labDes sizeToFit];
    
    [MSViewFrameUtil setWidth:300 UI:self.labDes];
    int height=[MSViewFrameUtil getLabHeight:self.labDes.text FontSize:14 Width:SCREENWIDTH-20];
    
    if (height>135 && isHideMore) {
        [MSViewFrameUtil setWidth:270 UI:self.labDes];
        [MSViewFrameUtil setHeight:135 UI:self.labDes];
        [MSViewFrameUtil setHeight:144 UI:self.viewText];
        
        self.btnGetMore.hidden=NO;
        self.btnGetMore.selected=NO;
        self.btnMore.hidden=NO;
        
    }else if(height>135 && isHideMore==NO){
        [MSViewFrameUtil setWidth:270 UI:self.labDes];
 
        height=[MSViewFrameUtil getLabHeight:self.labDes.text FontSize:14 Width:SCREENWIDTH-50];
        [MSViewFrameUtil setHeight:height+2 UI:self.labDes];
        
        self.btnGetMore.selected=YES;
        self.btnGetMore.hidden=NO;
        self.btnMore.hidden=NO;
        [MSViewFrameUtil setHeight:10+height+10 UI:self.viewText];
    }else{
        self.btnGetMore.selected=YES;
        self.btnGetMore.hidden=YES;
        self.btnMore.hidden=YES;
        [MSViewFrameUtil setHeight:height+2 UI:self.labDes];
        [MSViewFrameUtil setHeight:10+height+10 UI:self.viewText];
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
    HotelViewController *viewCtrl=(HotelViewController*)parent;
    [viewCtrl getMore:isHideMore];
}

@end

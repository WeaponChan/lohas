//
//  HotelTypeCell.m
//  lohas
//
//  Created by fred on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "HotelTypeCell.h"
#import "HotelTypeViewController.h"

@implementation HotelTypeCell

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
    
    self.labTitle.text=[item objectForKeyNotNull:@"star"];
    
    NSString *selected=[item objectForKeyNotNull:@"selected"];
    if ([selected isEqual:@"NO"]) {
        self.labTag.hidden=YES;
    }else{
        self.labTag.hidden=NO;
    }
    
}

-(void)actClick{
    
    if ([parent isKindOfClass:[HotelTypeViewController class]]) {
        HotelTypeViewController *viewCtrl=(HotelTypeViewController*)parent;
        [viewCtrl changeStyle:[item objectForKeyNotNull:@"index"]];
    }
    
}


+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

@end

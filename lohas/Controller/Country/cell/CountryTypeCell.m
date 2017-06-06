//
//  CountryTypeCell.m
//  lohas
//
//  Created by fred on 15-3-16.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "CountryTypeCell.h"
#import "CountryTypeViewController.h"

@implementation CountryTypeCell

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
    
    NSLog(@"item==%@",item);
    [self.btnClick setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnClick addBtnAction:@selector(actClick) target:self];
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
}

-(void)actClick{
    CountryTypeViewController *view=(CountryTypeViewController*)parent;
    //[view.delegate getType:[item objectForKeyNotNull:@"title"] type_id:[item objectForKeyNotNull:@"id"]];
    [parent.navigationController popViewControllerAnimated:YES];
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

@end

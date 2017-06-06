//
//  FoodGroupCell.m
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodGroupCell.h"
#import "FoodGroupDetiaViewController.h"

@implementation FoodGroupCell

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
    
    [self.btnClick setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnClick addBtnAction:@selector(actClick) target:self];
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 70;
}

//点击
-(void)actClick{
    
    [parent.navigationController popViewControllerAnimated:YES];
}



@end

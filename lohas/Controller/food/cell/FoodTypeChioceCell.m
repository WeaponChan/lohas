//
//  FoodTypeChioceCell.m
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodTypeChioceCell.h"
#import "FoodTypeChioceViewController.h"

@implementation FoodTypeChioceCell

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
    
    [self.btnSelect setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnSelect addBtnAction:@selector(actSelect) target:self];
    
    self.labTitle.text=[item objectForKeyNotNull:@"title"];
    
    NSString *select=[item objectForKeyNotNull:@"select"];
    if ([select isEqual:@"NO"]) {
        self.imageS.hidden=YES;
    }
    
}

-(void)actSelect{
    FoodTypeChioceViewController *viewCtrl=(FoodTypeChioceViewController*)parent;
    
    [viewCtrl.mFoodTypeChioceList getSelectCell:[item objectForKeyNotNull:@"index"]];
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}


@end

//
//  CityCell.m
//  chuanmei
//
//  Created by juyuan on 14-8-15.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "CityCell.h"

@implementation CityCell

- (id)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        // Initialization code
    }
    return self;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    //NSLog(@"itemData:%@",itemData);
    [super update:itemData Parent:parentCtrl];
    if (itemData == nil) {
        [self.indicator setHidden:false];
        [self.indicator startAnimating];
        [self.labTips setHidden:false];
        [self.labCityName setHidden:true];
        
    }else{
        self.labCityName.text=[item objectForKeyNotNull:@"name"];
        [self.labCityName setHidden:false];
        
        [self.indicator setHidden:true];
        [self.indicator stopAnimating];
        [self.labTips setHidden:true];
    }
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}
@end

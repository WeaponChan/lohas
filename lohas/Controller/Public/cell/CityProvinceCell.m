//
//  CityProvinceCell.m
//  lohas
//
//  Created by Juyuan123 on 16/4/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "CityProvinceCell.h"
#import "NewCityListViewController.h"

@implementation CityProvinceCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    NSString *selected=[item objectForKeyNotNull:@"selected"];
    if ([selected isEqual:@"NO"]) {
        self.btnTag.selected=NO;
    }else{
        self.btnTag.selected=YES;
    }
    
    self.labTitle.text=[itemData objectForKeyNotNull:@"name"];
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

- (IBAction)actClick:(id)sender {
    
    NewCityListViewController *viewCtrl=(NewCityListViewController*)parent;
    [viewCtrl selectProvince:item];
    
}


@end

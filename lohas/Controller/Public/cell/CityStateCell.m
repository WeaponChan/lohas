//
//  CityStateCell.m
//  lohas
//
//  Created by Juyuan123 on 16/4/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "CityStateCell.h"

@implementation CityStateCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    self.labTitle.text=[itemData objectForKeyNotNull:@"name"];
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 44;
}

- (IBAction)actClick:(id)sender {
    
    NSString *cityName=[item objectForKeyNotNull:@"name"];
    NSString *cityID=[item objectForKeyNotNull:@"city_id"];
    
    [[AppDelegate sharedAppDelegate] setCityByName:cityName ID:cityID];
    
    NSString *ename=[item objectForKeyNotNull:@"ename"];
    [[NSUserDefaults standardUserDefaults]setObject:ename forKey:@"ename"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    
    
//    NSString *namestr = [[NSUserDefaults standardUserDefaults]objectForKey:@"ename"];
//    NSLog(@"%@",namestr);
    [[AppDelegate sharedAppDelegate] openTabHomeCtrl];
    
}


@end

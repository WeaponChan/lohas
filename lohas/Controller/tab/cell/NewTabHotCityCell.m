//
//  NewTabHotCityCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "NewTabHotCityCell.h"
#import "NewTabMainViewController.h"

@implementation NewTabHotCityCell

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    NSDictionary *cityDic1=[item objectForKeyNotNull:@"cityDic1"];
    NSString *image=[cityDic1 objectForKeyNotNull:@"image"];
    [self.image1 loadImageAtURLString:image placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
    self.labTtile1.text=[cityDic1 objectForKeyNotNull:@"name"];
    self.labSubTitle1.text = [cityDic1 objectForKeyNotNull:@"ename"];
    
    NSDictionary *cityDic2=[item objectForKeyNotNull:@"cityDic2"];
    NSString *image2=[cityDic2 objectForKeyNotNull:@"image"];
    [self.image2 loadImageAtURLString:image2 placeholderImage:[UIImage imageNamed:@"default_bg180x180.png"]];
    self.labTitle2.text=[cityDic2 objectForKeyNotNull:@"name"];
    self.labSubTitle2.text = [cityDic2 objectForKeyNotNull:@"ename"];
    /*
    if ([self.labTitle2.text length]) {
        NSMutableString *ms = [[NSMutableString alloc] initWithString:self.labTitle2.text];
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformMandarinLatin, NO)) {
            self.labSubTitle2.text=ms;
        }
        if (CFStringTransform((__bridge CFMutableStringRef)ms, 0, kCFStringTransformStripDiacritics, NO)) {
            self.labSubTitle2.text=ms;
        }
    }
    */
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 136;
}

- (IBAction)actClick1:(id)sender {
    NSDictionary *cityDic1=[item objectForKeyNotNull:@"cityDic1"];
    NSString *city_id=[cityDic1 objectForKeyNotNull:@"city_id"];
    NSString *name=[cityDic1 objectForKeyNotNull:@"name"];
    [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults]setObject:city_id forKey:@"cityID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if ([parent isKindOfClass:[NewTabMainViewController class]]) {
        NewTabMainViewController *viewCtrl=(NewTabMainViewController*)parent;
        [viewCtrl reloadData];
    }
    
}

- (IBAction)actClick2:(id)sender {
    NSDictionary *cityDic2=[item objectForKeyNotNull:@"cityDic2"];
    NSString *city_id=[cityDic2 objectForKeyNotNull:@"city_id"];
    NSString *name=[cityDic2 objectForKeyNotNull:@"name"];
    [[NSUserDefaults standardUserDefaults]setObject:name forKey:@"cityName"];
    [[NSUserDefaults standardUserDefaults]setObject:city_id forKey:@"cityID"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    if ([parent isKindOfClass:[NewTabMainViewController class]]) {
        NewTabMainViewController *viewCtrl=(NewTabMainViewController*)parent;
        [viewCtrl reloadData];
    }
}
@end

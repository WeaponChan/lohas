//
//  DetailBannerItem.m
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DetailBannerItem.h"

@implementation DetailBannerItem
@synthesize imgBanner;

- (void)update:(NSDictionary*)dict Parent:(MSViewController*)parentViewController
{
    
    parent = parentViewController;
    item = dict;
    
    NSString *imgurl = [item objectForKeyNotNull:@"image"];
    //imgBanner.showsLoadingActivity = true;
    imgBanner.autoresizeEnabled = false;
    [imgBanner loadImageAtURLString:imgurl placeholderImage:[UIImage imageNamed:@"default_bg640x300.png"]];
    
}

- (IBAction)actItemOpen:(id)sender {

    
}

@end

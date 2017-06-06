//
//  NewTabMainHeadCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "NewTabMainHeadCell.h"

#define SCREENWIDTH [UIScreen mainScreen].bounds.size.width

@implementation NewTabMainHeadCell
@synthesize city;

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    bannerView = (BannerView *)[parent newViewWithNibNamed:@"BannerView" owner:self];
    [self.viewBanner addSubview:bannerView];
    [bannerView initial:parent];
    
    NSArray *adList=[itemData objectForKeyNotNull:@"adList"];
    
    [bannerView reload:adList];
    
    Api *api = [[Api alloc] init:self tag:@"weather"];
    
    NSString *ename=[[NSUserDefaults standardUserDefaults]objectForKey:@"ename"];
    
    if (ename) {
        [api weather:ename];
    }
    
    
}

+ (int)Height:(NSDictionary *)itemData{
    
    if (SCREENWIDTH>320) {
        return 176;
    }
    
    return 146;
}
-(void)error:(NSString*)message tag:(NSString*)tag
{
    [parent closeLoadingView];
    [parent showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    if ([tag isEqual:@"weather"]) {
        
        if ([response count]>0) {
            NSDictionary *mainDic=response[0];
            
            NSDictionary *now=[mainDic objectForKeyNotNull:@"now"];
            NSDictionary *cond=[now objectForKeyNotNull:@"cond"];
            self.labWeather.text = [cond objectForKeyNotNull:@"txt"];
            NSString *dustr = [now objectForKeyNotNull:@"tmp"];
            self.labDu.text = [NSString stringWithFormat:@"%@℃",dustr];
        }
        
    }

}

@end

//
//  ShopInfoCell.m
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "ShopInfoCell.h"
#import "MapViewController.h"
#import "WapViewController.h"
#import "TSMessage.h"

@implementation ShopInfoCell
@synthesize resItem,infoItem;

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
    
    self.labAddress.text=[resItem objectForKeyNotNull:@"address"];
    self.labPhone.text=[resItem objectForKeyNotNull:@"phone"];
    
    if (self.labPhone.text.length==0) {
        self.labPhone.text=[infoItem objectForKeyNotNull:@"phone"];
    }
    
   // NSLog(@"resItem==%@",resItem);
    
}

+ (int)Height:(NSDictionary *)itemData{
    return 132;
}

- (IBAction)actPhone:(id)sender {
    [parent phonecall:self.labPhone.text];
}

- (IBAction)actMap:(id)sender {
    MapViewController *viewCtrl=[[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    viewCtrl.lat=[resItem objectForKeyNotNull:@"lat"];
    viewCtrl.lng=[resItem objectForKeyNotNull:@"lng"];
    viewCtrl.title=[resItem objectForKeyNotNull:@"title"];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actShopWEB:(id)sender {
    NSString *url=[resItem objectForKeyNotNull:@"url"];
    if (url.length==0 || [url isEqual:@"无"]) {
        [TSMessage showNotificationInViewController:parent title:@"当前商家还没有网站" subtitle:nil type:TSMessageNotificationTypeError];
        return;
        
    }else{
        NSString *sub=[url substringToIndex:4];
        if (![sub isEqual:@"http"]) {
            url=[NSString stringWithFormat:@"http://%@",url];
        }
        
        WapViewController *viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
        viewCtrl.linkStr=url;
        [parent.navigationController pushViewController:viewCtrl animated:YES];
    }
}

@end

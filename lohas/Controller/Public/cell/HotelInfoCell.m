//
//  HotelInfoCell.m
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "HotelInfoCell.h"
#import "MapViewController.h"
#import "WapViewController.h"
#import "HotelRoomListViewController.h"
#import "TSMessage.h"

@implementation HotelInfoCell
@synthesize responseItem;

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
    
    NSString *address=[responseItem objectForKeyNotNull:@"address"];
    self.labAddress.text=address;
    
    self.labTel.text=[responseItem objectForKeyNotNull:@"phone"];
}

+ (int)Height:(NSDictionary *)itemData{
    return 132;
}

//地图
- (IBAction)actMap:(id)sender {
    MapViewController *viewCtrl=[[MapViewController alloc]initWithNibName:@"MapViewController" bundle:nil];
    viewCtrl.lat=[responseItem objectForKeyNotNull:@"lat"];
    viewCtrl.lng=[responseItem objectForKeyNotNull:@"lng"];
    viewCtrl.title=[responseItem objectForKeyNotNull:@"title"];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

//手机
- (IBAction)actPhone:(id)sender {
    [parent phonecall:self.labTel.text];
}

//网页
- (IBAction)actWeb:(id)sender {
    
    NSString *url=[responseItem objectForKeyNotNull:@"url"];
    if (url.length==0 || [url isEqual:@"无"]) {
        [TSMessage showNotificationInViewController:parent title:@"当前酒店还没有网站" subtitle:nil type:TSMessageNotificationTypeError];
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

- (IBAction)actRoomList:(id)sender {
    HotelRoomListViewController *viewCtrl=[[HotelRoomListViewController alloc]initWithNibName:@"HotelRoomListViewController" bundle:nil];
    viewCtrl.HotelID=[responseItem objectForKeyNotNull:@"id"];
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

@end

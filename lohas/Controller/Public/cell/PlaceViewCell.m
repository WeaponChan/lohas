//
//  PlaceViewCell.m
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "PlaceViewCell.h"
#import "FoodListViewController.h"
#import "HotelListViewController.h"
#import "SceneryListViewController.h"
#import "CountryListViewController.h"
#import "ShopListViewController.h"
#import "ReviewsListViewController.h"
#import "EventListViewController.h"
#import "HotelSearchSuperViewController.h"
#import "WapViewController.h"

@implementation PlaceViewCell{
    CLLocationCoordinate2D cl2DLocation;
    CLLocation *location;
}
@synthesize type,selID,infoItem;

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
    
    NSString *lat=[infoItem objectForKeyNotNull:@"lat"];
    NSString *lng=[infoItem objectForKeyNotNull:@"lng"];
    cl2DLocation.latitude=lat.doubleValue;
    cl2DLocation.longitude=lng.doubleValue;
    
    location=[self constructWithCoordinate:cl2DLocation];
    
    if (!location) {
        location=[AppDelegate sharedAppDelegate].ownLocation;
    }
}

- (CLLocation *)constructWithCoordinate:(CLLocationCoordinate2D)coordinate {
    return [[CLLocation alloc] initWithLatitude:coordinate.latitude longitude:coordinate.longitude];
}


+ (int)Height:(NSDictionary *)itemData{
    return 344;
}

- (IBAction)actCommentMore:(id)sender {
    ReviewsListViewController *viewCtrl=[[ReviewsListViewController alloc]initWithNibName:@"ReviewsListViewController" bundle:nil];
    viewCtrl.type=type;
    viewCtrl.seID=selID;
    
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actFood:(id)sender {
    FoodListViewController *viewCtrl=[[FoodListViewController alloc]initWithNibName:@"FoodListViewController" bundle:nil];
    viewCtrl.lat=location.coordinate.latitude;
    viewCtrl.lng=location.coordinate.longitude;
    viewCtrl.isNext=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actHotel:(id)sender {
//    HotelListViewController *viewCtrl=[[HotelListViewController alloc]initWithNibName:@"HotelListViewController" bundle:nil];
//    viewCtrl.location=location;
//    viewCtrl.isNext=YES;
//    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
    HotelSearchSuperViewController*viewCtrl=[[HotelSearchSuperViewController alloc]initWithNibName:@"HotelSearchSuperViewController" bundle:nil];
    viewCtrl.location = location;
    viewCtrl.isNext = YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actScenery:(id)sender {
    SceneryListViewController *viewCtrl=[[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
    viewCtrl.lat=location.coordinate.latitude;
    viewCtrl.lng=location.coordinate.longitude;
    viewCtrl.isNext=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actCountry:(id)sender {
    CountryListViewController *viewCtrl=[[CountryListViewController alloc]initWithNibName:@"CountryListViewController" bundle:nil];
    viewCtrl.lat=location.coordinate.latitude;
    viewCtrl.lng=location.coordinate.longitude;
    viewCtrl.isNext=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actShopping:(id)sender {
    ShopListViewController *viewCtrl=[[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
    viewCtrl.lat=location.coordinate.latitude;
    viewCtrl.lng=location.coordinate.longitude;
    viewCtrl.isNext=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actEvent:(id)sender {
    EventListViewController *viewCtrl=[[EventListViewController alloc]initWithNibName:@"EventListViewController" bundle:nil];
    viewCtrl.lat=location.coordinate.latitude;
    viewCtrl.lng=location.coordinate.longitude;
    viewCtrl.isNext=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

//团购美食
- (IBAction)actTuangou:(id)sender {
    WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"团购美食";
    viewCtrl.linkStr=@"http://lite.m.dianping.com/ASAXlqzged";
    [parent.navigationController pushViewController:viewCtrl animated:TRUE];
}

//购买门票
- (IBAction)actBuymenpiao:(id)sender {
    WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"购买门票";
    viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=2&Allianceid=26524&sid=467134&OUID=&jumpUrl=http://piao.ctrip.com/";
    [parent.navigationController pushViewController:viewCtrl animated:NO];
}


@end

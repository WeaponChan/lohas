//
//  NearViewController.m
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "NearViewController.h"
#import "FoodListViewController.h"
#import "HotelListViewController.h"
#import "SceneryListViewController.h"
#import "CountryListViewController.h"
#import "ShopListViewController.h"
#import "EventListViewController.h"
#import "HotelSearchSuperViewController.h"
#import "WapViewController.h"

@interface NearViewController (){
    CLLocation *currentLocation;
    
    double bd_lon;
    double bd_lat;
}

@end

@implementation NearViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarTitle:@"附近"];
    // Do any additional setup after loading the view from its nib.
    [self getLocation];
}

-(void)callBackByLocation:(CLLocation *)newLocation{
    currentLocation=newLocation;
    
    double gg_lon=currentLocation.coordinate.longitude;
    double gg_lat=currentLocation.coordinate.latitude;
    
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    double x = gg_lon, y = gg_lat;
    
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    
     bd_lon = z * cos(theta) + 0.0065;
    
     bd_lat = z * sin(theta) + 0.006;
    
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//餐厅
- (IBAction)actFood:(id)sender {
    FoodListViewController *viewCtrl=[[FoodListViewController alloc]initWithNibName:@"FoodListViewController" bundle:nil];
    viewCtrl.isNext=YES;
    viewCtrl.lat=bd_lat;
    viewCtrl.lng=bd_lon;
    viewCtrl.searchTitle=@"";
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actHotel:(id)sender {
  /*  HotelListViewController *viewCtrl=[[HotelListViewController alloc]initWithNibName:@"HotelListViewController" bundle:nil];
    viewCtrl.location=currentLocation;
    viewCtrl.isNext=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];*/
    
    HotelSearchSuperViewController *viewCtrl=[[HotelSearchSuperViewController alloc]initWithNibName:@"HotelSearchSuperViewController" bundle:nil];
    viewCtrl.location = currentLocation;
    viewCtrl.isNext = YES;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];

}

- (IBAction)actView:(id)sender {
    SceneryListViewController *viewCtrl=[[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
    viewCtrl.lat=bd_lat;
    viewCtrl.lng=bd_lon;
    viewCtrl.isNext=YES;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];

}

- (IBAction)actTravel:(id)sender {
    CountryListViewController *viewCtrl=[[CountryListViewController alloc]initWithNibName:@"CountryListViewController" bundle:nil];
    viewCtrl.lat=bd_lat;
    viewCtrl.lng=bd_lon;
    viewCtrl.isNext=YES;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];

}

- (IBAction)actShopping:(id)sender {
    ShopListViewController *viewCtrl=[[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
     viewCtrl.isNext=YES;
    viewCtrl.lat=bd_lat;
    viewCtrl.lng=bd_lon;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];

}

//活动
- (IBAction)actEvent:(id)sender {
    EventListViewController *viewCtrl=[[EventListViewController alloc]initWithNibName:@"EventListViewController" bundle:nil];
    viewCtrl.isNext=YES;
    viewCtrl.lat=bd_lat;
    viewCtrl.lng=bd_lon;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//购买门票
- (IBAction)actSceneryMenpiao:(id)sender {
    WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"购买门票";
    viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=2&Allianceid=26524&sid=467134&OUID=&jumpUrl=http://piao.ctrip.com/";
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:NO];
}

//团购美食
- (IBAction)actTuangou:(id)sender {
    WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"团购美食";
    viewCtrl.linkStr=@"http://lite.m.dianping.com/ASAXlqzged";
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
}

@end

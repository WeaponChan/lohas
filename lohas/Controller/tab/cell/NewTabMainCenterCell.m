//
//  NewTabMainCenterCell.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "NewTabMainCenterCell.h"
#import "SceneryListViewController.h"
#import "FoodListViewController.h"
#import "CountryListViewController.h"
#import "HotelSearchSuperViewController.h"
#import "EventListViewController.h"
#import "TopListViewController.h"
#import "ShopListViewController.h"
#import "WapViewController.h"
#import "WapFlightViewController.h"

@implementation NewTabMainCenterCell{
    double bd_lon;
    double bd_lat;
    
    NSString *cityId;
}

- (void)update:(NSDictionary *)itemData Parent:(MSViewController *)parentCtrl{
    [super update:itemData Parent:parentCtrl];
    
    double gg_lon=[AppDelegate sharedAppDelegate].ownLocation.coordinate.longitude;
    double gg_lat=[AppDelegate sharedAppDelegate].ownLocation.coordinate.latitude;
    
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    double x = gg_lon, y = gg_lat;
    
    double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
    
    double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
    
    bd_lon = z * cos(theta) + 0.0065;
    
    bd_lat = z * sin(theta) + 0.006;

    cityId=[[NSUserDefaults standardUserDefaults]objectForKey:@"cityID"];
}

+ (int)Height:(NSDictionary *)itemData{
    return 250;
}

- (IBAction)actFood:(id)sender {
    
    FoodListViewController *viewCtrl=[[FoodListViewController alloc]initWithNibName:@"FoodListViewController" bundle:nil];
    viewCtrl.searchCityID=cityId;
    viewCtrl.lat=bd_lat;
    viewCtrl.lng=bd_lon;
    viewCtrl.searchCategoryID=@"";
    viewCtrl.backBtnList=nil;
    viewCtrl.searchTitle=@"";
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
}

- (IBAction)actTranspot:(id)sender {
    
//    NSString* ECode=@"BJS";
//    NSString* SCode=@"SHA";
//    NSString *scity = @"上海";
//    NSString *ecity = @"北京";
//    NSString* interval = @"0";
//    
//    [[NSUserDefaults standardUserDefaults]setObject:scity forKey:@"FJSCity"];
//    [[NSUserDefaults standardUserDefaults]setObject:ecity forKey:@"FJECity"];
//    [[NSUserDefaults standardUserDefaults]setObject:SCode forKey:@"FJSCode"];
//    [[NSUserDefaults standardUserDefaults]setObject:ECode forKey:@"FJECode"];
//    [[NSUserDefaults standardUserDefaults]synchronize];
//    
//    NSString *urlStr;
//    NSString *interFlag;
//   /* //国际
//    if (SFlag.intValue==1 || EFlag.intValue==1) {
//        urlStr=[NSString stringWithFormat:@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=617&dcityname=bjs&acityname=tyo&dcitycode=%@&acitycode=%@&ddate=%@&rdays=&flightway=single&flighttype=all&sid=467134&allianceid=26524&ouid=&sourceid=",SCode,ECode,interval];
//        interFlag=@"1";
//    }
//    //国内
//    else{*/
//        urlStr=[NSString stringWithFormat:@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=610&depart=%@&arrive=%@&afterdays=%@&sid=467134&allianceid=26524&ouid=",SCode,ECode,interval];
//        interFlag=@"0";
//   // }
//    
//    // http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=610&depart=beijing&arrive=shanghai&sid=467134&allianceid=26524&ouid=
//    
//    //http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=610&TrainNO=&departdatetime=&depart=beijing&arrive=shanghai&sourceid=1&sid=467134&allianceid=26524&ouid=
//    
//    NSLog(@"urlStr====%@",urlStr);
//    
//    WapViewController *viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
//    viewCtrl.linkStr=urlStr;
//    viewCtrl.title=[NSString stringWithFormat:@"%@-%@",scity,ecity];
//    viewCtrl.categoryStr=@"flights";
//    viewCtrl.interNationFlag=interFlag;
//    viewCtrl.scode=SCode;
//    viewCtrl.ecode=ECode;
//    viewCtrl.ecity=scity;
//    viewCtrl.scity=ecity;
//    viewCtrl.isFlight=YES;
//    viewCtrl.hidesBottomBarWhenPushed=YES;
//    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
    WapFlightViewController*viewCtrl=[[WapFlightViewController alloc]initWithNibName:@"WapFlightViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"飞机票";
    //viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=671&TrainNO=&departdatetime=&astationpin=beijing&dstationpin=shanghai&sourceid=1&sid=467134&allianceid=26524&ouid=";
    viewCtrl.linkStr=@"http://m.ctrip.com/webapp/flight/?allianceid=26524&sid=467134&sourceid=2055";
    [parent.navigationController pushViewController:viewCtrl animated:TRUE];
    
    
}

- (IBAction)actScenery:(id)sender {
    
    SceneryListViewController *viewCtrl=[[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
    viewCtrl.searchcityID=cityId;
    viewCtrl.searchTitle=@"";
    viewCtrl.lat=bd_lat;
    viewCtrl.lng=bd_lon;
    viewCtrl.categoryID=@"";
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
    
}

- (IBAction)actHotel:(id)sender {
    HotelSearchSuperViewController *viewCtrl=[[HotelSearchSuperViewController alloc]initWithNibName:@"HotelSearchSuperViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actCountry:(id)sender {
    CountryListViewController *viewCtrl=[[CountryListViewController alloc]initWithNibName:@"CountryListViewController" bundle:nil];
    viewCtrl.searchCityID=cityId;
    viewCtrl.typeID=@"";
    viewCtrl.searchText=@"";
    viewCtrl.lat=bd_lat;
    viewCtrl.lng=bd_lon;
    viewCtrl.searchCategoryID=@"";
    viewCtrl.backBtnList=nil;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actEvent:(id)sender {
    EventListViewController *viewCtrl=[[EventListViewController alloc]initWithNibName:@"EventListViewController" bundle:nil];
    viewCtrl.categoryId=@"";
    viewCtrl.title=@"";
    viewCtrl.backBtnList=nil;
    viewCtrl.lat=bd_lat;
    viewCtrl.lng=bd_lon;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actShop:(id)sender {
    ShopListViewController *viewCtrl=[[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
    viewCtrl.city_id=cityId;
    viewCtrl.type_id=@"";
    viewCtrl.searchText=@"";
    viewCtrl.lat=bd_lat;
    viewCtrl.lng=bd_lon;
    viewCtrl.backBtnList=nil;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [parent.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actTop:(id)sender {
    TopListViewController*viewCtrl=[[TopListViewController alloc]initWithNibName:@"TopListViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    [parent.navigationController pushViewController:viewCtrl animated:TRUE];
}
@end

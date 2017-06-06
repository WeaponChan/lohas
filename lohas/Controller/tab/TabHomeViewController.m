//
//  TabHomeViewController.m
//  chuanmei
//
//  Created by juyuan on 14-8-13.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "TabHomeViewController.h"
#import "NearViewController.h"
#import "SearchViewController.h"
#import "FoodListViewController.h"
#import "HotelSearchViewController.h"
#import "SceneryListViewController.h"
#import "FlightsListViewController.h"
#import "ShopListViewController.h"
#import "TopListViewController.h"
#import "RaidersReadListViewController.h"
#import "UserMyViewController.h"
#import "CountryListViewController.h"
#import "FlightsSearchViewController.h"
#import "RaidersListViewController.h"
#import "CityListViewController.h"
#import "EventListViewController.h"
#import "FoodSearchViewController.h"
#import "ScenerySearchViewController.h"
#import "CountrySearchViewController.h"
#import "ShopSearchViewController.h"
#import "EventSearchViewController.h"
#import "WapViewController.h"
#import "HotelSearchSuperViewController.h"
#import "UserSignupViewController.h"
#import "HotelListViewController.h"
#import "WapFlightViewController.h"
#import "TSMessage.h"

@interface TabHomeViewController (){
    CLLocation *currentLocation;
    NSString *selectCityID;
    NSString *typeID;
    int rangeType;
    NSString *category_id;
    NSArray *backBtnList;
    NSString *selectTitle;
    
    NSMutableArray* menuList;
    NSMutableArray *selectBtn;
    UIButton *InButton;
    BOOL selectBtnOther;
    
    NSString *SCode;
    NSString *ECode;
    NSString *interval;
    NSString *nowDate;
    NSString *SFlag;
    NSString *EFlag;
    
    
    //NSMutableArray* menuList;
    UIButton *selectStarBtn;
    NSString *min;
    NSString *max;
    UIButton *selectPriceBtn;
    
    
    UISegmentedControl *mySegment;
}


@end

@implementation TabHomeViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

-(void) viewDidAppear:(BOOL)animated
{
    //[super viewDidAppear:animated];
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    [self setNavBarTitle:@"乐活旅行"];
    [self addNavBar_RightBtn:@"navbar_search.png"  action:@selector(OnRightButton:)];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self.scrollView addSubview:self.viewBtn];
    int top=self.viewBanner.frame.size.height;
    
    top = [MSViewFrameUtil setTop:top UI:self.viewBtn];
    self.scrollView.contentSize = CGSizeMake(320, SCREENHEIGHT-50);
    
    NSString *isFirstShow=[[NSUserDefaults standardUserDefaults]objectForKey:@"isFirstShow"];
    if (isFirstShow.length==0 || !isFirstShow) {
        [self.navigationController.view addSubview:self.viewFirstShow];
        
        [MSViewFrameUtil setWidth:SCREENWIDTH UI:self.viewFirstShow];
        [MSViewFrameUtil setHeight:SCREENHEIGHT UI:self.viewFirstShow];
        
    }else if([AppDelegate sharedAppDelegate].isFirstIn){
        [AppDelegate sharedAppDelegate].isFirstIn=NO;
        
        if (![self isLogin]) {
            [[AppDelegate sharedAppDelegate]presentToLoginView:self];            
        }
    }
    
    //初始化头部
    self.navigationItem.titleView = self.viewNavbarTitle;
    [self.viewNavbarTitle setHidden:false];
    [self.viewNavbarTitle setBackgroundColor:[UIColor clearColor]];
    self.btnCity.hidden=YES;
    
    //banner
    bannerView = (BannerView *)[self newViewWithNibNamed:@"BannerView" owner:self];
    [self.viewBanner addSubview:bannerView];
    [bannerView initial:self];
    
   /*   NSMutableArray* bannerResponse = [[NSMutableArray alloc]init];
    NSDictionary* dict;

    dict = [NSDictionary dictionaryWithObject:@"http://upload.17u.com/uploadfile/2015/03/03/33/2015030313445413384.jpg" forKey:@"image"];
    [bannerResponse addObject:dict];
    
    dict = [NSDictionary dictionaryWithObject:@"http://upload.17u.com/uploadfile/2015/02/25/33/2015022515064028581.jpg" forKey:@"image"];
    [bannerResponse addObject:dict];
    
    dict = [NSDictionary dictionaryWithObject:@"http://upload.17u.com/uploadfile/2015/03/05/33/2015030517090832716.jpg" forKey:@"image"];
    [bannerResponse addObject:dict];
    
    dict = [NSDictionary dictionaryWithObject:@"http://img1.40017.cn/cn/zt/product/20150304/pinzhuan.jpg" forKey:@"image"];
    [bannerResponse addObject:dict];*/
    
    //[bannerView reload:bannerResponse];
    
    //scrollView
    
   // NSLog(@"UIScrollViewDecelerationRateFast: %@", _scrollView);
    //=============================
    [self.btnNear addBtnAction:@selector(actNear:) target:self];
    [self.btnFood addBtnAction:@selector(actFood:) target:self];
    [self.btnFlights addBtnAction:@selector(actFlights:) target:self];
    //=============================
    [self.btnScenery addBtnAction:@selector(actScenery:) target:self];
    [self.btnCountry addBtnAction:@selector(actCountry:) target:self];
    [self.btnHotel addBtnAction:@selector(actHotel:) target:self];
    //=============================
    [self.btnEvent addBtnAction:@selector(actEvent:) target:self];
    [self.btnTop addBtnAction:@selector(actTop:) target:self];
    //=============================
    [self.btnShoping addBtnAction:@selector(actShoping:) target:self];
    [self.btnMy addBtnAction:@selector(actMy:) target:self];

    BOOL cityIsHave=[[AppDelegate sharedAppDelegate] hasCity];
    
    if (cityIsHave) {
        [self setCityBtn];
        [self getAdvertiseList];
    }
    
    [self getLocation];
    
    [self checkVersion];
    
}

-(void)checkVersion{
    Api *api = [[Api alloc] init:self tag:@"version"];
    [api version:@"1023257602"];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if (buttonIndex==alertView.cancelButtonIndex) {
        return;
    }
    
    if (alertView.tag==1) {

        UserSignupViewController *viewCtrl=[[UserSignupViewController alloc]initWithNibName:@"UserSignupViewController" bundle:nil];
        UINavigationController *navCtrl = [[UINavigationController alloc] initWithRootViewController:viewCtrl];
        [self presentViewController:navCtrl animated:YES completion:nil];
        
    }
    else  if(alertView.tag==2) {
        [self appStore_openApp];
        return;
    }
    
}

//获取滚动广告
-(void)getAdvertiseList{
    
    NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"ad_list"];
    [api ad_list:cityId];
}

//设置城市按钮
-(void)setCityBtn{
    self.btnCity.hidden=NO;
    NSString *cityName = [[AppDelegate sharedAppDelegate] getCityName];
    
    if (!cityName) {
        return;
    }
    
    int length = cityName.length;
    [self.btnCity setTitle:cityName forState:UIControlStateNormal];
    int left = 0 - (5-length)*14 -60;
    
    if (SCREENWIDTH>=414) {
         left = 0 - (5-length)*14 -90;
        [MSViewFrameUtil setLeft:3 UI:self.labMainTitle];
    }
    NSLog(@"screenWidth====%f",SCREENWIDTH);
    
    [MSViewFrameUtil setLeft:left UI:self.btnCity];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"ad_list"]) {
        
        [bannerView reload:response];
        
    }
    else if ([tag isEqual:@"get_gsp_city"]){
        NSString *cityID=[response objectForKeyNotNull:@"city_id"];
        NSString *name=[response objectForKeyNotNull:@"name"];
        [[AppDelegate sharedAppDelegate] setCityByName:name ID:cityID];
        
        [self setCityBtn];
        [self getAdvertiseList];
    }
    else if([@"version" isEqualToString:tag]) {
        
        NSArray *configData = [response objectForKeyNotNull:@"results"];
        
        for (id config in configData)
        {
            NSString* version = [config objectForKeyNotNull:@"version"];
            NSString* cversion = [self getVersion];
            
            NSLog(@"version=%@, cversion=%@", version, cversion);
            
            if(version && [version compare:cversion]==NSOrderedDescending) {
                [self showAlert:@"有新版本, 现在前往App Store更新吗?" message:nil tag:2];
            } else {
                // [self showMessage:@"当前使用的是最新的版本"];
            }
        }
    }

}

-(void)callBackByLocation:(CLLocation *)newLocation{
    [AppDelegate sharedAppDelegate].ownLocation=newLocation;
    
    BOOL cityIsHave=[[AppDelegate sharedAppDelegate] hasCity];
    
    if (!cityIsHave && newLocation) {
        
        Api *api=[[Api alloc]init:self tag:@"get_gsp_city"];
        [api get_gsp_city:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] lng:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude]];
    }else if(!cityIsHave && !newLocation){
        
        [[AppDelegate sharedAppDelegate] setCityByName:@"上海" ID:@"2"];
        
        [self setCityBtn];
        [self getAdvertiseList];
        
    }
}

-(void)OnRightButton:(id)sender
{
  /*  if ([self isNeedGetCity]) {
        [self actSelectCity:nil];
        return;
    }*/
    
    SearchViewController*viewCtrl=[[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//=============================
//附近
- (void)actNear:(id)sender {
  /*  if ([self isNeedGetCity]) {
        [self actSelectCity:nil];
        return;
    }*/
   
      NearViewController *viewCtrl=[[NearViewController alloc]initWithNibName:@"NearViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewCtrl animated:TRUE];                
}
//餐厅
- (void)actFood:(id)sender {
    
   /* if ([self isNeedGetCity]) {
        [self actSelectCity:nil];
        return;
    }*/

    //FoodSearchViewController *viewCtrl=[[FoodSearchViewController alloc]initWithNibName:@"FoodSearchViewController" bundle:nil];
    //    viewCtrl.hidesBottomBarWhenPushed = YES;
    //    viewCtrl.isListBack=YES;
    //    [self.navigationController pushViewController:viewCtrl animated:TRUE];
    
    NSString *categoryID=@"";
    for (UIButton *btn in selectBtn) {
        int tag=btn.tag;
        
        
        NSDictionary *dic = menuList[tag];
        NSString *sID=[dic objectForKeyNotNull:@"id"];
        if (categoryID.length==0) {
            categoryID=sID;
        }else{
            categoryID=[NSString stringWithFormat:@"%@,%@",categoryID,sID];
        }
    }
   
        double gg_lon=currentLocation.coordinate.longitude;
        double gg_lat=currentLocation.coordinate.latitude;
        
        double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
        double x = gg_lon, y = gg_lat;
        
        double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
        
        double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
        
        double bd_lon = z * cos(theta) + 0.0065;
        
        double bd_lat = z * sin(theta) + 0.006;
        
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        
        FoodListViewController *viewCtrl=[[FoodListViewController alloc]initWithNibName:@"FoodListViewController" bundle:nil];
        viewCtrl.searchCityID=cityId;
        viewCtrl.lat=bd_lat;
        viewCtrl.lng=bd_lon;
        viewCtrl.searchCategoryID=categoryID;
        viewCtrl.backBtnList=backBtnList;
        viewCtrl.searchTitle=@"";
        [self.navigationController pushViewController:viewCtrl animated:YES];

    
}

//飞机
- (void)actFlights:(id)sender {
   /* if ([self isNeedGetCity]) {
        [self actSelectCity:nil];
        return;
    }*/
    
   /*
    FlightsSearchViewController*viewCtrl=[[FlightsSearchViewController alloc]initWithNibName:@"FlightsSearchViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
    */
    
    
    WapFlightViewController*viewCtrl=[[WapFlightViewController alloc]initWithNibName:@"WapFlightViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"飞机票";
    //viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=671&TrainNO=&departdatetime=&astationpin=beijing&dstationpin=shanghai&sourceid=1&sid=467134&allianceid=26524&ouid=";
    viewCtrl.linkStr=@"http://m.ctrip.com/webapp/flight/?allianceid=26524&sid=467134&sourceid=2055";
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
   
    
    
   /*
    ECode=@"BJS";
    SCode=@"SHA";
    NSString *scity = @"上海";
    NSString *ecity = @"北京";
    interval = @"0";
    
    [[NSUserDefaults standardUserDefaults]setObject:scity forKey:@"FJSCity"];
    [[NSUserDefaults standardUserDefaults]setObject:ecity forKey:@"FJECity"];
    [[NSUserDefaults standardUserDefaults]setObject:SCode forKey:@"FJSCode"];
    [[NSUserDefaults standardUserDefaults]setObject:ECode forKey:@"FJECode"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *urlStr;
    NSString *interFlag;
    //国际
    if (SFlag.intValue==1 || EFlag.intValue==1) {
        urlStr=[NSString stringWithFormat:@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=617&dcityname=bjs&acityname=tyo&dcitycode=%@&acitycode=%@&ddate=%@&rdays=&flightway=single&flighttype=all&sid=467134&allianceid=26524&ouid=&sourceid=",SCode,ECode,interval];
        interFlag=@"1";
    }
    //国内
    else{
        urlStr=[NSString stringWithFormat:@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=610&depart=%@&arrive=%@&afterdays=%@&sid=467134&allianceid=26524&ouid=",SCode,ECode,interval];
        interFlag=@"0";
    }
    

    
    NSLog(@"urlStr====%@",urlStr);
    
    WapViewController *viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.linkStr=urlStr;
    viewCtrl.title=[NSString stringWithFormat:@"%@-%@",scity,ecity];
    viewCtrl.categoryStr=@"flights";
    viewCtrl.interNationFlag=interFlag;
    viewCtrl.scode=SCode;
    viewCtrl.ecode=ECode;
    viewCtrl.ecity=scity;
    viewCtrl.scity=ecity;
    viewCtrl.isFlight=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
   */
  
    
}

//=============================
//景点
- (void)actScenery:(id)sender {
   /* if ([self isNeedGetCity]) {
        [self actSelectCity:nil];
        return;
    }*/
    
//    ScenerySearchViewController *viewCtrl=[[ScenerySearchViewController alloc]initWithNibName:@"ScenerySearchViewController" bundle:nil];
//
//    viewCtrl.hidesBottomBarWhenPushed = YES;
//    viewCtrl.isListBack=YES;
//    [self.navigationController pushViewController:viewCtrl animated:TRUE];
    
    NSString *categoryID;
    for (UIButton *btn in selectBtn) {
        int tag=btn.tag;
        
        NSDictionary *dic = menuList[tag];
        NSString *sID=[dic objectForKeyNotNull:@"id"];
        if (categoryID.length==0) {
            categoryID=sID;
        }else{
            categoryID=[NSString stringWithFormat:@"%@,%@",categoryID,sID];
        }
    }
    
    if (categoryID.length==0) {
        categoryID=@"";
    }
        
        double gg_lon=currentLocation.coordinate.longitude;
        double gg_lat=currentLocation.coordinate.latitude;
        
        double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
        double x = gg_lon, y = gg_lat;
        
        double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
        
        double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
        
        double bd_lon = z * cos(theta) + 0.0065;
        
        double bd_lat = z * sin(theta) + 0.006;
        
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        
        SceneryListViewController *viewCtrl=[[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
        viewCtrl.searchcityID=cityId;
        viewCtrl.searchTitle=@"";
        viewCtrl.lat=bd_lat;
        viewCtrl.lng=bd_lon;
        viewCtrl.categoryID=categoryID;
        [self.navigationController pushViewController:viewCtrl animated:YES];
       
}

//乡村游
- (void)actCountry:(id)sender {
   /* if ([self isNeedGetCity]) {
        [self actSelectCity:nil];
        return;
    }*/
    
//    CountrySearchViewController*viewCtrl=[[CountrySearchViewController alloc]initWithNibName:@"CountrySearchViewController" bundle:nil];
//    viewCtrl.hidesBottomBarWhenPushed = YES;
//    viewCtrl.isListBack=YES;
//    [self.navigationController pushViewController:viewCtrl animated:TRUE];
    NSString *categoryID;
    for (UIButton *btn in selectBtn) {
        int tag=btn.tag;
        
        NSDictionary *dic = menuList[tag];
        NSString *sID=[dic objectForKeyNotNull:@"id"];
        if (categoryID.length==0) {
            categoryID=sID;
        }else{
            categoryID=[NSString stringWithFormat:@"%@,%@",categoryID,sID];
        }
    }
    
    if (categoryID.length==0) {
        categoryID=@"";
    }
    
        double gg_lon=currentLocation.coordinate.longitude;
        double gg_lat=currentLocation.coordinate.latitude;
        
        double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
        double x = gg_lon, y = gg_lat;
        
        double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
        
        double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
        
        double bd_lon = z * cos(theta) + 0.0065;
        
        double bd_lat = z * sin(theta) + 0.006;
        
        CountryListViewController *viewCtrl=[[CountryListViewController alloc]initWithNibName:@"CountryListViewController" bundle:nil];
        viewCtrl.searchCityID=selectCityID;
        viewCtrl.typeID=typeID;
        viewCtrl.searchText=@"";
        viewCtrl.lat=bd_lat;
        viewCtrl.lng=bd_lon;
        viewCtrl.searchCategoryID=categoryID;
        viewCtrl.backBtnList=backBtnList;
        [self.navigationController pushViewController:viewCtrl animated:YES];
  
}

//酒店
- (void)actHotel:(id)sender {
    
    HotelSearchSuperViewController *viewCtrl=[[HotelSearchSuperViewController alloc]initWithNibName:@"HotelSearchSuperViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
    
   /* WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"酒店查询";
    viewCtrl.linkStr=@"https://brands.datahc.com/?a_aid=135541&brandid=413093&languageCode=CS&&mobile=1";
    [self.navigationController pushViewController:viewCtrl animated:TRUE];*/
    
    
    /*if ([self isNeedGetCity]) {
        [self actSelectCity:nil];
        return;
    }*/
    
    /*HotelSearchViewController *viewCtrl=[[HotelSearchViewController alloc]initWithNibName:@"HotelSearchViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.isListBack=YES;
    [self.navigationController pushViewController:viewCtrl animated:TRUE];*/
    
}
//=============================
//活动
- (void)actEvent:(id)sender {
//    EventSearchViewController*viewCtrl=[[EventSearchViewController alloc]initWithNibName:@"EventSearchViewController" bundle:nil];
//    viewCtrl.hidesBottomBarWhenPushed = YES;
//    viewCtrl.isListBack=YES;
//    [self.navigationController pushViewController:viewCtrl animated:TRUE];
    
    NSString *categoryID;
    for (UIButton *btn in selectBtn) {
        int tag=btn.tag;
        
        NSDictionary *dic = menuList[tag];
        NSString *sID=[dic objectForKeyNotNull:@"id"];
        if (categoryID.length==0) {
            categoryID=sID;
        }else{
            categoryID=[NSString stringWithFormat:@"%@,%@",categoryID,sID];
        }
    }
    
    if (categoryID.length==0) {
        categoryID=@"";
    }
    
    
        double gg_lon=currentLocation.coordinate.longitude;
        double gg_lat=currentLocation.coordinate.latitude;
        
        double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
        double x = gg_lon, y = gg_lat;
        
        double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
        
        double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
        
        double bd_lon = z * cos(theta) + 0.0065;
        
        double bd_lat = z * sin(theta) + 0.006;
        
        
        EventListViewController *viewCtrl=[[EventListViewController alloc]initWithNibName:@"EventListViewController" bundle:nil];
        viewCtrl.categoryId=categoryID;
        viewCtrl.title=@"";
        viewCtrl.backBtnList=backBtnList;
        viewCtrl.lat=bd_lat;
        viewCtrl.lng=bd_lon;
        [self.navigationController pushViewController:viewCtrl animated:YES];

    
}

- (void)actTop:(id)sender {
   /* if ([self isNeedGetCity]) {
        [self actSelectCity:nil];
        return;
    }*/
    
    TopListViewController*viewCtrl=[[TopListViewController alloc]initWithNibName:@"TopListViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
}
//=============================
//购物
- (void)actShoping:(id)sender {
    
  /*  if ([self isNeedGetCity]) {
        [self actSelectCity:nil];
        return;
    }*/
    
//    ShopSearchViewController*viewCtrl=[[ShopSearchViewController alloc]initWithNibName:@"ShopSearchViewController" bundle:nil];
//    viewCtrl.hidesBottomBarWhenPushed = YES;
//    viewCtrl.isListBack=YES;
//    [self.navigationController pushViewController:viewCtrl animated:TRUE];
    
    NSString *categoryID;
    for (UIButton *btn in selectBtn) {
        int tag=btn.tag;
        
        NSDictionary *dic = menuList[tag];
        NSString *sID=[dic objectForKeyNotNull:@"id"];
        if (categoryID.length==0) {
            categoryID=sID;
        }else{
            categoryID=[NSString stringWithFormat:@"%@,%@",categoryID,sID];
        }
    }
    
    if (categoryID.length==0) {
        categoryID=@"";
    }
  

        
        double gg_lon=currentLocation.coordinate.longitude;
        double gg_lat=currentLocation.coordinate.latitude;
        
        double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
        double x = gg_lon, y = gg_lat;
        
        double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
        
        double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
        
        double bd_lon = z * cos(theta) + 0.0065;
        
        double bd_lat = z * sin(theta) + 0.006;
        
        ShopListViewController *viewCtrl=[[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
        viewCtrl.city_id=selectCityID;
        viewCtrl.type_id=categoryID;
        viewCtrl.searchText=@"";
        viewCtrl.lat=bd_lat;
        viewCtrl.lng=bd_lon;
        viewCtrl.backBtnList=backBtnList;
        [self.navigationController pushViewController:viewCtrl animated:YES];
        

    
}
- (void)actMy:(id)sender {
    
    if (![self isLogin]) {
        [[AppDelegate sharedAppDelegate] presentToLoginView:self];
        return;
    }
    
    [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
    UserMyViewController*viewCtrl=[[UserMyViewController alloc]initWithNibName:@"UserMyViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
}

- (IBAction)actSelectCity:(id)sender {
    CityListViewController *viewCtrl=[[CityListViewController alloc]initWithNibName:@"CityListViewController" bundle:nil];
    viewCtrl.isRootView = false;
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
}

/*
-(BOOL)isNeedGetCity{
    
    NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
    
    if (cityId.length==0) {
        return YES;
    }else{
        return NO;
    }
}*/

- (IBAction)actKnow:(id)sender {
    [self.viewFirstShow removeFromSuperview];
    self.scrollView.scrollEnabled=YES;
    
    [[NSUserDefaults standardUserDefaults] setObject:@"NO" forKey:@"isFirstShow"];
    [[NSUserDefaults standardUserDefaults] synchronize];
    
    if (![self isLogin]) {
       /* UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"您当前还未注册账号" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"注册", nil];
        alert.tag=1;
        [alert show];*/
        
        [[AppDelegate sharedAppDelegate]presentToLoginView:self];
        
    }
    
}
@end

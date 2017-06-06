//
//  SelectAddressViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/4/6.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "SelectAddressViewController.h"


@interface SelectAddressViewController (){
    bool isGeoSearch;
    
    double lat;
    double lng;
    
    double ownlatitude;
    double ownlongitude;
    
    NSString *city;
    NSString *keyWord;
    
    BOOL isFirstIn;
}

@property(nonatomic,strong)CLGeocoder *geocoder;

@end

@implementation SelectAddressViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    _poisearch = [[BMKPoiSearch alloc]init];
    _geocoder = [[CLGeocoder alloc]init];
    _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _locService = [[BMKLocationService alloc]init];
    
  //  [self getLocation];
    
     self.textInfo.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"搜索附近的位置" attributes:@{NSForegroundColorAttributeName: [UIColor whiteColor]}];
    
    if ([AppDelegate sharedAppDelegate].selectAddress.length==0) {
        self.imageSelect.hidden=NO;
    }else{
        self.imageSelect.hidden=YES;
    }
    
    [self.mSelectAddressList setTableHeaderView:self.viewHead];
    
    [self setNavBarTitle:@"所在位置"];
    
    [self showLoadingView];
    [self startLocation];
}

//开始定位
-(void)startLocation{
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
}

/**
 *在地图View将要启动定位时，会调用此函数
 *@param mapView 地图View
 */
- (void)willStartLocatingUser
{
    NSLog(@"start locate");
}

/**
 *用户方向更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateUserHeading:(BMKUserLocation *)userLocation
{
    //[_mapView updateLocationData:userLocation];
    NSLog(@"heading is %@",userLocation.heading);
    
    ownlatitude=userLocation.location.coordinate.latitude;
    ownlongitude=userLocation.location.coordinate.longitude;
    
    if (ownlatitude>0) {
         [self onClickReverseGeocode];
         [self stopLocation];
        
    }else{
        
    }
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
        NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    
}

/**
 *在地图View停止定位后，会调用此函数
 *@param mapView 地图View
 */
- (void)didStopLocatingUser
{
    NSLog(@"stop locate");
}

/**
 *定位失败后，会调用此函数
 *@param mapView 地图View
 *@param error 错误号，参考CLError.h中定义的错误号
 */
- (void)didFailToLocateUserWithError:(NSError *)error
{
    NSLog(@"location error");
}


//停止定位
-(void)stopLocation
{
    [_locService stopUserLocationService];

}


-(void) onGetReverseGeoCodeResult:(BMKGeoCodeSearch *)searcher result:(BMKReverseGeoCodeResult *)result errorCode:(BMKSearchErrorCode)error
{

    NSLog(@"poiList===%@",result.poiList);
    if (result.poiList.count>0) {
        
        BMKPoiInfo *info=result.poiList[0];
        self.labCity.text=info.city;
        
        if ([[AppDelegate sharedAppDelegate].selectAddress isEqual:self.labCity.text]) {
            self.labTag.hidden=NO;
        }else{
            self.labTag.hidden=YES;
        }
        
    }
    
    [self closeLoadingView];
    
    self.mSelectAddressList.POIList=result.poiList;
    
    [self.mSelectAddressList initial:self];
    
}



-(void)onClickReverseGeocode
{
    isGeoSearch = false;
    
    CLLocationCoordinate2D pt = (CLLocationCoordinate2D){0, 0};
    pt = (CLLocationCoordinate2D){ownlatitude, ownlongitude};
    BMKReverseGeoCodeOption *reverseGeocodeSearchOption = [[BMKReverseGeoCodeOption alloc]init];
    reverseGeocodeSearchOption.reverseGeoPoint = pt;
    BOOL flag = [_geocodesearch reverseGeoCode:reverseGeocodeSearchOption];
    if(flag)
    {
        NSLog(@"反geo检索发送成功");
    }
    else
    {
        NSLog(@"反geo检索发送失败");
    }
}

-(void)viewWillAppear:(BOOL)animated {

    _poisearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate =self;
    _locService.delegate = self;
}

-(void)viewWillDisappear:(BOOL)animated {

    _poisearch.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil;
    _locService.delegate = nil;
}



- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actClickCity:(id)sender {
    
    [AppDelegate sharedAppDelegate].selectAddress=self.labCity.text;
    [self.navigationController popViewControllerAnimated:YES];
    
}

- (IBAction)actSearch:(id)sender {
    
    if (self.textInfo.text.length==0) {
        [self showAlert:@"请先填写关键字"];
        return;
    }
    
    self.mSelectAddressList.cityName=self.labCity.text;
    self.mSelectAddressList.searchStr=self.textInfo.text;
    self.mSelectAddressList.isSearch=YES;

    [self.mSelectAddressList refreshData];
    
    //[self onClickOk];
    
}

//在城市内部搜索

-(void)onClickOk
{
    curPage = 0;
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= self.labCity.text;
    citySearchOption.keyword = self.textInfo.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        NSLog(@"城市内检索发送成功");
    }
    else
    {
        
        NSLog(@"城市内检索发送失败");
    }
    
    
}

//内部搜索请求
-(void)onClickNextPage
{
    curPage++;
    //城市内检索，请求发送成功返回YES，请求发送失败返回NO
    BMKCitySearchOption *citySearchOption = [[BMKCitySearchOption alloc]init];
    citySearchOption.pageIndex = curPage;
    citySearchOption.pageCapacity = 10;
    citySearchOption.city= self.labCity.text;
    citySearchOption.keyword = self.textInfo.text;
    BOOL flag = [_poisearch poiSearchInCity:citySearchOption];
    if(flag)
    {
        
        NSLog(@"城市内检索发送成功");
    }
    else
    {
       
        NSLog(@"城市内检索发送失败");
    }
    
}


#pragma mark -
#pragma mark implement BMKSearchDelegate
- (void)onGetPoiResult:(BMKPoiSearch *)searcher result:(BMKPoiResult*)result errorCode:(BMKSearchErrorCode)error
{
    // 清楚屏幕中所有的annotation
    NSLog(@"result=====%@",result.poiInfoList);
    
    self.mSelectAddressList.count=result.poiInfoList.count;
    self.mSelectAddressList.POIList=result.poiInfoList;
    [self.mSelectAddressList refreshData];
    
    
    /*if (error == BMK_SEARCH_NO_ERROR) {
        NSMutableArray *annotations = [NSMutableArray array];
        for (int i = 0; i < result.poiInfoList.count; i++) {
            BMKPoiInfo* poi = [result.poiInfoList objectAtIndex:i];
            BMKPointAnnotation* item = [[BMKPointAnnotation alloc]init];
            item.coordinate = poi.pt;
            item.title = poi.name;
            [annotations addObject:item];
        }

    } else if (error == BMK_SEARCH_AMBIGUOUS_ROURE_ADDR){
        NSLog(@"起始点有歧义");
    } else {
        // 各种情况的判断。。。
    }*/
}




- (IBAction)actClick:(id)sender {
    [self.textInfo becomeFirstResponder];    
}
@end

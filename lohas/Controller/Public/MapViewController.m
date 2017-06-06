//
//  MapViewController.m
//  lohas
//
//  Created by fred on 15-3-12.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MapViewController.h"
#import "TSMessage.h"
#import "KCAnnotation.h"
#import <math.h>

#define MYBUNDLE_NAME @ "mapapi.bundle"
#define MYBUNDLE_PATH [[[NSBundle mainBundle] resourcePath] stringByAppendingPathComponent: MYBUNDLE_NAME]
#define MYBUNDLE [NSBundle bundleWithPath: MYBUNDLE_PATH]

@interface RouteAnnotation : BMKPointAnnotation
{
    int _type; ///<0:起点 1：终点 2：公交 3：地铁 4:驾乘 5:途经点
    int _degree;
}

@property (nonatomic) int type;
@property (nonatomic) int degree;
@end

@implementation RouteAnnotation

@synthesize type = _type;
@synthesize degree = _degree;
@end

@interface UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees;

@end

@implementation UIImage(InternalMethod)

- (UIImage*)imageRotatedByDegrees:(CGFloat)degrees
{
    
    CGFloat width = CGImageGetWidth(self.CGImage);
    CGFloat height = CGImageGetHeight(self.CGImage);
    
	CGSize rotatedSize;
    
    rotatedSize.width = width;
    rotatedSize.height = height;
    
	UIGraphicsBeginImageContext(rotatedSize);
	CGContextRef bitmap = UIGraphicsGetCurrentContext();
	CGContextTranslateCTM(bitmap, rotatedSize.width/2, rotatedSize.height/2);
	CGContextRotateCTM(bitmap, degrees * M_PI / 180);
	CGContextRotateCTM(bitmap, M_PI);
	CGContextScaleCTM(bitmap, -1.0, 1.0);
	CGContextDrawImage(bitmap, CGRectMake(-rotatedSize.width/2, -rotatedSize.height/2, rotatedSize.width, rotatedSize.height), self.CGImage);
	UIImage* newImage = UIGraphicsGetImageFromCurrentImageContext();
	UIGraphicsEndImageContext();
	return newImage;
}

@end


@interface MapViewController (){
    double ownlatitude;
    double ownlongitude;
    
    BOOL isFirstIN;
}

@end

@implementation MapViewController
@synthesize lat,lng,title,address;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (NSString*)getMyBundlePath1:(NSString *)filename
{
	
	NSBundle * libBundle = MYBUNDLE ;
	if ( libBundle && filename ){
		NSString * s=[[libBundle resourcePath ] stringByAppendingPathComponent : filename];
		return s;
	}
	return nil ;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"地图查看"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    self.btnGuideLine.layer.cornerRadius=4;
    [self.btnGuideLine setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnGuideLine addBtnAction:@selector(actGuideLine) target:self];
    
    //设置地图类型
    _mapView.mapType=MKMapTypeStandard;
    
    double bd_lon=lng.doubleValue;
    double bd_lat=lat.doubleValue;
    double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
    
    double x = bd_lon - 0.0065, y = bd_lat - 0.006;
    double z = sqrt(x * x + y * y) - 0.00002 * sin(y * x_pi);
    double theta = atan2(y, x) - 0.000003 * cos(x * x_pi);
    double gg_lon = z * cos(theta);
    double gg_lat = z * sin(theta);

    NSLog(@"bd_lon====%f,gg_lon====%f",bd_lon,gg_lon);
    lat=[NSString stringWithFormat:@"%f",gg_lat];
    lng=[NSString stringWithFormat:@"%f",gg_lon];
    
    [self addAnnotation];
    
  /*  _geocodesearch = [[BMKGeoCodeSearch alloc]init];
    _locService = [[BMKLocationService alloc]init];
    
    _mapView.zoomLevel=15;
    isFirstIN=YES;*/
    
}

/*
//反geo检索
-(void)viewWillAppear:(BOOL)animated{
    [_mapView viewWillAppear];
    _mapView.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _geocodesearch.delegate = self; // 此处记得不用的时候需要置nil，否则影响内存的释放
    _locService.delegate = self;
    
    if (isFirstIN) {
        isFirstIN=NO;
        [self addPointAnnotation];
    }
}

//添加标注
- (void)addPointAnnotation{

        BMKPointAnnotation* pointAnnotation = [[BMKPointAnnotation alloc]init];
        coordinateXY.latitude = [lat doubleValue];
        coordinateXY.longitude = [lng doubleValue];
        pointAnnotation.coordinate = coordinateXY;
        pointAnnotation.title=title;

        _mapView.centerCoordinate=coordinateXY;
        
        [_mapView addAnnotation:pointAnnotation];

}*/

/*
-(void)viewWillDisappear:(BOOL)animated {
    [_mapView viewWillDisappear];
    _mapView.delegate = nil; // 不用时，置nil
    _geocodesearch.delegate = nil; // 不用时，置nil
    _locService.delegate = nil;
}
*/

////地理编码：地名—>经纬度坐标
//- (void)geocode {
//    //1.获得输入的地址
//    
//    //2.开始地理编码
//    //说明：调用下面的方法开始编码，不管编码是成功还是失败都会调用block中的方法
//    [self.geocoder geocodeAddressString:address completionHandler:^(NSArray *placemarks, NSError *error) {
//        //如果有错误信息，或者是数组中获取的地名元素数量为0，那么说明没有找到
//        if (error || placemarks.count==0) {
//            NSLog(@"你输入的地址没找到，可能在月球上");
//        }else   //  编码成功，找到了具体的位置信息
//        {
//            //打印查看找到的所有的位置信息
//            /*
//             61                     name:名称
//             62                     locality:城市
//             63                     country:国家
//             64                     postalCode:邮政编码
//             65                  */
//            for (CLPlacemark *placemark in placemarks) {
//                NSLog(@"name=%@ locality=%@ country=%@ postalCode=%@",placemark.name,placemark.locality,placemark.country,placemark.postalCode);
//            }
//            
//            //取出获取的地理信息数组中的第一个显示在界面上
//            CLPlacemark *firstPlacemark=[placemarks firstObject];
//            //详细地址名称
//            //self.detailAddressLabel.text=firstPlacemark.name;
//            //纬度
//            CLLocationDegrees latitude1=firstPlacemark.location.coordinate.latitude;
//            //经度
//            CLLocationDegrees longitude1=firstPlacemark.location.coordinate.longitude;
//            lat=[NSString stringWithFormat:@"%.7f",latitude1];
//            lng=[NSString stringWithFormat:@"%.7f",longitude1];
//
//            NSLog(@"lng===%@",lng);
//            
//            //添加大头针
//            [self addAnnotation];
//        }
//    }];
//}


#pragma mark 添加大头针
-(void)addAnnotation{
    CLLocationCoordinate2D location1=CLLocationCoordinate2DMake(lat.floatValue, lng.floatValue);
    
    float zoomLevel = 0.02;
    MKCoordinateRegion region = MKCoordinateRegionMake(location1, MKCoordinateSpanMake(zoomLevel, zoomLevel));
    [_mapView setRegion:[_mapView regionThatFits:region] animated:YES];
    
    KCAnnotation *annotation1=[[KCAnnotation alloc]init];
    annotation1.title=title;
    annotation1.coordinate=location1;
    [_mapView addAnnotation:annotation1];
}


//导航
-(void)actGuideLine{
    [self getLocation];
    
   // [self startLocation];
    
}

//开始定位
-(void)startLocation{
    NSLog(@"进入普通定位态");
    [_locService startUserLocationService];
    _mapView.showsUserLocation = NO;//先关闭显示的定位图层
    _mapView.userTrackingMode = BMKUserTrackingModeNone;//设置定位的状态
    _mapView.showsUserLocation = YES;//显示定位图层

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
    
    ownlatitude = userLocation.location.coordinate.latitude;
    ownlongitude = userLocation.location.coordinate.longitude;
    
    if (ownlatitude>0) {
        [self stopLocation];
        
        [self actGetline];
    }else{
       // [self showAlert:@"定位失败"];
    }
    
}

/**
 *用户位置更新后，会调用此函数
 *@param userLocation 新的用户位置
 */
- (void)didUpdateBMKUserLocation:(BMKUserLocation *)userLocation
{
    //    NSLog(@"didUpdateUserLocation lat %f,long %f",userLocation.location.coordinate.latitude,userLocation.location.coordinate.longitude);
    //[_mapView updateLocationData:userLocation];
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
    _mapView.showsUserLocation = NO;
}

-(void)callBackByLocation:(CLLocation *)newLocation{
   
    ownlatitude=newLocation.coordinate.latitude;
    ownlongitude=newLocation.coordinate.longitude;
    
    if (ownlatitude>0) {
        [self actGetline];
    }else{
        [self showAlert:@"定位失败"];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//导航
-(void)actGetline
{
    
    // ios6以下，调用google map
    
    if ([self getIOSDevice]<=6.0)
        
    {
        
        NSString *urlString = [[NSString alloc] initWithFormat:@"http://maps.google.com/maps?saddr=%f,%f&daddr=%f,%f&dirfl=d", ownlatitude,ownlongitude,lat.floatValue,lng.floatValue];
        
        NSURL *aURL = [NSURL URLWithString:urlString];
        
        //打开网页google地图
        
        [[UIApplication sharedApplication] openURL:aURL];
        
    }
    
    else
        
        // 直接调用ios自己带的apple map
        
    {
        
        //当前的位置
        
        MKMapItem *currentLocation = [MKMapItem mapItemForCurrentLocation];
        
        //起点
        
        //MKMapItem *currentLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords1 addressDictionary:nil]];
        
        //目的地的位置
        
        CLLocationCoordinate2D coords2=CLLocationCoordinate2DMake(lat.floatValue,lng.floatValue);
        
        MKMapItem *toLocation = [[MKMapItem alloc] initWithPlacemark:[[MKPlacemark alloc] initWithCoordinate:coords2 addressDictionary:nil]];
        
        toLocation.name = self.title;
        
        NSString *myname=@"出发地";
        
        NSArray *items = [NSArray arrayWithObjects:currentLocation, toLocation, nil];
        
        NSDictionary *options = @{ MKLaunchOptionsDirectionsModeKey:MKLaunchOptionsDirectionsModeDriving, MKLaunchOptionsMapTypeKey: [NSNumber numberWithInteger:MKMapTypeStandard], MKLaunchOptionsShowsTrafficKey:@YES };
        
        //打开苹果自身地图应用，并呈现特定的item
        [MKMapItem openMapsWithItems:items launchOptions:options];
        
    }
    
    /*
    // 百度wap导航
    //初始化调启导航时的参数管理类
    BMKNaviPara* para = [[BMKNaviPara alloc]init];
    //指定导航类型
    para.naviType = BMK_NAVI_TYPE_NATIVE;
    
    //初始化起点节点
    BMKPlanNode* start = [[BMKPlanNode alloc]init] ;
    //指定起点经纬度
    CLLocationCoordinate2D coor1;
    coor1.latitude = ownlatitude;
	coor1.longitude = ownlongitude;
    start.pt = coor1;
    //指定起点名称
    start.name = @"";
    //指定起点
    para.startPoint = start;
    
    //初始化终点节点
    BMKPlanNode* end = [[BMKPlanNode alloc]init] ;
    CLLocationCoordinate2D coor2;
	coor2.latitude = lat.floatValue;
	coor2.longitude = lng.floatValue;
	end.pt = coor2;
    para.endPoint = end;
    //指定终点名称
    end.name = @"";
    //指定调启导航的app名称
    para.appName = [NSString stringWithFormat:@"%@", @"乐活旅行"];
    //调启web导航
    [BMKNavigation openBaiduMapNavigation:para];
     */
    
}

@end

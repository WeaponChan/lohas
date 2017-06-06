//
//  NewTabMainViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "NewTabMainViewController.h"
#import "CityListViewController.h"
#import "SearchViewController.h"
#import "UserSignupViewController.h"
#import "TSMessage.h"
#import "NewCityListViewController.h"

@interface NewTabMainViewController (){
    NSArray *bannerList;
    
    BOOL isFirstIn;
    
    BOOL isFirstInLocation;
    
    double lat;
    double lng;
    
}

@property(nonatomic,strong)CLGeocoder *geocoder;

@end

@implementation NewTabMainViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    isFirstIn=YES;
    isFirstInLocation=YES;
    
    //初始化头部
    self.navigationItem.titleView = self.viewNavbarTitle;
    [self.viewNavbarTitle setHidden:false];
    [self.viewNavbarTitle setBackgroundColor:[UIColor clearColor]];
    self.btnCity.hidden=YES;
    
    _geocoder=[[CLGeocoder alloc]init];
    [self getLocation];
    
    [self checkVersion];
    
}

//获取首页接口
-(void)getIndex{
    
    if (isFirstIn) {
        isFirstIn=NO;
        [self.mNewTabMainList initial:self];
    }else{
        [self.mNewTabMainList refreshData];
    }

}

-(void)checkVersion{
    Api *api = [[Api alloc] init:self tag:@"version"];
    [api version:@"1023257602"];
}

-(void)callBackByLocation:(CLLocation *)newLocation{
    [AppDelegate sharedAppDelegate].ownLocation=newLocation;
    
    lat=newLocation.coordinate.latitude;
    lng=newLocation.coordinate.longitude;
    
    BOOL cityIsHave=[[AppDelegate sharedAppDelegate] hasCity];
    
    if (!cityIsHave && newLocation && isFirstInLocation) {
        
        isFirstInLocation=NO;
        
        Api *api=[[Api alloc]init:self tag:@"get_gsp_city"];
        [api getGpsCity:newLocation.coordinate.latitude lng:newLocation.coordinate.longitude];
        
    }else if(!cityIsHave && !newLocation){
        
        [[AppDelegate sharedAppDelegate] setCityByName:@"上海" ID:@"2"];
      
        [[NSUserDefaults standardUserDefaults]setObject:@"Shanghai" forKey:@"ename"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [self setCityBtn];
        [self getIndex];
        
    }else if (cityIsHave && newLocation){
        [self setCityBtn];
        [self getIndex];
    }
    
//    if (lat>0 && lng>0) {
//        [self reverseGeocode];
//    }
}


- (void)reverseGeocode {
    //1.获得输入的经纬度
    if (lat==0||lng==0) return;
    
    CLLocationDegrees latitude1=lat;
    CLLocationDegrees longitude1=lng;
    
    CLLocation *location=[[CLLocation alloc]initWithLatitude:latitude1 longitude:longitude1];
    //2.反地理编码
    [self.geocoder reverseGeocodeLocation:location completionHandler:^(NSArray *placemarks, NSError *error) {
        if (error||placemarks.count==0) {
            NSLog(@"你输入的地址没找到，可能在月球上");
            //[self showOKAlert:@"定位失败，请重试" tag:1];
            
        }else//编码成功
        {
            //显示最前面的地标信息
            
            NSLog(@"placemarks===%@",placemarks);
            
            CLPlacemark *firstPlacemark=[placemarks firstObject];
            NSString *place=firstPlacemark.name;

            
            
            if (place) {
                
                NSString *firstTwo=[place substringToIndex:2];
                NSLog(@"firstTwo==%@",firstTwo);
                if ([firstTwo isEqual:@"中国"]) {
                    place=[place substringFromIndex:2];
                }
                
                
                
                
            }
            
            //经纬度
            /*    CLLocationDegrees latitude=firstPlacemark.location.coordinate.latitude;
             CLLocationDegrees longitude=firstPlacemark.location.coordinate.longitude;
             self.latitudeField.text=[NSString stringWithFormat:@"%.2f",latitude];
             self.longitudeField.text=[NSString stringWithFormat:@"%.2f",longitude];*/
        }
    }];
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
    
    [MSViewFrameUtil setLeft:left UI:self.btnCity];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    
   if ([tag isEqual:@"get_gsp_city"]){
       
      NSDictionary* currentCity=[response objectForKeyNotNull:@"currentCity"];
       
        NSString *cityID=[currentCity objectForKeyNotNull:@"city_id"];
        NSString *name=[currentCity objectForKeyNotNull:@"name"];
        [[AppDelegate sharedAppDelegate] setCityByName:name ID:cityID];
       
       NSString *ename=[currentCity objectForKeyNotNull:@"ename"];
       [[NSUserDefaults standardUserDefaults]setObject:ename forKey:@"ename"];
       [[NSUserDefaults standardUserDefaults]synchronize];
       
        [self setCityBtn];
        [self getIndex];
    }
    else if([@"version" isEqualToString:tag]) {
        
        NSArray *configData = [response objectForKeyNotNull:@"results"];
        
        for (id config in configData)
        {
            NSString* version = [config objectForKeyNotNull:@"version"];
            NSString* cversion = [self getVersion];
            
            //NSLog(@"version=%@, cversion=%@", version, cversion);
            
            if(version && [version compare:cversion]==NSOrderedDescending) {
                [self showAlert:@"有新版本, 现在前往App Store更新吗?" message:nil tag:2];
            } else {
                // [self showMessage:@"当前使用的是最新的版本"];
            }
        }
    }
    
}

- (IBAction)actSelectCity:(id)sender {
   /* CityListViewController *viewCtrl=[[CityListViewController alloc]initWithNibName:@"CityListViewController" bundle:nil];
    viewCtrl.isRootView = false;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:TRUE];*/
    
    NewCityListViewController *viewCtrl=[[NewCityListViewController alloc]initWithNibName:@"NewCityListViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
    
}

-(void)reloadData{
    
    NSString *cityName = [[AppDelegate sharedAppDelegate] getCityName];
    NSString *str=[NSString stringWithFormat:@"当前默认城市已更改为%@",cityName];
    [TSMessage showNotificationInViewController:self title:str subtitle:nil type:TSMessageNotificationTypeSuccess];
    
    [self setCityBtn];
    [self getIndex];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actSearch:(id)sender {
    SearchViewController *viewCtrl=[[SearchViewController alloc]initWithNibName:@"SearchViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
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
@end

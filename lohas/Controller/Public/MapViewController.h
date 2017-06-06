//
//  MapViewController.h
//  lohas
//
//  Created by fred on 15-3-12.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"
#import <MapKit/MapKit.h>
#import <CoreLocation/CoreLocation.h>
#import "BMapKit.h"

@interface MapViewController : MainViewController<MKMapViewDelegate,BMKMapViewDelegate,BMKGeoCodeSearchDelegate,BMKRouteSearchDelegate,BMKLocationServiceDelegate>{
    //IBOutlet BMKMapView* _mapView;
    CLLocationCoordinate2D coordinateXY;
    BMKGeoCodeSearch* _geocodesearch;
    
     BMKLocationService* _locService;

}
@property (weak, nonatomic) IBOutlet MKMapView *mapView;

@property(nonatomic,strong)CLGeocoder *geocoder;

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnGuideLine;

@property(copy,nonatomic)NSString *lat;
@property(copy,nonatomic)NSString *lng;
@property (copy,nonatomic)NSString *title;

@property(copy,nonatomic)NSString *address;

@end

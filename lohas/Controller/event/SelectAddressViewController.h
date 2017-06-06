//
//  SelectAddressViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/4/6.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "BMapKit.h"
#import "SelectAddressList.h"

@protocol selectAddressDelegate <NSObject>

-(void)slectAddress:(NSString*)addressName;

@end

@interface SelectAddressViewController : MainViewController<BMKMapViewDelegate, BMKPoiSearchDelegate,BMKGeoCodeSearchDelegate,BMKLocationServiceDelegate> {

    BMKPoiSearch* _poisearch;
    int curPage;
    
    BMKGeoCodeSearch* _geocodesearch;
    BMKLocationService* _locService;
}

@property(weak,nonatomic)id<selectAddressDelegate> delegate;
- (IBAction)actClick:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewHead;
@property (weak, nonatomic) IBOutlet SelectAddressList *mSelectAddressList;

@property (weak, nonatomic) IBOutlet UIImageView *imageSelect;

@property (weak, nonatomic) IBOutlet UITextField *textInfo;

@property (weak, nonatomic) IBOutlet UILabel *labCity;
@property (weak, nonatomic) IBOutlet UIImageView *labTag;

- (IBAction)actClickCity:(id)sender;

- (IBAction)actSearch:(id)sender;

-(void)onClickNextPage;

@end

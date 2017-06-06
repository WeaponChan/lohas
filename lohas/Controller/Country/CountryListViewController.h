//
//  CountryListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "CountryList.h"

@interface CountryListViewController : MainViewController{
    UIButton *btnSelected;
}

@property (weak, nonatomic) IBOutlet CountryList *mCountryList;

@property (weak, nonatomic) IBOutlet UIView *viewMark;

- (IBAction)actClickTag:(id)sender;

@property(copy,nonatomic)NSString *searchCityID;
@property(copy,nonatomic)NSString *typeID;
@property(copy,nonatomic)NSString *searchText;
@property (weak, nonatomic) IBOutlet UIButton *btnFirst;
//@property(copy,nonatomic)CLLocation *searchLocation;
@property(copy,nonatomic)NSString *searchCategoryID;
@property(copy,nonatomic)NSArray *backBtnList;

@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property BOOL isNext;

@property float lat;
@property float lng;

@end

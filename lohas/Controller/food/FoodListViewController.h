//
//  FoodListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "FoodList.h"

@interface FoodListViewController : MainViewController{
    UIButton *btnSelected;
}

@property (weak, nonatomic) IBOutlet FoodList *mFoodList;
@property (weak, nonatomic) IBOutlet UIView *viewMark;
@property (weak, nonatomic) IBOutlet UIButton *btnFirst;
@property (weak, nonatomic) IBOutlet UIButton *btnAverge;
@property (weak, nonatomic) IBOutlet UIView *viewHead;


- (IBAction)actClickTag:(id)sender;

@property(copy,nonatomic)NSString *searchCityID;
@property(copy,nonatomic)NSArray *searchMenuList;
//@property(copy,nonatomic)CLLocation *searchLocation;
@property(copy,nonatomic)NSString *searchCategoryID;
@property(copy,nonatomic)NSArray *backBtnList;
@property(copy,nonatomic)NSString *searchTitle;

@property BOOL isNext;

@property float lat;
@property float lng;

@end

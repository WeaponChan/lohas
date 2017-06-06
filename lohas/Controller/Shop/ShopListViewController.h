//
//  ShopListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "ShopList.h"

@interface ShopListViewController : MainViewController{
    UIButton *btnSelected;
}

@property (weak, nonatomic) IBOutlet ShopList *mShopList;

@property (weak, nonatomic) IBOutlet UIView *viewMark;

- (IBAction)actClickTag:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnFirst;

@property(copy,nonatomic)NSString *type_id;
@property(copy,nonatomic)NSString *city_id;
@property(copy,nonatomic)NSString *searchText;
//@property(copy,nonatomic)CLLocation *location;
@property(copy,nonatomic)NSArray *backBtnList;

@property float lat;
@property float lng;

@property BOOL isNext;
@property (weak, nonatomic) IBOutlet UIView *viewHead;

@end

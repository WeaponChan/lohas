//
//  HotelListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "HotelList.h"

@interface HotelListViewController : MainViewController{
    UIButton *btnSelected;
}
@property (weak, nonatomic) IBOutlet HotelList *mHotelList;

@property (weak, nonatomic) IBOutlet UIView *viewMark;
@property (weak, nonatomic) IBOutlet UIButton *btnFirst;
@property (weak, nonatomic) IBOutlet UIView *viewHead;

- (IBAction)actClickTag:(id)sender;

@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *city_id;
@property(copy,nonatomic)NSString *category_id;
@property(copy,nonatomic)CLLocation *location;
@property(copy,nonatomic)NSString *Sdate;
@property(copy,nonatomic)NSString *Edate;
@property BOOL isNext;

@property(copy,nonatomic)NSString *min;
@property(copy,nonatomic)NSString *max;

@end

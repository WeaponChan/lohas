//
//  HotelSearchSuperViewController.h
//  lohas
//
//  Created by Juyuan123 on 15/5/14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"
#import "HotelSuperList.h"

@protocol superSearchDelegte <NSObject>

-(void)backDelegate:(NSString*)min11 max11:(NSString*)max11 cateID:(NSString*)cateID title11:(NSString*)title11;

@end

@interface HotelSearchSuperViewController : MainViewController{
    UIButton *btnSelected;
}

@property (weak, nonatomic) IBOutlet MSButtonToAction *btnSearch;

@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *ortherHotelView;

@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
@property (weak, nonatomic) IBOutlet UIView *viewPrice;

- (IBAction)actPrice:(id)sender;

@property BOOL isListBack;

@property(weak,nonatomic)id<superSearchDelegte>delegate;

@property (weak, nonatomic) IBOutlet UIView *viewNavbarTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnClickHead;
- (IBAction)actClickLeft:(id)sender;
- (IBAction)actClickRight:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property (weak, nonatomic) IBOutlet UIView *viewMark;
- (IBAction)actClickTag:(id)sender;



@property (weak, nonatomic) IBOutlet MSButtonToAction *btnXieCheng;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnYiLong;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnBooking;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnAgoda;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnBiyi;
@property (weak, nonatomic) IBOutlet HotelSuperList *HotelSuperList;



@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *city_id;
@property(copy,nonatomic)NSString *category_id;
@property(copy,nonatomic)CLLocation *location;
@property(copy,nonatomic)NSString *Sdate;
@property(copy,nonatomic)NSString *Edate;
@property BOOL isNext;

@property(copy,nonatomic)NSString *Min;
@property(copy,nonatomic)NSString *Max;

@end

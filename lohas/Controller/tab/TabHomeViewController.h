//
//  TabHomeViewController.h
//  chuanmei
//
//  Created by juyuan on 14-8-13.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MSButtonToAction.h"
#import "BannerView.h"

@interface TabHomeViewController : MainViewController{
        BannerView *bannerView;
}

@property (weak, nonatomic) IBOutlet UIView *viewNavbarTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;

@property (weak, nonatomic) IBOutlet UIView *viewBanner;
- (IBAction)actKnow:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewFirstShow;
@property (weak, nonatomic) IBOutlet UILabel *labMainTitle;

@property (strong, nonatomic) IBOutlet UIView *viewBtn;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
//=============================
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnNear;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnFood;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnFlights;
//=============================
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnScenery;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnCountry;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnHotel;
//=============================
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnEvent;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnTop;
//=============================
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnShoping;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnMy;

- (IBAction)actSelectCity:(id)sender;


//-(void)backDelegate:(NSString*)min11 max11:(NSString*)max11 cateID:(NSString*)cateID title11:(NSString*)title11;

@end

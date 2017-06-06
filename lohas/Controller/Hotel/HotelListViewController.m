//
//  HotelListViewController.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "HotelListViewController.h"
#import "HotelSearchViewController.h"
#import "HotelSearchSuperViewController.h"

@interface HotelListViewController ()<searchHotelDelete,superSearchDelegte>{
    NSString *priceTag;
}

@end

@implementation HotelListViewController
@synthesize isNext,min,max;

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavBarTitle:@"酒店列表"];
    
    btnSelected = (UIButton*)[self.view viewWithTag:1];
    
    priceTag=@"1";
    
    [self addNavBar_RightBtnWithTitle:@"筛选" action:@selector(clickRightButton)];
    
    if (isNext) {
        self.viewHead.hidden=YES;
        [MSViewFrameUtil setTop:0 UI:self.mHotelList];
        [MSViewFrameUtil setHeight:504 UI:self.mHotelList];
        
        self.mHotelList.type=2;
        self.mHotelList.city_id=@"";
        self.mHotelList.sdate=[self getNowDate];
        self.mHotelList.edate=[self getLastOrNextDate:[self getNowDate] tag:1];
        self.mHotelList.location=self.location;
        self.mHotelList.min=@"0";
        self.mHotelList.max=@"";
        [self.mHotelList initial:self];
    }else{
        
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        
        self.mHotelList.city_id=cityId;
        self.mHotelList.title=self.title;
        self.mHotelList.category_id=self.category_id;
        self.mHotelList.location=[AppDelegate sharedAppDelegate].ownLocation;
        self.mHotelList.type=1;
        self.mHotelList.min=min;
        self.mHotelList.max=max;
        self.mHotelList.price_type=priceTag;
        [self.mHotelList initial:self];
    }
    
}

//筛选
-(void)clickRightButton{
    HotelSearchSuperViewController *viewCtrl=[[HotelSearchSuperViewController alloc]initWithNibName:@"HotelSearchSuperViewController" bundle:nil];
    viewCtrl.isListBack=YES;
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)backDelegate:(NSString*)min11 max11:(NSString*)max11 cateID:(NSString*)cateID title11:(NSString*)title11{
    
    self.mHotelList.title=title11;
    self.mHotelList.min=min11;
    self.mHotelList.max=max11;
    self.mHotelList.category_id=cateID;
    [self.mHotelList refreshData];
}

-(void)viewPop:(NSString*)title stdate:(NSString*)stdate category_id:(NSString*)category_id cityid:(NSString*)cityid edate:(NSString *)edate{

    [self setInbutton:self.btnFirst];
    
    self.mHotelList.city_id=cityid;
    self.mHotelList.title=title;
    self.mHotelList.category_id=category_id;
    self.mHotelList.sdate=stdate;
    self.mHotelList.edate=edate;
    [self.mHotelList refreshData];
}

- (IBAction)actClickTag:(id)sender {
    [self setSelectedBtn:sender];
}

-(void)setSelectedBtn:(UIButton *)btn
{
    //修改选择按钮
    if (btnSelected) {
        [btnSelected setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
    }
    btnSelected = btn;
    [btnSelected setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
    //移动标识
    [UIView beginAnimations:@"moveViewMark" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [self.viewMark setCenter:btnSelected.center];
    [UIView commitAnimations];

    if (btnSelected.tag==4) {
        if (priceTag.intValue==1) {
            priceTag=@"2";
            [btnSelected setTitle:@"价格↓" forState:UIControlStateNormal];
        }else{
            priceTag=@"1";
            [btnSelected setTitle:@"价格↑" forState:UIControlStateNormal];
        }
    }

    self.mHotelList.price_type=priceTag;
    self.mHotelList.type=btnSelected.tag;
    [self.mHotelList refreshData];
    
}

-(void)setInbutton:(UIButton *)btn{
    //修改选择按钮
    if (btnSelected) {
        [btnSelected setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
    }
    btnSelected = btn;
    [btnSelected setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
    //移动标识
    [UIView beginAnimations:@"moveViewMark" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [self.viewMark setCenter:btnSelected.center];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

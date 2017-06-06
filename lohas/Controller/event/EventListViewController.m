//
//  EventListViewController.m
//  lohas
//
//  Created by juyuan on 15-2-14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "EventListViewController.h"
#import "CountryTypeViewController.h"
#import "EventSearchViewController.h"

@interface EventListViewController ()<selectTypeDelegate,eventBackDelegate>{

     int priceTag;
}

@end

@implementation EventListViewController
@synthesize title,categoryId,backBtnList,isNext,lat,lng;

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
    
    [self setNavBarTitle:@"活动列表"];
    btnSelected = (UIButton*)[self.view viewWithTag:1];
    priceTag=1;
    
    if (isNext) {
        
        self.mEventList.type = 2;
        self.mEventList.title=@"";
        self.mEventList.categoryId=@"";
        self.mEventList.cityID=@"";
        self.mEventList.lat=lat;
        self.mEventList.lng=lng;
        [self.mEventList initial:self];
        
    }else{
        
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        self.mEventList.type = 1;
        self.mEventList.title=title;
        self.mEventList.categoryId=categoryId;
        self.mEventList.cityID=cityId;
        self.mEventList.lat=lat;
        self.mEventList.lng=lng;
        [self.mEventList initial:self];
    }
    
    [self addNavBar_RightBtnWithTitle:@"筛选" action:@selector(clickRightButton)];
}

//筛选
-(void)clickRightButton{
    /*CountryTypeViewController *viewCtrl=[[CountryTypeViewController alloc]initWithNibName:@"CountryTypeViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.backSelectBtn=backBtnList;
    viewCtrl.Stitle=title;
    viewCtrl.categoryStr=@"event";
    [self.navigationController pushViewController:viewCtrl animated:YES];*/
    
    EventSearchViewController *viewCtrl=[[EventSearchViewController alloc]initWithNibName:@"EventSearchViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.isListBack=NO;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)backWithSelectMenu:(NSArray*)btnList categoryID:(NSString*)categoryID title:(NSString *)titile{
    title=titile;
    backBtnList=btnList;
    
    self.mEventList.title=title;
    self.mEventList.categoryId=categoryID;
    [self.mEventList refreshData];
}

-(void)backEvent:(NSString*)categoryID title11:(NSString*)title11{
    self.mEventList.title=title11;
    self.mEventList.categoryId=categoryID;
    [self.mEventList refreshData];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    
    int tag=btnSelected.tag;
    
    if (tag==4) {
        if (priceTag==1) {
            
            priceTag=2;
            [btnSelected setTitle:@"人均↓" forState:UIControlStateNormal];
        }else{
            priceTag=1;
            
            [btnSelected setTitle:@"人均↑" forState:UIControlStateNormal];
        }
    }
    
    self.mEventList.price_type= priceTag;
    self.mEventList.type=tag;
    [self.mEventList refreshData];
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

@end

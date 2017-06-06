//
//  CountryListViewController.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "CountryListViewController.h"
#import "CountrySearchViewController.h"
#import "CountryTypeViewController.h"

@interface CountryListViewController ()<searchCountryDelegate,selectTypeDelegate>{
    NSString *type;
    NSString *priceTag;
}

@end

@implementation CountryListViewController
@synthesize searchCityID,typeID,searchText,searchCategoryID,backBtnList,isNext,lat,lng;

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
    [self setNavBarTitle:@"乡村游列表"];
    [self addNavBar_RightBtnWithTitle:@"筛选" action:@selector(clickRightButton)];

    // Do any additional setup after loading the view from its nib.
    btnSelected = (UIButton*)[self.view viewWithTag:1];
    
    type=@"1";
    priceTag=@"1";
    
    if (isNext) {
        self.viewHead.hidden=YES;
        [MSViewFrameUtil setTop:0 UI:self.mCountryList];
        [MSViewFrameUtil setHeight:504 UI:self.mCountryList];
        
        self.mCountryList.cityID=@"";
        self.mCountryList.text=@"";
        self.mCountryList.priceType=priceTag;
        self.mCountryList.type=@"2";
        self.mCountryList.lat=lat;
        self.mCountryList.lng=lng;
       [self.mCountryList initial:self];
        
    }else{
        
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        
        self.mCountryList.type=type;
        self.mCountryList.cityID=cityId;
        self.mCountryList.text=searchText;
        self.mCountryList.lat=lat;
        self.mCountryList.lng=lng;
        self.mCountryList.category_id=searchCategoryID;
        self.mCountryList.priceType=priceTag;
        [self.mCountryList initial:self ];
    }
    
}

//筛选
-(void)clickRightButton{
    /*
    CountryTypeViewController *viewCtrl=[[CountryTypeViewController alloc]initWithNibName:@"CountryTypeViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.backSelectBtn=backBtnList;
    viewCtrl.Stitle=searchText;
    [self.navigationController pushViewController:viewCtrl animated:YES];*/
    
    CountrySearchViewController *viewCtrl=[[CountrySearchViewController alloc]initWithNibName:@"CountrySearchViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.isListBack=NO;
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}

-(void)backWithSelectMenu:(NSArray*)btnList categoryID:(NSString*)categoryID title:(NSString *)titile{
    searchText=titile;
    backBtnList=btnList;
   
    self.mCountryList.text=searchText;
    self.mCountryList.category_id=categoryID;
    [self.mCountryList refreshData];
}

-(void)viewPop:(NSString*)title city_id:(NSString*)city_id type_id:(NSString*)type_id{
    
    self.mCountryList.text=title;
    self.mCountryList.category_id=type_id;
    [self.mCountryList refreshData];
    
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
    
    type=[NSString stringWithFormat:@"%d",btnSelected.tag];
    self.mCountryList.type=type;
    self.mCountryList.priceType=priceTag;
    [self.mCountryList refreshData];
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

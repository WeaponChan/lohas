//
//  ShopListViewController.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "ShopListViewController.h"
#import "ShopSearchViewController.h"
#import "CountryTypeViewController.h"

@interface ShopListViewController ()<searchShopDelegate,selectTypeDelegate>

@end

@implementation ShopListViewController
@synthesize searchText,type_id,city_id,backBtnList,isNext,lng,lat;

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
    [self setNavBarTitle:@"购物列表"];
    [self addNavBar_RightBtnWithTitle:@"筛选" action:@selector(clickRightButton)];
    // Do any additional setup after loading the view from its nib.
     btnSelected = (UIButton*)[self.view viewWithTag:1];
    
    if (isNext) {
        self.viewHead.hidden=YES;
        [MSViewFrameUtil setTop:0 UI:self.mShopList];
        [MSViewFrameUtil setHeight:504 UI:self.mShopList];
        
        self.mShopList.cityID=@"";
        self.mShopList.title=@"";
        self.mShopList.type=@"2";
        self.mShopList.lat=lat;
        self.mShopList.lng=lng;
        [self.mShopList initial:self];
        
    }else{
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        
        self.mShopList.type=@"1";
        self.mShopList.title=searchText;
        self.mShopList.cityID=cityId;
        self.mShopList.categoryID=type_id;
        self.mShopList.lat=lat;
        self.mShopList.lng=lng;
        [self.mShopList initial:self];
    }
    
}

//筛选
-(void)clickRightButton{
   /* CountryTypeViewController *viewCtrl=[[CountryTypeViewController alloc]initWithNibName:@"CountryTypeViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.backSelectBtn=backBtnList;
    viewCtrl.Stitle=searchText;
    viewCtrl.categoryStr=@"shop";
    [self.navigationController pushViewController:viewCtrl animated:YES];*/
    
    ShopSearchViewController *viewCtrl=[[ShopSearchViewController alloc]initWithNibName:@"ShopSearchViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.isListBack=NO;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)viewPop:(NSString*)title city_id1:(NSString*)city_id1 type_id1:(NSString*)type_id1 category_id:(NSString*)category_id{
    
    self.mShopList.title=title;
    self.mShopList.categoryID=category_id;
    [self.mShopList refreshData];
    
}

- (IBAction)actClickTag:(id)sender {
    
    [self setSelectedBtn:sender];
    
}

-(void)backWithSelectMenu:(NSArray*)btnList categoryID:(NSString*)categoryID title:(NSString *)titile{
    searchText=titile;
    backBtnList=btnList;
    type_id=categoryID;
    
    self.mShopList.title=searchText;
    self.mShopList.categoryID=categoryID;
    [self.mShopList refreshData];
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
    
    self.mShopList.type=[NSString stringWithFormat:@"%d",btnSelected.tag];
   
    [self.mShopList refreshData];
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

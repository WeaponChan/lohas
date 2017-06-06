//
//  FoodListViewController.m
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodListViewController.h"
#import "FoodSearchViewController.h"
#import "FoodTypeChioceViewController.h"

@interface FoodListViewController ()<hotelSearchDelegate,MenuSelectDelete>{
    CLLocation *currentLocation;
    int priceTag;
}

@end

@implementation FoodListViewController
@synthesize lat,lng,searchCityID,searchMenuList,searchCategoryID,backBtnList,searchTitle,isNext;

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
    [self setNavBarTitle:@"餐厅列表"];
    [self addNavBar_RightBtnWithTitle:@"筛选" action:@selector(clickRightButton)];
    
    btnSelected = (UIButton*)[self.view viewWithTag:1];
    priceTag=1;
    
    if ([MSUIUtils getIOSVersion] >= 7.0){
        [self addNavBar_LeftBtn:@"navbar_back" action:@selector(actNavBar_Back:)];
    }else{
        [self addNavBar_LeftBtn:[UIImage imageNamed:@"navbar_back"]
                      Highlight:[UIImage imageNamed:@"navbar_back"]
                         action:@selector(actNavBar_Back:)];
    }
    
    if (isNext) {
        
        self.viewHead.hidden=YES;
        [MSViewFrameUtil setTop:0 UI:self.mFoodList];
        [MSViewFrameUtil setHeight:504 UI:self.mFoodList];
        
        self.mFoodList.type=2;
        self.mFoodList.lat=lat;
        self.mFoodList.lng=lng;
        self.mFoodList.city_id=@"";
        self.mFoodList.category_id=@"";
        self.mFoodList.title=@"";
        [self.mFoodList initial:self tag:1];
    }else{
        self.mFoodList.type=1;
        self.mFoodList.lat=lat;
        self.mFoodList.lng=lng;
        self.mFoodList.city_id=searchCityID;
        self.mFoodList.category_id=searchCategoryID;
        self.mFoodList.title=searchTitle;
        
        [self.mFoodList initial:self tag:1];
    }
}

-(void)callBackByLocation:(CLLocation *)newLocation{
    
    currentLocation=newLocation;
}

-(void)actNavBar_Back:(id)sender{
    [self.navigationController popViewControllerAnimated:YES];
}

//筛选
-(void)clickRightButton{
    /*
    FoodTypeChioceViewController *viewCtrl=[[FoodTypeChioceViewController alloc]initWithNibName:@"FoodTypeChioceViewController" bundle:nil];
    viewCtrl.backSelectBtn=backBtnList;
    viewCtrl.Stitle=searchTitle;
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];*/
    
    FoodSearchViewController *viewCtrl=[[FoodSearchViewController alloc]initWithNibName:@"FoodSearchViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.isListBack=NO;
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}

-(void)viewPop:(NSString*)title city_id:(NSString*)city_id price:(int)price category_id:(NSString*)category_id{
    
    self.mFoodList.title=title;
    self.mFoodList.category_id=category_id;
    [self.mFoodList refreshData];
}

-(void)backWithSelectMenu:(NSArray*)btnList categoryID:(NSString*)categoryID title:(NSString *)titile{
    searchTitle=titile;
    backBtnList=btnList;
    
    self.mFoodList.title=searchTitle;
    self.mFoodList.category_id=categoryID;
    
    [self.mFoodList refreshData];
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
    
    self.mFoodList.priceType=priceTag;
    self.mFoodList.type=tag;
    [self.mFoodList refreshData];
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

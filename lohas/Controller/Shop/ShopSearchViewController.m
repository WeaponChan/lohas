//
//  ShopSearchViewController.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "ShopSearchViewController.h"
#import "SearchViewController.h"
#import "ShopTypeViewController.h"
#import "SearchCityViewController.h"
#import "CityListViewController.h"
#import "ShopListViewController.h"
#import "CountryTypeViewController.h"
#import "TSMessage.h"

@interface ShopSearchViewController ()<cityPickerDelegate,selectTypeDelegate>{
    NSString *typeID;
    NSString *selectCityID;
    CLLocation *currentLocation;
    
    NSString *category_id;
    NSArray *backBtnList;
    NSString *selectTitle;
    
    NSMutableArray* menuList;
    NSMutableArray *selectBtn;
    UIButton *InButton;
    BOOL selectBtnOther;
}

@end

@implementation ShopSearchViewController
@synthesize isListBack,backSelectBtn;

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
    [self setNavBarTitle:@"购物筛选"];
    // Do any additional setup after loading the view from its nib.
    
    self.btnSearch.layer.cornerRadius=4;
    [self.btnSearch setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnSearch addBtnAction:@selector(actSearch) target:self];
    
    self.textShopName.text=@"";
    typeID=@"0";
    
    menuList=[[NSMutableArray alloc]init];
    selectBtn=[[NSMutableArray alloc]initWithArray:backSelectBtn];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self.scrollView setContentSize:CGSizeMake(320, 600)];
    
    selectCityID=[[AppDelegate sharedAppDelegate] getCityID];
    
    [self getLocation];
    
    self.scrollView.hidden=YES;
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_shopping_category_lists"];
    [api get_shopping_category_lists];
}

-(void)callBackByLocation:(CLLocation *)newLocation{
    
    currentLocation=newLocation;
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    
    menuList=[[NSMutableArray alloc]initWithArray:response];
    
    /*  int i=0;
     for (NSMutableDictionary *dic in menuList) {
     [dic setObject:@"NO" forKey:@"select"];
     [dic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"index"];
     i++;
     }*/
    
    int btnNum=0;//第几个按钮
    for (NSDictionary *dic in response) {
        
        int btnRow=btnNum/3;//按钮在第几行
        int btnY=10+btnRow*(40+10);//顶部距离
        int btnLine=btnNum%3;//按钮在第几列
        int btnX=10+btnLine*((SCREENWIDTH-40)/3+10);//左边距离
        
        NSString *name=[dic objectForKeyNotNull:@"title"];
        
        [self addAreaButton:name x:btnX y:btnY tag:btnNum];
        
        btnNum++;
    }
    
    int rowNum=(btnNum-1)/3;
    int height = 10+(rowNum+1)*50;
    int subAreaHeight=height+50+50;
    
    //height= [MSViewFrameUtil setTop:height UI:self.viewTextSearch];
    height = [MSViewFrameUtil setTop:height UI:self.btnSearch];
    [MSViewFrameUtil setHeight:height UI:self.viewMain];
    [self.scrollView setContentSize:CGSizeMake(320, height)];
    
    self.scrollView.hidden=NO;
}

-(void)addAreaButton:(NSString*)title x:(int)x y:(int)y tag:(int)tag{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(x, y, (SCREENWIDTH-40)/3, 40)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [btn.titleLabel setNumberOfLines:0];
    [btn.titleLabel sizeToFit];
    [btn setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
    [btn setTag:tag];
    [btn setBackgroundColor:[UIColor whiteColor]];
    
    for (UIButton *btnse in selectBtn) {
        if (btnse.tag == btn.tag) {
            [btn setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btnSelect.png"] forState:UIControlStateNormal];
        }
    }
    
    [btn addTarget:self action:@selector(clickArea:) forControlEvents:UIControlEventTouchDown];
    [self.viewMain addSubview:btn];
}

//选择
-(void)clickArea:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    BOOL isExcesit;
    
    if (selectBtn.count==0) {
        [selectBtn addObject:btn];
        [btn setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btnSelect.png"] forState:UIControlStateNormal];
        
    }else{
        
        for (UIButton *sebtn in selectBtn) {
            if (sebtn.tag== btn.tag) {
                isExcesit=YES;
                InButton=sebtn;
                break;
                
            }else{
                isExcesit=NO;
            }
        }
        
        if (isExcesit) {
            [selectBtn removeObject:InButton];
            [btn setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }else{
            [selectBtn addObject:btn];
            [btn setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btnSelect.png"] forState:UIControlStateNormal];
        }
    }
    
}


//搜索
-(void)actSearch{
    
    NSString *categoryID;
    for (UIButton *btn in selectBtn) {
        int tag=btn.tag;
        
        NSDictionary *dic = menuList[tag];
        NSString *sID=[dic objectForKeyNotNull:@"id"];
        if (categoryID.length==0) {
            categoryID=sID;
        }else{
            categoryID=[NSString stringWithFormat:@"%@,%@",categoryID,sID];
        }
    }
    
    if (categoryID.length==0) {
        categoryID=@"";
    }
    
    if (isListBack) {
        
        double gg_lon=currentLocation.coordinate.longitude;
        double gg_lat=currentLocation.coordinate.latitude;
        
        double x_pi = 3.14159265358979324 * 3000.0 / 180.0;
        double x = gg_lon, y = gg_lat;
        
        double z = sqrt(x * x + y * y) + 0.00002 * sin(y * x_pi);
        
        double theta = atan2(y, x) + 0.000003 * cos(x * x_pi);
        
        double bd_lon = z * cos(theta) + 0.0065;
        
        double bd_lat = z * sin(theta) + 0.006;
        
        ShopListViewController *viewCtrl=[[ShopListViewController alloc]initWithNibName:@"ShopListViewController" bundle:nil];
        viewCtrl.city_id=selectCityID;
        viewCtrl.type_id=categoryID;
        viewCtrl.searchText=@"";
        viewCtrl.lat=bd_lat;
        viewCtrl.lng=bd_lon;
        viewCtrl.backBtnList=backBtnList;
        [self.navigationController pushViewController:viewCtrl animated:YES];
        
    }else{
        [self.delegate viewPop:@"" city_id1:selectCityID type_id1:typeID category_id:categoryID];
        
        [self.navigationController popViewControllerAnimated:YES];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actLocation:(id)sender {
    CityListViewController *viewCtrl=[[CityListViewController alloc]initWithNibName:@"CityListViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.categoryStr=@"shop";
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)getSelectCity:(NSString*)cityName cityID:(NSString*)cityID{
    self.labCity.text=cityName;
    selectCityID=cityID;
}

//筛选
- (IBAction)actShopType:(id)sender {
    CountryTypeViewController *viewCtrl=[[CountryTypeViewController alloc]initWithNibName:@"CountryTypeViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.categoryStr=@"shop";
    viewCtrl.backSelectBtn=backBtnList;
    viewCtrl.Stitle=selectTitle;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)getType:(NSString*)title type_id:(NSString*)type_id{
    self.textType.text=title;
    typeID=type_id;
}

//筛选返回
-(void)backWithSelectMenu:(NSArray*)btnList categoryID:(NSString*)categoryID title:(NSString*)titile{
    category_id=categoryID;
    backBtnList=btnList;
    selectTitle=titile;
    
    NSString *catego;
    for (UIButton *btn in btnList) {
        
        if (catego.length==0) {
            catego=btn.titleLabel.text;
        }else {
            catego=[NSString stringWithFormat:@"%@,%@",catego,btn.titleLabel.text];
        }
    }
    
    if (titile.length>0) {
        if (catego.length==0) {
            catego=titile;
        }else{
            catego=[NSString stringWithFormat:@"%@,%@",catego,titile];
        }
    }
    
    self.textType.text=catego;
}


@end

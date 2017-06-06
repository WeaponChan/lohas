//
//  ScenerySearchViewController.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "ScenerySearchViewController.h"
#import "SceneryTypeChioceViewController.h"
#import "SearchViewController.h"
#import "SearchCityViewController.h"
#import "CityListViewController.h"
#import "SceneryListViewController.h"
#import "WapViewController.h"
#import "TSMessage.h"

@interface ScenerySearchViewController ()<cityPickerDelegate>{
    NSString *selectCityID;
    CLLocation *currentLocation;
    
    UISegmentedControl *mySegment;
    
    NSMutableArray* menuList;
    NSMutableArray *selectBtn;
    UIButton *InButton;
}

@end

@implementation ScenerySearchViewController
@synthesize isListBack;

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
    self.btnSearch.layer.cornerRadius=4;
    [self.btnSearch setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnSearch addBtnAction:@selector(actSearch) target:self];
    
    [self setNavBarTitle:@"景点筛选"];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    //self.navigationItem.titleView = self.viewNavbarTitle;
    //[self.viewNavbarTitle setHidden:YES];
    //[self.viewNavbarTitle setBackgroundColor:[UIColor clearColor]];
    
    self.textSearch.text=@"";
    
    [self.viewNavbarTitle removeFromSuperview];
    
    [self.scrollView setContentSize:CGSizeMake(320, 600)];
    
    menuList=[[NSMutableArray alloc]init];
    selectBtn=[[NSMutableArray alloc]init];
    
    [self getLocation];
    
    self.scrollView.hidden=YES;
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_travel_category_lists"];
    [api get_travel_category_lists];
}

-(void)viewWillAppear:(BOOL)animated{
    if (isListBack) {
        
        self.btnClickHead.selected=NO;
       // self.viewNavbarTitle.hidden=NO;
        
        /*
        mySegment=[[UISegmentedControl alloc]initWithFrame:CGRectMake(70, 5, 180, 32)];
        [mySegment insertSegmentWithTitle:@"景点精选" atIndex:0 animated:YES];
        [mySegment insertSegmentWithTitle:@"购买门票" atIndex:1 animated:YES];
        
        mySegment.segmentedControlStyle=UISegmentedControlStyleBar;
        [mySegment addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
        mySegment.selectedSegmentIndex=0;
        [ self.navigationController.navigationBar addSubview:mySegment];*/
    }
}

-(void)viewWillDisappear:(BOOL)animated{
    [mySegment removeFromSuperview];
}

-(void)segAction:(id)sender{
    //热门景点
    if (mySegment.selectedSegmentIndex==0) {
        
    }
    //全部景点
    else if (mySegment.selectedSegmentIndex==1) {
        
        mySegment.selectedSegmentIndex=1;
        
        WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed = YES;
        viewCtrl.title=@"购买门票";
        viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=2&Allianceid=26524&sid=467134&OUID=&jumpUrl=http://piao.ctrip.com/";
        [self.navigationController pushViewController:viewCtrl animated:NO];
    }
    
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

-(void)callBackByLocation:(CLLocation *)newLocation{
    
    currentLocation=newLocation;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//搜素
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
        
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        
        SceneryListViewController *viewCtrl=[[SceneryListViewController alloc]initWithNibName:@"SceneryListViewController" bundle:nil];
        viewCtrl.searchcityID=cityId;
        viewCtrl.searchTitle=@"";
        viewCtrl.lat=bd_lat;
        viewCtrl.lng=bd_lon;
        viewCtrl.categoryID=categoryID;
        [self.navigationController pushViewController:viewCtrl animated:YES];
    }else{
        
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        
        [self.delegate viewPop:@"" city_id:cityId categoryID11:categoryID];
        [self.navigationController popViewControllerAnimated:YES];
    }

}

//选择城市
- (IBAction)actLocation:(id)sender {
    CityListViewController *viewCtrl=[[CityListViewController alloc]initWithNibName:@"CityListViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.categoryStr=@"scenery";
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)getSelectCity:(NSString*)cityName cityID:(NSString*)cityID{
    selectCityID=cityID;

}

- (IBAction)actScenery:(id)sender {
    SceneryTypeChioceViewController *viewCtrl=[[SceneryTypeChioceViewController alloc]initWithNibName:@"SceneryTypeChioceViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actClickLeft:(id)sender {
    self.btnClickHead.selected=NO;
}

- (IBAction)actClickRight:(id)sender {
    self.btnClickHead.selected=YES;
    
    [self performBlock:^{
        WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed = YES;
        viewCtrl.title=@"购买门票";
        viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=2&Allianceid=26524&sid=467134&OUID=&jumpUrl=http://piao.ctrip.com/";
        [self.navigationController pushViewController:viewCtrl animated:TRUE];
    }afterDelay:0.1];
    
    
}


@end

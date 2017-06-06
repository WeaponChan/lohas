//
//  HotelSearchViewController.m
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "HotelSearchViewController.h"
#import "SearchViewController.h"
#import "HotelTypeViewController.h"
#import "DateChoiceViewController.h"
#import "HotelListViewController.h"
#import "SearchCityViewController.h"
#import "CityListViewController.h"
#import "DateViewController.h"

@interface HotelSearchViewController ()<cityPickerDelegate,typeSelectedDelegate,DayPickerDelegate>{
    NSString *selectCityID;
    NSString *category_id;
    CLLocation *currentLocation;
}

@end

@implementation HotelSearchViewController
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
    [self setNavBarTitle:@"酒店搜索"];
    [MSViewFrameUtil setCornerRadius:4 UI:self.btnSearch];
    [self.btnSearch setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2ALPHA];
    [self.btnSearch addBtnAction:@selector(actSearch:) target:self];
    
    self.textName.text=@"";
    self.textType.text=@"";
    category_id=@"";

    self.labSDate.text=[self getNowDate];
    self.labSWeek.text=[self getWeek:self.labSDate.text];
    self.labEDate.text=[self getLastOrNextDate:self.labSDate.text tag:1];
    self.labEWeek.text=[self getWeek:self.labEDate.text];
    
    [self.scrollView setContentSize:CGSizeMake(320, 650)];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//位置
- (IBAction)actLocation:(id)sender {
    CityListViewController *viewCtrl=[[CityListViewController alloc]initWithNibName:@"CityListViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.categoryStr=@"hotel";
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)getSelectCity:(NSString*)cityName cityID:(NSString*)cityID{
    self.labCityName.text=cityName;
    selectCityID=cityID;
}

//类型
- (IBAction)actType:(id)sender {
    HotelTypeViewController *viewCtrl=[[HotelTypeViewController alloc]initWithNibName:@"HotelTypeViewController" bundle:nil];
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)selectedType:(NSString*)type name:(NSString *)name{
    category_id=type;
    self.textType.text=name;
}

//搜索
- (void)actSearch:(id)sender {
    
    if (isListBack) {
        
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        
        HotelListViewController *viewCtrl=[[HotelListViewController alloc]initWithNibName:@"HotelListViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed = YES;
        viewCtrl.title=self.textName.text;
        viewCtrl.city_id=cityId;
        viewCtrl.category_id=category_id;
        viewCtrl.location=currentLocation;
        viewCtrl.Sdate=self.labSDate.text;
        viewCtrl.Edate=self.labEDate.text;
        [self.navigationController pushViewController:viewCtrl animated:TRUE];
    }else{
        
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        
        [self.delegate viewPop:self.textName.text stdate:self.labSDate.text category_id:category_id cityid:cityId edate:self.labEDate.text];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }
 
}

//开始日期
- (IBAction)actSelectDate:(id)sender {
    DateViewController *viewCtrl=[[DateViewController alloc]initWithNibName:@"DateViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.type=1;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//结束日期
- (IBAction)actSelectEDate:(id)sender {
    DateViewController *viewCtrl=[[DateViewController alloc]initWithNibName:@"DateViewController" bundle:nil];
    viewCtrl.delegate=self;
    viewCtrl.type=2;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)pickedDay:(NSString*)_day{
    
}

-(void)pickedDay:(NSString*)_day type:(NSInteger)_type{
    if (_type==1) {
        self.labSDate.text=_day;
        self.labSWeek.text=[self getWeek:self.labSDate.text];
        self.labEDate.text=[self getLastOrNextDate:self.labSDate.text tag:1];
        self.labEWeek.text=[self getWeek:self.labEDate.text];
        self.labInteval.text=@"总共1晚";
    }
    else{
        if ([self judgeTwoDate:self.labSDate.text secondDate:_day]) {
            self.labEDate.text=_day;
            self.labEWeek.text=[self getWeek:self.labEDate.text];
            NSString *intV=[self getInterval:self.labSDate.text edate:self.labEDate.text];
            self.labInteval.text=[NSString stringWithFormat:@"总共%@晚",intV];
            
        }else{
            [self showAlert:@"离开日期不能早于入住日期"];
        }
    }
}

@end

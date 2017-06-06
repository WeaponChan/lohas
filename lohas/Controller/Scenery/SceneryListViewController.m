//
//  SceneryListViewController.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "SceneryListViewController.h"
#import "ScenerySearchViewController.h"

@interface SceneryListViewController ()<searchSceneryDelegate>{
    NSString *priceTag;
}

@end

@implementation SceneryListViewController
@synthesize searchcityID,searchTitle,isNext,categoryID,lat,lng;

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
    [self setNavBarTitle:@"景点列表"];
    
    //[self addNavBar_RightBtnWithTitle:@"筛选" action:@selector(clickRightButton)];
    // Do any additional setup after loading the view from its nib.
      btnSelected = (UIButton*)[self.view viewWithTag:1];
    
    priceTag=@"1";
    
    [self addNavBar_RightBtnWithTitle:@"筛选" action:@selector(clickRightButton)];
    
    if (isNext) {
        self.viewHead.hidden=YES;
        [MSViewFrameUtil setTop:0 UI:self.mSceneryList];
        [MSViewFrameUtil setHeight:504 UI:self.mSceneryList];
        
        self.mSceneryList.title=@"";
        self.mSceneryList.priceType=priceTag;
        self.mSceneryList.type=@"2";
        self.mSceneryList.cityID=@"";
        self.mSceneryList.lat=lat;
        self.mSceneryList.lng=lng;
        self.mSceneryList.category=@"";
        [self.mSceneryList initial:self];
        
    }else{
        self.mSceneryList.type=@"1";
        self.mSceneryList.title=searchTitle;
        self.mSceneryList.cityID=searchcityID;
        self.mSceneryList.lat=lat;
        self.mSceneryList.lng=lng;
        self.mSceneryList.priceType=priceTag;
        self.mSceneryList.category=categoryID;
        [self.mSceneryList initial:self];
    }

}

//筛选
-(void)clickRightButton{
    ScenerySearchViewController *viewCtrl=[[ScenerySearchViewController alloc]initWithNibName:@"ScenerySearchViewController" bundle:nil];
    viewCtrl.isListBack=NO;
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)viewPop:(NSString*)title city_id:(NSString*)city_id categoryID11:(NSString *)categoryID11{
    
    [self setInbutton:self.btnFirst];
    
    self.mSceneryList.title=title;
    self.mSceneryList.cityID=city_id;
    self.mSceneryList.category=categoryID11;
    [self.mSceneryList refreshData];
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
    
    self.mSceneryList.type=[NSString stringWithFormat:@"%d",btnSelected.tag];
    self.mSceneryList.priceType=priceTag;
    [self.mSceneryList refreshData];
    
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

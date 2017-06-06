//
//  HotelSearchSuperViewController.m
//  lohas
//
//  Created by Juyuan123 on 15/5/14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "HotelSearchSuperViewController.h"
#import "WapViewController.h"
#import "TSMessage.h"
#import "HotelListViewController.h"
#import "HotelSearchViewController.h"

@interface HotelSearchSuperViewController (){
    UISegmentedControl *mySegment;
    
    NSMutableArray* menuList;
    UIButton *selectStarBtn;
    NSString *min;
    NSString *max;
    UIButton *selectPriceBtn;
    NSString *priceTag;
}

@end

@implementation HotelSearchSuperViewController
@synthesize isListBack,Min,Max,isNext;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    btnSelected = (UIButton*)[self.view viewWithTag:1];
    priceTag=@"1";
    
    self.btnSearch.layer.cornerRadius=4;
    [self.btnSearch setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnSearch addBtnAction:@selector(actSearch) target:self];
    
    [self.btnXieCheng setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnXieCheng addBtnAction:@selector(actXieCheng) target:self];
    
    [self.btnYiLong setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnYiLong addBtnAction:@selector(actYiLong) target:self];
    
    [self.btnBooking setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnBooking addBtnAction:@selector(actBooking) target:self];
    
    [self.btnAgoda setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnAgoda addBtnAction:@selector(actAgoda) target:self];
    
    [self.btnBiyi setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnBiyi addBtnAction:@selector(actBiyi) target:self];

    [TSMessage setDefaultViewController:self.navigationController];
    
    [self setNavBarTitle:@"酒店预订"];
   
    
    
    if (isNext) {
     
//        [MSViewFrameUtil setTop:0 UI:self.HotelSuperList];
//        [MSViewFrameUtil setHeight:340 UI:self.HotelSuperList];
        
        self.HotelSuperList.type=2;
        self.HotelSuperList.city_id=@"";
        self.HotelSuperList.sdate=[self getNowDate];
        self.HotelSuperList.edate=[self getLastOrNextDate:[self getNowDate] tag:1];
        self.HotelSuperList.location=self.location;
        self.HotelSuperList.min=@"0";
        self.HotelSuperList.max=@"";
        [self.HotelSuperList initial:self];
    }else{
        
        NSString *cityId=[[AppDelegate sharedAppDelegate] getCityID];
        
        self.HotelSuperList.city_id=cityId;
        self.HotelSuperList.title=self.title;
        self.HotelSuperList.category_id=self.category_id;
        self.HotelSuperList.location=[AppDelegate sharedAppDelegate].ownLocation;
        self.HotelSuperList.type=1;
        self.HotelSuperList.min=@"1";
        self.HotelSuperList.max=@"";
        self.HotelSuperList.price_type=priceTag;
        [self.HotelSuperList initial:self];
    }

    self.HotelSuperList.tableHeaderView = self.ortherHotelView;
//    @try{   
//    }
//    @catch(NSException *exception) {
//        NSLog(@"异常错误是:%@", exception);
//    }
    
    
    
         /* self.scrollView.hidden=YES;
          
          self.navigationItem.titleView = self.viewNavbarTitle;
          [self.viewNavbarTitle setHidden:YES];
          [self.viewNavbarTitle setBackgroundColor:[UIColor clearColor]];
          
          min=@"0";
          max=@"";
          
          [self showLoadingView];
          Api *api=[[Api alloc]init:self tag:@"get_hotel_category_list"];
          [api get_hotel_category_list];*/
   
}


-(void)backDelegate:(NSString*)min11 max11:(NSString*)max11 cateID:(NSString*)cateID title11:(NSString*)title11{
    
    self.HotelSuperList.title=title11;
    self.HotelSuperList.min=min11;
    self.HotelSuperList.max=max11;
    self.HotelSuperList.category_id=cateID;
    [self.HotelSuperList refreshData];
}

-(void)viewWillAppear:(BOOL)animated{
    if (!isListBack) {
        
        self.btnClickHead.selected=NO;
        self.viewNavbarTitle.hidden=NO;
        
       /*
        mySegment=[[UISegmentedControl alloc]initWithFrame:CGRectMake(70, 5, 180, 32)];
        [mySegment insertSegmentWithTitle:@"酒店精选" atIndex:0 animated:YES];
        [mySegment insertSegmentWithTitle:@"比价预订" atIndex:1 animated:YES];
        
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
    //热门酒店
    if (mySegment.selectedSegmentIndex==0) {
        
    }
    //全部酒店
    else if (mySegment.selectedSegmentIndex==1) {
        
         mySegment.selectedSegmentIndex=1;
        
        WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed = YES;
        viewCtrl.title=@"比价预订";
        viewCtrl.linkStr=@"https://brands.datahc.com/?a_aid=135541&brandid=413093&languageCode=CS&&mobile=1";
        [self.navigationController pushViewController:viewCtrl animated:TRUE];
    }
    
}




//搜索
-(void)actSearch{
    NSString *strBtnTag;
    if (selectStarBtn) {
        strBtnTag=[NSString stringWithFormat:@"%d",selectStarBtn.tag];
    }else{
        strBtnTag=@"";
    }
    
    if (isListBack) {
        [self.delegate backDelegate:min max11:max cateID:strBtnTag title11:@""];
        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        HotelListViewController *viewCtrl=[[HotelListViewController alloc]initWithNibName:@"HotelListViewController" bundle:nil];
        
        viewCtrl.min=min;
        viewCtrl.max=max;
        viewCtrl.title=@"";
        viewCtrl.category_id=strBtnTag;
        
        [self.navigationController pushViewController:viewCtrl animated:YES];
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
    
    int btnNum=0;//第几个按钮
    for (NSDictionary *dic in response) {
        
        int btnRow=btnNum/3;//按钮在第几行
        int btnY=40+btnRow*(40+10);//顶部距离
        int btnLine=btnNum%3;//按钮在第几列
        int btnX=10+btnLine*(93+10);//左边距离
        
        NSString *name=[dic objectForKeyNotNull:@"star"];
        NSString *starid=[dic objectForKeyNotNull:@"id"];
        
        if (name.intValue==1) {
            name=@"一星级";
        }
        else if (name.intValue==2) {
            name=@"二星级";
        }
        else if (name.intValue==3) {
            name=@"三星级";
        }
        else if (name.intValue==4) {
            name=@"四星级";
        }
        else if (name.intValue==5) {
            name=@"五星级";
        }
        else if (name.intValue==6) {
            name=@"六星级";
        }
        else if (name.intValue==7) {
            name=@"七星级";
        }
        else if (name.intValue==8) {
            name=@"八星级";
        }
        
        [self addAreaButton:name x:btnX y:btnY tag:starid.intValue];
    
        btnNum++;
    }
    
    int rowNum=(btnNum-1)/3;
    int height = 40+(rowNum+1)*50;
    
    //height= [MSViewFrameUtil setTop:height UI:self.viewPrice];
    height = [MSViewFrameUtil setTop:height UI:self.btnSearch];
    [MSViewFrameUtil setHeight:height UI:self.viewMain];
    [self.scrollView setContentSize:CGSizeMake(320, height)];
    
    self.scrollView.hidden=NO;
}

-(void)addAreaButton:(NSString*)title x:(int)x y:(int)y tag:(int)tag{
    UIButton *btn=[[UIButton alloc]initWithFrame:CGRectMake(x, y, 93, 40)];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize:14]];
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [btn.titleLabel setNumberOfLines:0];
    [btn.titleLabel sizeToFit];
    [btn setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
    [btn setTag:tag];
    [btn setBackgroundColor:[UIColor whiteColor]];
    
    [btn addTarget:self action:@selector(clickArea:) forControlEvents:UIControlEventTouchDown];
    [self.viewMain addSubview:btn];
}

//选择
-(void)clickArea:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    
    if (selectStarBtn && selectStarBtn==btn) {
        [btn setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        selectStarBtn=nil;
    }
    else {
        [selectStarBtn setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
        [selectStarBtn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        
        [btn setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btnSelect.png"] forState:UIControlStateNormal];
        selectStarBtn=btn;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//价格
- (IBAction)actPrice:(id)sender {
    UIButton *btn=(UIButton*)sender;
    int tag=btn.tag;
    
    switch (tag) {
        case 100:
            
            min=@"0";
            max=@"99";
            
            break;
        case 101:
            
            min=@"100";
            max=@"199";
            
            break;
        case 102:
            
            min=@"200";
            max=@"499";
            
            break;
        case 103:
            
            min=@"500";
            max=@"999";
            
            break;
        case 104:
            
            min=@"1000";
            max=@"";
            
            break;
            
        default:
            break;
    }
    
    if (selectPriceBtn && selectPriceBtn==btn) {
        selectPriceBtn.selected=NO;
        selectPriceBtn=nil;
        
        min=@"0";
        max=@"";
        
    }else{
        btn.selected=YES;
        selectPriceBtn.selected=NO;
        
        selectPriceBtn=btn;
    }
    
}

- (IBAction)actClickLeft:(id)sender {
    self.btnClickHead.selected=NO;
}

- (IBAction)actClickRight:(id)sender {
    self.btnClickHead.selected=YES;
    
    [self performBlock:^{
        WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed = YES;
        viewCtrl.title=@"比价预订";
        viewCtrl.linkStr=@"https://brands.datahc.com/?a_aid=135541&brandid=413093&languageCode=CS&&mobile=1";
        [self.navigationController pushViewController:viewCtrl animated:TRUE];
    }afterDelay:0.1];
    
    
}

//携程
-(void)actXieCheng{
    WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"酒店预订";
    viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=636&sid=467134&allianceid=26524&ouid=";
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
}

//艺龙
-(void)actYiLong{
    WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"酒店预订";
    //viewCtrl.linkStr=@"http://travel.elong.com/hotel/?campaign_id=2000000003641870950";

    viewCtrl.linkStr=@"http://union.elong.com/r/hotel/2000000003641870950";
    
    [self.navigationController pushViewController:viewCtrl animated:TRUE];

}

//Booking
-(void)actBooking{
    WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"酒店预订";
    viewCtrl.linkStr=@"http://m.booking.com/index.html?aid=810594";
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
}

//Agoda
-(void)actAgoda{
    WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"酒店预订";
    viewCtrl.linkStr=@"http://www.agoda.com/zh-cn?cid=1717184";
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
}

//比驿
-(void)actBiyi{
    WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed = YES;
    viewCtrl.title=@"酒店预订";
    viewCtrl.linkStr=@"https://brands.datahc.com/?a_aid=135541&brandid=413093&languageCode=CS&&mobile=1";
    [self.navigationController pushViewController:viewCtrl animated:TRUE];
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
    
    self.HotelSuperList.price_type=priceTag;
    self.HotelSuperList.type = btnSelected.tag;
    [self.HotelSuperList refreshData];
    
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

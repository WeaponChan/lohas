//
//  FlightsSearchViewController.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FlightsSearchViewController.h"
#import "FlightsListViewController.h"
#import "FlightsCityListViewController.h"
#import "DateViewController.h"
#import "WapViewController.h"

@interface FlightsSearchViewController ()<flightsCityDelegate,DayPickerDelegate>{
    NSString *SCode;
    NSString *ECode;
    NSString *interval;
    NSString *nowDate;
    NSString *SFlag;
    NSString *EFlag;
    
    UISegmentedControl *mySegment;
}

@end

@implementation FlightsSearchViewController

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
    [self.btnSearch addBtnAction:@selector(actSearch:) target:self];
    
    interval=@"0";
    
    self.navigationItem.titleView = self.viewNavbarTitle;
    [self.viewNavbarTitle setHidden:NO];
    [self.viewNavbarTitle setBackgroundColor:[UIColor clearColor]];
    
    NSString *scity=[[NSUserDefaults standardUserDefaults]objectForKey:@"FJSCity"];
    if (scity.length==0) {
        ECode=@"BJS";
        SCode=@"SHA";
        self.labSCity.text=@"上海";
        self.labEcity.text=@"北京";
    }
    else{
        self.labSCity.text=scity;
        self.labEcity.text=[[NSUserDefaults standardUserDefaults]objectForKey:@"FJECity"];
        SCode=[[NSUserDefaults standardUserDefaults]objectForKey:@"FJSCode"];
        ECode=[[NSUserDefaults standardUserDefaults]objectForKey:@"FJECode"];
    }
    
    nowDate=[self getNowDate];
    self.labTime.text=[NSString stringWithFormat:@"%@ %@",nowDate,[self getWeek:nowDate]];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)viewWillAppear:(BOOL)animated{
  
    self.btnClickHead.selected=NO;
    self.viewNavbarTitle.hidden=NO;
    
    /*
        mySegment=[[UISegmentedControl alloc]initWithFrame:CGRectMake(70, 5, 180, 32)];
        [mySegment insertSegmentWithTitle:@"飞机票" atIndex:0 animated:YES];
        [mySegment insertSegmentWithTitle:@"火车票" atIndex:1 animated:YES];
        
        mySegment.segmentedControlStyle=UISegmentedControlStyleBar;
        [mySegment addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
        mySegment.selectedSegmentIndex=0;
        [ self.navigationController.navigationBar addSubview:mySegment];
    */
}

-(void)viewWillDisappear:(BOOL)animated{
    [mySegment removeFromSuperview];
}

-(void)segAction:(id)sender{
    //飞机票
    if (mySegment.selectedSegmentIndex==0) {
        
    }
    //火车票
    else if (mySegment.selectedSegmentIndex==1) {
        
        mySegment.selectedSegmentIndex=1;
        
        WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed = YES; 
        viewCtrl.title=@"火车票";
        //viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=671&TrainNO=&departdatetime=&astationpin=beijing&dstationpin=shanghai&sourceid=1&sid=467134&allianceid=26524&ouid=";
       viewCtrl.linkStr=@"http://m.ctrip.com/webapp/train/?allianceid=26524&sid=467134&sourceid=2055";
        [self.navigationController pushViewController:viewCtrl animated:TRUE];
    }
    
}


//点击搜索
- (void)actSearch:(id)sender {
    
    [[NSUserDefaults standardUserDefaults]setObject:self.labSCity.text forKey:@"FJSCity"];
    [[NSUserDefaults standardUserDefaults]setObject:self.labEcity.text forKey:@"FJECity"];
    [[NSUserDefaults standardUserDefaults]setObject:SCode forKey:@"FJSCode"];
    [[NSUserDefaults standardUserDefaults]setObject:ECode forKey:@"FJECode"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    NSString *urlStr;
    NSString *interFlag;
    //国际
    if (SFlag.intValue==1 || EFlag.intValue==1) {
        urlStr=[NSString stringWithFormat:@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=617&dcityname=bjs&acityname=tyo&dcitycode=%@&acitycode=%@&ddate=%@&rdays=&flightway=single&flighttype=all&sid=467134&allianceid=26524&ouid=&sourceid=",SCode,ECode,interval];
        interFlag=@"1";
    }
    //国内
    else{
        urlStr=[NSString stringWithFormat:@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=610&depart=%@&arrive=%@&afterdays=%@&sid=467134&allianceid=26524&ouid=",SCode,ECode,interval];
        interFlag=@"0";
    }
    
    NSLog(@"urlStr====%@",urlStr);
    
    WapViewController *viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
    viewCtrl.linkStr=urlStr;
    viewCtrl.title=[NSString stringWithFormat:@"%@-%@",self.labSCity.text,self.labEcity.text];
    viewCtrl.categoryStr=@"flights";
    viewCtrl.interNationFlag=interFlag;
    viewCtrl.scode=SCode;
    viewCtrl.ecode=ECode;
    viewCtrl.ecity=self.labEcity.text;
    viewCtrl.scity=self.labSCity.text;
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}

- (IBAction)actStartCity:(id)sender {
    FlightsCityListViewController *viewCtrl=[[FlightsCityListViewController alloc]initWithNibName:@"FlightsCityListViewController" bundle:nil];
    viewCtrl.categoryStr=@"start";
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}

- (IBAction)actEndCity:(id)sender {
    FlightsCityListViewController *viewCtrl=[[FlightsCityListViewController alloc]initWithNibName:@"FlightsCityListViewController" bundle:nil];
    viewCtrl.categoryStr=@"end";
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)pickedCity:(NSString*)cityname code:(NSString*)code categoryStr:(NSString*)categoryStr flag:(NSString *)flag{
    NSLog(@"cityname%@ code%@",cityname,code);
    if ([categoryStr isEqual:@"start"]) {
        self.labSCity.text=cityname;
        SCode=code;
        SFlag=flag;
    }else{
        self.labEcity.text=cityname;
        ECode=code;
        EFlag=flag;
    }
}

//交换城市
- (IBAction)actExchange:(id)sender {
    NSString *a;
    a=self.labSCity.text;
    self.labSCity.text=self.labEcity.text;
    self.labEcity.text=a;
    
    NSString *b;
    b=SCode;
    SCode=ECode;
    ECode=b;
}

//选择出发时间
- (IBAction)actSelectSTime:(id)sender {
    DateViewController *viewCtrl=[[DateViewController alloc]initWithNibName:@"DateViewController" bundle:nil];
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)pickedDay:(NSString*)_day{
    NSString *week=[self getWeek:_day];
    self.labTime.text=[NSString stringWithFormat:@"%@ %@",_day,week];

    interval=[self getInterval:nowDate edate:_day];
}

-(void)pickedDay:(NSString*)_day type:(NSInteger)_type{
    
}

- (IBAction)actClickLeft:(id)sender {
    self.btnClickHead.selected=NO;
}

- (IBAction)actClickRight:(id)sender {
    self.btnClickHead.selected=YES;
    
    [self performBlock:^{
        WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed = YES;
        viewCtrl.title=@"火车票";
        viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=671&TrainNO=&departdatetime=&astationpin=beijing&dstationpin=shanghai&sourceid=1&sid=467134&allianceid=26524&ouid=";
        [self.navigationController pushViewController:viewCtrl animated:TRUE];
    }afterDelay:0.1];
    
    
}


@end

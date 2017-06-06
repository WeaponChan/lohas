//
//  WapTrainViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/18.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "WapTrainViewController.h"
#import "WapFlightViewController.h"
#import "DateViewController.h"
#import "FlightsCityListViewController.h"

@interface WapTrainViewController ()<flightsCityDelegate,DayPickerDelegate>{
    NSString *SCode;
    NSString *ECode;
    NSString *nowDate;
    NSString *SFlag;
    NSString *EFlag;
    
    UISegmentedControl *mySegment;
}


@end

@implementation WapTrainViewController
@synthesize linkStr,title,categoryStr,interNationFlag,scode,ecode,scity,ecity,isFlight;


- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad {
    [super viewDidLoad];
    [self setNavBarTitle:title];
    self.viewNavbarTitle.hidden=YES;
    
    if (isFlight) {
        self.navigationItem.titleView = self.viewNavbarTitle;
        [self.viewNavbarTitle setHidden:NO];
        [self.viewNavbarTitle setBackgroundColor:[UIColor clearColor]];
    }
    
    //    if (!title) {
    //        [self setNavBarTitle:@"乐活旅行"];
    //    }
    
    //    if ([categoryStr isEqual:@"flights"]) {
    //        [self addNavBar_RightBtnWithTitle:@"返程" action:@selector(actChang)];
    //    }else{
    [self addNavBar_RightBtnWithTitle:@"返回" action:@selector(clickRightButton)];
    [self addNavBar_LeftBtnWithTitle:@"" action:@selector(actleft)];
    //    }
    
    [self refreshWeb];
}

-(void)viewWillAppear:(BOOL)animated{
    
    self.btnClickHead.selected=NO;
    
}

-(void)viewWillDisappear:(BOOL)animated{
    [mySegment removeFromSuperview];
}

//切换飞机  火车
-(void)segAction:(id)sender{
    //飞机票
    if (mySegment.selectedSegmentIndex==0) {
        
    }
    //火车票
    else if (mySegment.selectedSegmentIndex==1) {
        
        mySegment.selectedSegmentIndex=1;
        
        /*WapViewController*viewCtrl=[[WapViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
         viewCtrl.hidesBottomBarWhenPushed = YES;
         viewCtrl.title=@"火车票";
         viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=671&TrainNO=&departdatetime=&astationpin=beijing&dstationpin=shanghai&sourceid=1&sid=467134&allianceid=26524&ouid=";
         [self.navigationController pushViewController:viewCtrl animated:TRUE];*/
        
        linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=671&TrainNO=&departdatetime=&astationpin=beijing&dstationpin=shanghai&sourceid=1&sid=467134&allianceid=26524&ouid=";
        
        [self refreshWeb];
        
    }
    
}


-(void)clickRightButton{
    [self.navigationController popViewControllerAnimated:YES];
}

//返程
-(void)actChang{
    
    DateViewController *viewCtrl=[[DateViewController alloc]initWithNibName:@"DateViewController" bundle:nil];
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
    
}

-(void)pickedDay:(NSString*)_day{
    
    NSString *nowDate=[self getNowDate];
    NSString* interval=[self getInterval:nowDate edate:_day];
    
    NSString *a;
    a=scode;
    scode=ecode;
    ecode=a;
    
    NSString *b;
    b=scity;
    scity=ecity;
    ecity=b;
    
    if (interNationFlag.intValue==1) {
        linkStr=[NSString stringWithFormat:@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=617&dcityname=bjs&acityname=tyo&dcitycode=%@&acitycode=%@&ddate=%@&rdays=&flightway=single&flighttype=all&sid=467134&allianceid=26524&ouid=&sourceid=",scode,ecode,interval];
        
    }else{
        linkStr=[NSString stringWithFormat:@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=610&depart=%@&arrive=%@&afterdays=%@&sid=467134&allianceid=26524&ouid=",scode,ecode,interval];
    }
    
    NSString *str=[NSString stringWithFormat:@"%@-%@",scity,ecity];
    [self setNavBarTitle:str];
    
    [self refreshWeb];
    
}

-(void)actblank{
    
}

-(void)pickedDay:(NSString*)_day type:(NSInteger)_type{
    
}

-(void)refreshWeb{
    
    NSLog(@"linkStr===%@",linkStr);
    
   // [self showLoadingView];
    NSURL *strurl =[NSURL URLWithString:linkStr];
    NSURLRequest *request =[NSURLRequest requestWithURL:strurl];
    [self.webView loadRequest:request];
}

- (void)webViewDidFinishLoad:(UIWebView *)webView
{
    [self closeLoadingView];
}


- (BOOL)webView:(UIWebView *)webView shouldStartLoadWithRequest:(NSURLRequest *)request navigationType:(UIWebViewNavigationType)navigationType
{
    NSURL *url = [request URL];
    NSString *strUrl=[NSString stringWithFormat:@"%@",url];
    NSLog(@"strUrl+++%@",strUrl);
    
    return YES;
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actClickLeft:(id)sender {

    self.btnClickHead.selected=YES;
    //[self.btnClickHead setImage:[UIImage imageNamed:@"flight_n.png"] forState:UIControlStateNormal];
    
    [self performBlock:^{
        WapFlightViewController*viewCtrl=[[WapFlightViewController alloc]initWithNibName:@"WapViewController" bundle:nil];
        viewCtrl.hidesBottomBarWhenPushed = YES;
        viewCtrl.viewNavbarTitle.hidden = YES;
        viewCtrl.title=@"飞机票";
        //viewCtrl.linkStr=@"http://u.ctrip.com/union/CtripRedirect.aspx?TypeID=671&TrainNO=&departdatetime=&astationpin=beijing&dstationpin=shanghai&sourceid=1&sid=467134&allianceid=26524&ouid=";
        viewCtrl.linkStr=@"http://m.ctrip.com/webapp/flight/?allianceid=26524&sid=467134&sourceid=2055";
        [self.navigationController pushViewController:viewCtrl animated:TRUE];
    }afterDelay:0.1];
}

- (IBAction)actClickRight:(id)sender {
    
    self.btnClickHead.selected=NO;

}
@end

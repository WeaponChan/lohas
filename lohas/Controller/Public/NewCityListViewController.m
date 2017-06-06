//
//  NewCityListViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/4/7.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "NewCityListViewController.h"

@interface NewCityListViewController (){
    BOOL isFirstSearch;
    BOOL isInternation;
    BOOL isFirstIn;
    
    NSDictionary *currentCity;
    NSArray *hotCity;
    NSMutableArray *cityList;
    
    NSMutableArray *stateList;
    NSMutableArray *provinceList;
    NSMutableArray *postList;
    
    NSArray *ABarray;
}

@end

@implementation NewCityListViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"选择您所在的城市"];
    
    stateList=[[NSMutableArray alloc]init];
    provinceList=[[NSMutableArray alloc]init];
    postList=[[NSMutableArray alloc]init];
    
    self.view1.hidden=NO;
    self.view2.hidden=YES;
    
    isFirstIn=YES;
    
    self.mNewCitySearchList.hidden=YES;
    
    ABarray = [[NSArray alloc] initWithObjects:@"A",@"B", @"C",@"D",@"E",@"F",@"G",@"H",@"I",@"J",@"K",@"L",@"M",@"N",@"O",@"P",@"Q",@"R",@"S",@"T",@"U",@"V",@"W",@"X",@"Y",@"Z",nil];
    
    isFirstSearch=YES;
    
    isInternation=NO;
    [self getLocation];//定位
    [self getNowCountry];//国内城市定位
}


//定位
-(void)callBackByLocation:(CLLocation *)newLocation{
    
    if (!isInternation) {
        Api *api=[[Api alloc]init:self tag:@"getGpsCity"];
        [api getGpsCity:newLocation.coordinate.latitude lng:newLocation.coordinate.longitude];
    }else{
        Api *api=[[Api alloc]init:self tag:@"getInternationGpsCity"];
        [api getInternationGpsCity:newLocation.coordinate.latitude lng:newLocation.coordinate.longitude];
    }
}

//国内城市
-(void)getNowCountry{
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"getCity"];
    [api getCity];
    
}

//国际城市
-(void)getInterCountry{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"getInternationCityList"];
    [api getInternationCityList];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showMessage:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"getGpsCity"] || [tag isEqual:@"getInternationGpsCity"]) {
        currentCity=[response objectForKeyNotNull:@"currentCity"];
        
        self.labCurrentCity.text=[NSString stringWithFormat:@"当前城市:%@",[currentCity objectForKeyNotNull:@"name"]];
        
        self.labSubCurrentCity.hidden=YES;
        self.labRadius.hidden=YES;
        
    }
    //国内城市列表
    else if ([tag isEqual:@"getCity"] || [tag isEqual:@"getInternationCityList"]){
        
        stateList=[[NSMutableArray alloc]init];
        provinceList=[[NSMutableArray alloc]init];
        postList=[[NSMutableArray alloc]init];
        
        for (UIView *subView in self.viewHotCity.subviews) {
            if (subView.tag!=1000) {
                [subView removeFromSuperview];
            }
        }
        
        hotCity=[response objectForKeyNotNull:@"hotCity"];
        
        int i=0;//第几个热门城市
        int btnLine;
        for (NSDictionary *btnDic in hotCity) {
            NSString *name=[btnDic objectForKeyNotNull:@"name"];
            
            btnLine=i/3;//每个按钮在第几行
            int btnLoc=i%3;//每一行第几个按钮
            int btnX = 10+((SCREENWIDTH-32)/3+8)*btnLoc;//每个按钮距离左边的距离
            int btnY = 30+(36+10)*btnLine;//每个按钮距离顶部的距离
            
            [self setHotCityButton:btnX y:btnY title:name tag:i];
            
            i++;
        }
        
        if ([response count]==0) {
            [MSViewFrameUtil setHeight:0 UI:self.viewHotCity];
            [MSViewFrameUtil setHeight:94 UI:self.viewHead];
            self.labHotTitle.hidden=YES;
            
        }else{
            
            [MSViewFrameUtil setHeight:30+(36+10)*(btnLine+1) UI:self.viewHotCity];
            [MSViewFrameUtil setHeight:94+30+(36+10)*(btnLine+1) UI:self.viewHead];
        }
        
        [self.mnewCityList setTableHeaderView:self.viewHead];
        
        cityList=[response objectForKeyNotNull:@"cityList"];
        
        for (NSMutableDictionary *provinceDic in cityList) {
            
            [provinceList addObject:provinceDic];//省数组
            
            [provinceDic setObject:@"NO" forKey:@"selected"];
            [postList addObject:provinceDic];
            
            NSArray *subCityList=[provinceDic objectForKeyNotNull:@"cityList"];
            for (NSDictionary *stateDic in subCityList) {
                [stateList addObject:stateDic];//市数组
            }
        }
        
        self.mnewCityList.ABarray=ABarray;
        self.mnewCityList.postList=postList;
        
        if (isFirstIn) {
            isFirstIn=NO;
            [self.mnewCityList initial:self];
        }else{
            [self.mnewCityList refreshData];
        }
        
    }
    
}

//选择省
-(void)selectProvince:(NSDictionary*)item{
    
    NSString *name=[item objectForKeyNotNull:@"name"];
    NSString *selected=[item objectForKeyNotNull:@"selected"];
    
    postList=[[NSMutableArray alloc]init];
    
    for (NSMutableDictionary *province in provinceList) {
        
        NSString *pname=[province objectForKeyNotNull:@"name"];
        if ([pname isEqual:name]) {
            //选中
            if ([selected isEqual:@"NO"]) {
                [province setObject:@"YES" forKey:@"selected"];
                
                //加省
                [postList addObject:province];
                
                //加市
                for (NSDictionary *state in stateList) {
                    
                    NSString *pro=[state objectForKeyNotNull:@"province"];
                    if ([pro isEqual:name]) {
                        [postList addObject:state];
                    }
                }                
            }
            //未选中
            else{
                [province setObject:@"NO" forKey:@"selected"];
                //加省
                [postList addObject:province];
            }
        }
        //其它省
        else{
            [province setObject:@"NO" forKey:@"selected"];
            //加省
            [postList addObject:province];
        }
    }
    
    self.mnewCityList.postList=postList;
    [self.mnewCityList refreshData];
    
    
}

//生成热门城市按钮
-(void)setHotCityButton:(int)x y:(int)y title:(NSString*)title tag:(int)tag{
    MSButtonToAction *btn=[[MSButtonToAction alloc]initWithFrame:CGRectMake(x, y, (SCREENWIDTH-32)/3, 36)];
    [btn setBackgroundColor:[UIColor whiteColor]];
    [btn setTitle:title forState:UIControlStateNormal];
    [btn setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
    [btn.titleLabel setFont:[UIFont systemFontOfSize: 14.0]];
    btn.titleLabel.numberOfLines=2;
    btn.titleLabel.textAlignment=NSTextAlignmentCenter;
    [btn setTag:tag];
    
    [MSViewFrameUtil setBorder:1 Color:MS_RGB(221, 221, 221) UI:btn];
    btn.layer.cornerRadius=2;
    btn.layer.masksToBounds=YES;
    
    [btn setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [btn addBtnAction:@selector(actHotCity:) target:self];
    [self.viewHotCity addSubview:btn];
}

//点击热门城市
-(void)actHotCity:(id)sender{
    UIButton *btn=(UIButton*)sender;
    
    NSDictionary *dic=hotCity[btn.tag];
    NSString *name=[dic objectForKeyNotNull:@"name"];
    NSString *id=[dic objectForKeyNotNull:@"city_id"];
    
    NSString *ename=[dic objectForKeyNotNull:@"ename"];
    [[NSUserDefaults standardUserDefaults]setObject:ename forKey:@"ename"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[AppDelegate sharedAppDelegate] setCityByName:name ID:id];
    [[AppDelegate sharedAppDelegate] openTabHomeCtrl];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


//点击当前城市
- (IBAction)actCurrentCity:(id)sender {
    
    NSString *cityName=[currentCity objectForKeyNotNull:@"name"];
    NSString *cityID=[currentCity objectForKeyNotNull:@"city_id"];
    
    NSString *ename=[currentCity objectForKeyNotNull:@"ename"];
    [[NSUserDefaults standardUserDefaults]setObject:ename forKey:@"ename"];
    [[NSUserDefaults standardUserDefaults]synchronize];
    
    [[AppDelegate sharedAppDelegate] setCityByName:cityName ID:cityID];
    [[AppDelegate sharedAppDelegate] openTabHomeCtrl];
}

//点击国际城市
- (IBAction)actIntergation:(id)sender {
    
    self.view2.hidden=NO;
    self.view1.hidden=YES;
    
    [self getInterCountry];
    
    isInternation=YES;
    [self getLocation];
}

//点击国内城市
- (IBAction)actOwnCountry:(id)sender {
    
    self.view1.hidden=NO;
    self.view2.hidden=YES;
    
    [self getNowCountry];
    
    isInternation=NO;
    [self getLocation];
    
}

//搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    NSString *texting = [NSString stringWithFormat:@"%@",searchBar.text];
    
    if (isFirstSearch) {
        isFirstSearch=NO;
        
        self.mNewCitySearchList.searchStr=texting;
        [self.mNewCitySearchList initial:self];
    }else{
        
        self.mNewCitySearchList.searchStr=texting;
        [self.mNewCitySearchList refreshData];
    }
    
    [searchBar resignFirstResponder];
    
    self.mNewCitySearchList.hidden=NO;
    self.mnewCityList.hidden=YES;
}

-(void)searchBarTextDidBeginEditing:(UISearchBar *)searchBar{
    self.searchBar.showsCancelButton = YES;
    for(id cc in [self.searchBar subviews])
    {
        if([cc isKindOfClass:[UIButton class]])
        {
            UIButton *sbtn = (UIButton *)cc;
            [sbtn setTitle:@"取消"  forState:UIControlStateNormal];
            //[sbtn setTitleColor:[UIColor grayColor] forState:UIControlStateNormal];
        }
    }
}


-(void)searchBarCancelButtonClicked:(UISearchBar *)searchBar
{//取消按钮被按下时触发
    
    //重置
    searchBar.text=@"";
    //输入框清空
  
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;

    self.mNewCitySearchList.hidden=YES;
    self.mnewCityList.hidden=NO;
    
}



@end

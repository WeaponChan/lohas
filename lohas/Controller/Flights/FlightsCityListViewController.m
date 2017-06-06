//
//  FlightsCityListViewController.m
//  lohas
//
//  Created by fred on 15-3-10.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "FlightsCityListViewController.h"

@interface FlightsCityListViewController (){
    NSArray *openCityList;
    UISegmentedControl *mySegment;
}

@end

@implementation FlightsCityListViewController

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
    
    [self getCityList];
    
    if ([MSUIUtils getIOSVersion] >= 7.0){
        [self addNavBar_LeftBtn:@"navbar_back" action:@selector(actNavBar_Back:)];
    }else{
        [self addNavBar_LeftBtn:[UIImage imageNamed:@"navbar_back"]
                      Highlight:[UIImage imageNamed:@"navbar_back"]
                         action:@selector(actNavBar_Back:)];
    }
}

-(void)actNavBar_Back:(id)sender
{
    if([self.navigationController.viewControllers objectAtIndex:0] == self){
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
}

-(void)viewWillAppear:(BOOL)animated{
    mySegment=[[UISegmentedControl alloc]initWithFrame:CGRectMake((SCREENWIDTH-180)/2, 5, 180, 32)];
    [mySegment insertSegmentWithTitle:@"国内机票" atIndex:0 animated:YES];
    [mySegment insertSegmentWithTitle:@"国际机票" atIndex:1 animated:YES];
    
    mySegment.segmentedControlStyle=UISegmentedControlStyleBar;
    [mySegment addTarget:self action:@selector(segAction:) forControlEvents:UIControlEventValueChanged];
    mySegment.selectedSegmentIndex=0;
    [ self.navigationController.navigationBar addSubview:mySegment];
}

-(void)viewWillDisappear:(BOOL)animated{
    [mySegment removeFromSuperview];
}

-(void)segAction:(id)sender{
    //国内机票
    if (mySegment.selectedSegmentIndex==0) {
        [self getCityList];
    }
    //国际机票
    else if (mySegment.selectedSegmentIndex==1) {
        [self getNationCityList];
    }
    
}

//获取城市列表
-(void)getCityList{
    [self showLoadingView];
    Api *api1=[[Api alloc]init:self tag:@"get_flight_city_lists"];
    [api1 get_flight_city_lists:@"0"];
}
//获取国际城市列表
-(void)getNationCityList{
    [self showLoadingView];
    Api *api1=[[Api alloc]init:self tag:@"get_flight_city_lists"];
    [api1 get_flight_city_lists:@"1"];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
     if ([tag isEqual:@"get_flight_city_lists"]) {
         
        openCityList=response;
        [self.mCityList reloadData];
    }
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexTitleList=[[NSMutableArray alloc]init];
    
    for (NSDictionary *sub in openCityList) {
        NSString *name=[sub objectForKeyNotNull:@"name"];
        [indexTitleList addObject:name];
    }
    
    return indexTitleList;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    return openCityList[section][@"name"];
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    return openCityList.count;
    
}

//设置cell总数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    
    return [openCityList[section][@"items"] count];
    
}

//设置单行高度
- (CGFloat)tableView:(UITableView *)mtableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    return 44;
}

//设置某个cell对象
- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellName = @"UITableViewCell";
    UITableViewCell *cell= [mtableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    NSDictionary*item= openCityList[indexPath.section][@"items"][indexPath.row];
    [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
    cell.textLabel.text=[item objectForKeyNotNull:@"name"];
    
    return cell;
}
//触发单行点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{
    
    NSDictionary*item= openCityList[indexPath.section][@"items"][indexPath.row];
    NSString *cityID=[item objectForKeyNotNull:@"city_id"];
    NSString *name=[item objectForKeyNotNull:@"name"];
    NSString *flag=[item objectForKeyNotNull:@"flag"];
    NSLog(@"item%@",item);
    
    [self.delegate pickedCity:name code:cityID categoryStr:self.categoryStr flag:flag];
    
    [self actNavBar_Back:nil];
    
}

//返回nil，那么所属的row将无法被选中
- (NSIndexPath *)tableView:(UITableView *)tableView willSelectRowAtIndexPath:(NSIndexPath *)indexPath {
    return indexPath;
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

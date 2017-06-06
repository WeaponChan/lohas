//
//  CityListViewController.m
//  chuanmei
//
//  Created by juyuan on 14-8-15.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "CityListViewController.h"
#import "TSMessage.h"

@interface CityListViewController (){
    NSMutableArray *openCityList;//开放城市
    NSDictionary *currentCityItem;
    
    NSArray *hotCityList;//热门城市
    
    NSMutableArray *searchList;
    BOOL isSearch;
    
    int viewHeadHeight;
}

@end

@implementation CityListViewController
@synthesize categoryStr;

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
    [self setNavBarTitle:@"城市选择"];
    // Do any additional setup after loading the view from its nib.
    
    /*if(![CLLocationManager locationServicesEnabled]) {
        [self showAlert:@"无法定位" message:@"请打开定位" tag:999];
    }else{
        NSLog(@"CLLocationManager locationServicesEnabled:%d",[CLLocationManager locationServicesEnabled]);
    }*/
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    isSearch=NO;
    
    [self getHotCity];
    [self getLocation];
}

//获取城市列表
-(void)getCityList{
    
    Api *api1=[[Api alloc]init:self tag:@"get_city_lists"];
    [api1 get_city_lists];
}

-(void)getHotCity{
    [self showLoadingView];
    Api *api1=[[Api alloc]init:self tag:@"get_hot_city"];
    [api1 get_hot_city];
}

-(void)callBackByLocation:(CLLocation *)newLocation{
 
    Api *api=[[Api alloc]init:self tag:@"get_gsp_city"];
    [api get_gsp_city:[NSString stringWithFormat:@"%f",newLocation.coordinate.latitude] lng:[NSString stringWithFormat:@"%f",newLocation.coordinate.longitude]];
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
       [self closeLoadingView];
    if ([tag isEqual:@"get_gsp_city"]) {
    
        currentCityItem=response;
        self.labCity.text=[NSString stringWithFormat:@"当前城市:%@",[response objectForKeyNotNull:@"name"]];
        self.labTag.hidden=YES;
        self.labRadius.hidden=YES;
        
    }
    if ([tag isEqual:@"get_city_lists"]) {
     
        openCityList=response;
        [self.mCityList reloadData];
    }
    if ([tag isEqual:@"get_hot_city"]) {
        //热门城市
        hotCityList=response;
        
        int i=0;//第几个热门城市
        int btnLine;
        for (NSDictionary *btnDic in hotCityList) {
            NSString *name=[btnDic objectForKeyNotNull:@"name"];
            
            btnLine=i/3;//每个按钮在第几行
            int btnLoc=i%3;//每一行第几个按钮
            int btnX = 10+((SCREENWIDTH-32)/3+8)*btnLoc;//每个按钮距离左边的距离
            int btnY = 80+(36+10)*btnLine;//每个按钮距离顶部的距离
            
            [self setHotCityButton:btnX y:btnY title:name tag:i];
            
            i++;
        }
        
        if ([response count]==0) {
            [MSViewFrameUtil setHeight:44 UI:self.viewHotCity];
            [MSViewFrameUtil setHeight:44 UI:self.viewHead];
            self.labHotTitle.hidden=YES;
            
        }else{
          
            [MSViewFrameUtil setHeight:80+(36+10)*(btnLine+1) UI:self.viewHotCity];
            [MSViewFrameUtil setHeight:80+(36+10)*(btnLine+1) UI:self.viewHead];
        }
        
        viewHeadHeight=self.viewHead.frame.size.height;
 
        [self.mCityList setTableHeaderView:self.viewHead];

         [self getCityList];
    }
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
    
    [btn setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [btn addBtnAction:@selector(actHotCity:) target:self];
    [self.viewHead addSubview:btn];
}

//点击热门城市
-(void)actHotCity:(id)sender{
    UIButton *btn=(UIButton*)sender;
    
    NSDictionary *dic=hotCityList[btn.tag];
    NSString *name=[dic objectForKeyNotNull:@"name"];
    NSString *id=[dic objectForKeyNotNull:@"city_id"];
    
    if ([categoryStr isEqual:@"hotel"] || [categoryStr isEqual:@"food"] || [categoryStr isEqual:@"scenery"] || [categoryStr isEqual:@"country"] || [categoryStr isEqual:@"shop"]) {
        
        [self.delegate getSelectCity:name cityID:id];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        if(id && name && [id intValue]>0) {
            [[AppDelegate sharedAppDelegate] setCityByName:name ID:id];
            [[AppDelegate sharedAppDelegate] openTabHomeCtrl];
        }
    }
}


//搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    searchList=[[NSMutableArray alloc]init];
    
    NSString *texting = [NSString stringWithFormat:@"%@",searchBar.text];
    
    for (NSDictionary *sub in openCityList) {
        NSArray *items = [sub objectForKeyNotNull:@"items"];
        NSMutableArray *arrayList=[[NSMutableArray alloc]init];
        for (NSDictionary *list in items) {
            NSString *name=[list objectForKeyNotNull:@"name"];
            NSString *pinyin=[sub objectForKeyNotNull:@"name"];
            NSString *id=[list objectForKeyNotNull:@"city_id"];
            NSString *str=[NSString stringWithFormat:@"%@ %@ %@",name,id,pinyin];
            
            if ([str rangeOfString:texting].location != NSNotFound){
                [arrayList addObject:list];
            }
        }
        
        if (arrayList.count!=0) {
            NSMutableDictionary *diction=[[NSMutableDictionary alloc]init];
            [diction setObject:arrayList forKey:@"items"];
            [diction setObject:[sub objectForKeyNotNull:@"name"] forKey:@"name"];
            [searchList addObject:diction];
        }
    }
    
    if (searchList.count==0) {
        [TSMessage showNotificationInViewController:self title:@"抱歉,未搜索到您指定的城市！" subtitle:nil type:TSMessageNotificationTypeError];
    }
    
    self.viewHead.hidden=YES;
    [MSViewFrameUtil setHeight:0 UI:self.viewHead];
    [self.mCityList setTableHeaderView:self.viewHead];
    
    isSearch=YES;
    [self.mCityList reloadData];

    
    [searchBar resignFirstResponder];
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
    //[_tableView reloadData];
    [searchBar resignFirstResponder];
    searchBar.showsCancelButton=NO;

    self.viewHead.hidden=NO;
    [MSViewFrameUtil setHeight:viewHeadHeight UI:self.viewHead];
    [self.mCityList setTableHeaderView:self.viewHead];
    
    isSearch=NO;
    [self.mCityList reloadData];
    
}

- (NSArray *) sectionIndexTitlesForTableView:(UITableView *)tableView {
    NSMutableArray *indexTitleList=[[NSMutableArray alloc]init];
        
    if (isSearch) {
        for (NSDictionary *sub in searchList) {
            NSString *name=[sub objectForKeyNotNull:@"name"];
            [indexTitleList addObject:name];
        }
        
    }else{
        for (NSDictionary *sub in openCityList) {
            
            NSString *name=[sub objectForKeyNotNull:@"name"];
            [indexTitleList addObject:name];
        }
    }

    return indexTitleList;
}

- (NSString *)tableView:(UITableView *)tableView titleForHeaderInSection:(NSInteger)section
{
    if (!isSearch) {
        
        return openCityList[section][@"name"];
        
    }else{
        return searchList[section][@"name"];
    }
}

- (NSInteger) numberOfSectionsInTableView:(UITableView *)tableView {
    
    if (!isSearch) {
        
        return openCityList.count;
        
    }else{
        return searchList.count;
    }
    
}

//设置cell总数
- (NSInteger)tableView:(UITableView *)tableView numberOfRowsInSection:(NSInteger)section {
    if (isSearch && searchList.count>0) {
        return [searchList[section][@"items"] count];
    }else if(!isSearch){
        return [openCityList[section][@"items"] count];
    }else{
        return 1;
    }
    
}

//设置单行高度
- (CGFloat)tableView:(UITableView *)mtableView heightForRowAtIndexPath:(NSIndexPath *)indexPath
{
    if (!isSearch && openCityList.count==0){
        return [EmptyDataCell Height];
    }else if (isSearch && searchList.count==0){
        return [EmptyDataCell Height];
    }
    return 44;
}
//设置某个cell对象
- (UITableViewCell *)tableView:(UITableView *)mtableView cellForRowAtIndexPath:(NSIndexPath *)indexPath{
    NSString * cellName = @"UITableViewCell";
    UITableViewCell *cell= [mtableView dequeueReusableCellWithIdentifier:cellName];
    if (!cell) {
        cell = [[UITableViewCell alloc] initWithStyle:UITableViewCellStyleDefault reuseIdentifier:cellName];
    }
    
    if (!isSearch) {
        NSDictionary*item= openCityList[indexPath.section][@"items"][indexPath.row];
        [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
        cell.textLabel.text=[item objectForKeyNotNull:@"name"];
    }
    else{
        if (isSearch && searchList.count>0) {
            NSDictionary*item= searchList[indexPath.section][@"items"][indexPath.row];
            [cell.textLabel setFont:[UIFont systemFontOfSize:16]];
            cell.textLabel.text=[item objectForKeyNotNull:@"name"];
        }else{
            cell.textLabel.text=@"您搜索的城市正在努力覆盖中。。。";
            
        }
        
    }
    
    return cell;
}
//触发单行点击事件
-(void)tableView:(UITableView *)tableView didSelectRowAtIndexPath:(NSIndexPath *)indexPath
{

    NSString *cityID;
    NSString *name;
    
    if (!isSearch) {
        NSDictionary*item= openCityList[indexPath.section][@"items"][indexPath.row];
        cityID=[item objectForKeyNotNull:@"city_id"];
        name=[item objectForKeyNotNull:@"name"];
    }else{
        if (isSearch && searchList.count>0) {
            NSDictionary*item= searchList[indexPath.section][@"items"][indexPath.row];
            name=[item objectForKeyNotNull:@"name"];
            cityID=[item objectForKeyNotNull:@"city_id"];
        }else{
            return;
        }
    }
    
    if ([categoryStr isEqual:@"hotel"] || [categoryStr isEqual:@"food"] || [categoryStr isEqual:@"scenery"] || [categoryStr isEqual:@"country"] || [categoryStr isEqual:@"shop"]) {
        
        [self.delegate getSelectCity:name cityID:cityID];        
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        if(cityID && name && [cityID intValue]>0) {
            [[AppDelegate sharedAppDelegate] setCityByName:name ID:cityID];
            [[AppDelegate sharedAppDelegate] openTabHomeCtrl];
        }
    }
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

//点击当前城市
- (IBAction)actClickCurrentCity:(id)sender {

    NSString *cityID=[currentCityItem objectForKeyNotNull:@"city_id"];
    NSString *name=[currentCityItem objectForKeyNotNull:@"name"];
    
    if ([categoryStr isEqual:@"hotel"] || [categoryStr isEqual:@"food"] || [categoryStr isEqual:@"scenery"] || [categoryStr isEqual:@"country"] || [categoryStr isEqual:@"shop"]) {
        
        [self.delegate getSelectCity:name cityID:cityID];
        [self.navigationController popViewControllerAnimated:YES];
        
    }else{
        if(cityID && name && [cityID intValue]>0) {
            [[AppDelegate sharedAppDelegate] setCityByName:name ID:cityID];
            [[AppDelegate sharedAppDelegate] openTabHomeCtrl];
        }
    }
}
@end

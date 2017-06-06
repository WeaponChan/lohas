//
//  SearchViewController.m
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "SearchViewController.h"
#import "TSMessage.h"

@interface SearchViewController (){
    NSMutableArray *btnSelect;
    
    BOOL isFirstSearch;
    
    NSArray *hotCity;
}

@property (weak, nonatomic) IBOutlet UISearchBar *searchBar;

@end

@implementation SearchViewController

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
    [self setNavBarTitle:@"搜索"];
    
    isFirstSearch=YES;
    
    btnSelect=[[NSMutableArray alloc]init];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    self.mSearchPlaceList.hidden=YES;
    
    [self openKeyboardNotification];
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"hotKeywordList"];
    [api hotKeywordList];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"hotKeywordList"]) {
        
        hotCity=response;
        
        int i=0;//第几个热门城市
        int btnLine;
        for (NSDictionary *btnDic in hotCity) {
            NSString *name=[btnDic objectForKeyNotNull:@"name"];
            
            btnLine=i/3;//每个按钮在第几行
            int btnLoc=i%3;//每一行第几个按钮
            int btnX = 10+((SCREENWIDTH-32)/3+8)*btnLoc;//每个按钮距离左边的距离
            int btnY = 10+(36+10)*btnLine;//每个按钮距离顶部的距离
            
            [self setHotCityButton:btnX y:btnY title:name tag:i];
            
            i++;
        }

        
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
    
    [MSViewFrameUtil setBorder:1 Color:MS_RGB(221, 221, 221) UI:btn];
    btn.layer.cornerRadius=2;
    btn.layer.masksToBounds=YES;
    
    [btn setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [btn addBtnAction:@selector(actHotCity:) target:self];
    [self.viewType addSubview:btn];
}

//点击
-(void)actHotCity:(id)sender{
    UIButton *btn=(UIButton*)sender;
    
    NSDictionary *dic=hotCity[btn.tag];
    NSString *name=[dic objectForKeyNotNull:@"name"];
    
    self.viewType.hidden=YES;
    self.mSearchPlaceList.hidden=NO;
    
    if (isFirstSearch) {
        isFirstSearch=NO;

        self.mSearchPlaceList.searchText=name;
        [self.mSearchPlaceList initial:self];
    }else{
        self.mSearchPlaceList.searchText=name;
        [self.mSearchPlaceList refreshData];
    }
    
    self.searchBar.showsCancelButton = NO;
}


//即将显示软键盘监听事件 在openKeyboardNotification进行注册事件
- (void)keyboardWillShow:(NSNotification *)notification {
}

//即将关闭软键盘监听事件 在openKeyboardNotification进行注册事件
- (void)keyboardWillHide:(NSNotification *)notification{
    self.searchBar.showsCancelButton=NO;
}

- (IBAction)actBtnType:(id)sender {
    
    [self resignFirstResponder];
    
    UIButton *btn=(UIButton*)sender;
    int tag=btn.tag;
    
    BOOL isIN=NO;
 
    for (NSString *str in btnSelect) {
        if (str.intValue==tag) {
            isIN=YES;
            break;
        }
    }
    
    if (isIN) {
        btn.selected=NO;
        [btnSelect removeObject:[NSString stringWithFormat:@"%d",tag]];
    }else{
       /* if (btnSelect.count>=3) {
            [TSMessage showNotificationInViewController:self title:@"当前最多选择3个标签" subtitle:nil type:TSMessageNotificationTypeError];
            return;
        }*/
        
        btn.selected=YES;
        [btnSelect addObject:[NSString stringWithFormat:@"%d",tag]];
    }
    
}

//搜索
- (void)searchBarSearchButtonClicked:(UISearchBar *)searchBar{
    
    if (searchBar.text.length==0) {
        [TSMessage showNotificationInViewController:self title:@"温馨提示" subtitle:@"请输入关键字,进行整站搜索" type:TSMessageNotificationTypeError];
        return;
    }
    
    NSString *texting = [NSString stringWithFormat:@"%@",searchBar.text];
    
    NSLog(@"btnselect==%@",btnSelect);
    
    [searchBar resignFirstResponder];
    
    NSString *typeID;
    for (NSString *str in btnSelect) {
        if (typeID.length==0) {
            typeID=str;
        }
        else{
            typeID=[NSString stringWithFormat:@"%@,%@",typeID,str];
        }
    }
    
    self.viewType.hidden=YES;
    self.mSearchPlaceList.hidden=NO;
    
    if (isFirstSearch) {
        isFirstSearch=NO;
        
        self.mSearchPlaceList.type=typeID;
        self.mSearchPlaceList.searchText=texting;
        [self.mSearchPlaceList initial:self];
    }else{
        self.mSearchPlaceList.type=typeID;
        self.mSearchPlaceList.searchText=texting;
        [self.mSearchPlaceList refreshData];
    }

    self.searchBar.showsCancelButton = NO;
    
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
    
    self.mSearchPlaceList.hidden=YES;
    self.viewType.hidden=NO;
    
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

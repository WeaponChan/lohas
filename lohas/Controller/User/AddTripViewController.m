//
//  AddTripViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/23.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "AddTripViewController.h"
#import "SBJson.h"
#import "TSMessage.h"
#import "IQKeyboardManager.h"
#import "FocusTripDeleteCell.h"

@interface AddTripViewController (){
    BOOL isFirstIn;
    
    NSMutableArray *CommitList;
    
    NSString *trip_id;
    NSString *selectedDate;
    
    NSMutableArray *listarr;
}

@end

@implementation AddTripViewController
@synthesize selectList,Title,isEdit,listarr11,tripiD;
- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    if (!selectList) {
        selectList=[[NSMutableArray alloc]init];
    }
    
    
    
    CommitList=[[NSMutableArray alloc]init];
    
    isFirstIn=YES;
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    self.btnCommit.hidden=YES;
    self.btnCommit.layer.cornerRadius=4;
    self.btnCommit.layer.masksToBounds=YES;
    [MSViewFrameUtil setBorder:1 Color:MS_RGB(16, 50, 86) UI:self.btnCommit];
    
    self.textTest.inputView=self.datePicker;
    self.textTest.delegate=self;
    
    UIColor *color = MS_RGB(170, 170, 170);
    self.textName.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"请为你的行程命名" attributes:@{NSForegroundColorAttributeName: color}];
    
     [self.mmainAddList setTableFooterView:self.viewBtn];
    
    [self addNavBar_RightBtnWithTitle:@"编辑" action:@selector(actEdit)];
    if (isEdit) {
        
        [self setNavBarTitle:@"修改行程"];
        
        listarr=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in listarr11) {
            [listarr addObject:dic];
        }
        
        self.textName.text = Title;
        self.mmainAddList.selectList=listarr;
        
        self.mmainAddList.isEdit=isEdit;
        self.btnCommit.hidden = NO;
        [self.mmainAddList initial:self];
        
    }else{
        [self setNavBarTitle:@"添加行程"];
    }
    
    
    [self openKeyboardNotification];

}

-(void)actEdit{
    [self addNavBar_RightBtnWithTitle:@"完成" action:@selector(actEnd)];
    
    self.mmainAddList.isDelete=YES;
    [self.mmainAddList refreshData];
}

-(void)actEnd{
    [self addNavBar_RightBtnWithTitle:@"编辑" action:@selector(actEdit)];
    
    self.mmainAddList.isDelete=NO;
    [self.mmainAddList refreshData];
}

//显示软键盘处理函数，子类重写
- (void)keyboardWillShowUIToDo:(float)keyboardHeight{
    NSLog(@"%f",keyboardHeight);
}

//关闭软键盘处理函数，子类重写
- (void)keyboardWillHideUIToDo{
    // NSLog(@"self.keyboardWillHideUIToDo 子类重写");
    if (isEdit == NO) {
    
    for (NSMutableDictionary *dic in CommitList) {
        NSString *subid=[dic objectForKeyNotNull:@"id"];
        
        if ([subid isEqual:trip_id]) {
            [dic setObject:selectedDate forKey:@"tripDate"];
            break;
        }
    }
    
    self.mmainAddList.selectList=CommitList;
    [self.mmainAddList refreshData];
        
    }
    else{
        
        for (NSMutableDictionary *dic in listarr) {
           
            NSString *subid=[dic objectForKeyNotNull:@"shop_id"];
            
            
            if ([subid isEqual:trip_id]) {
                [dic setObject:selectedDate forKey:@"tripDate"];
                break;
            }
            
        }

        self.mmainAddList.selectList=listarr;
        [self.mmainAddList refreshData];
         
    }
    
    
}

-(void)viewWillAppear:(BOOL)animated{
    [[IQKeyboardManager sharedManager] setEnable:NO];
}

-(void)viewDidDisappear:(BOOL)animated{
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actDestation:(id)sender {
    
    MyFocusTripViewController *viewCtrl=[[MyFocusTripViewController alloc]initWithNibName:@"MyFocusTripViewController" bundle:nil];
    viewCtrl.delegate=self;
    [self.navigationController pushViewController:viewCtrl animated:YES];
    
}

-(void)endSelect:(NSMutableArray*)selectTripList{
    
    CommitList=selectTripList;
    for (NSMutableDictionary *selectdic in selectTripList) {
        NSString *data = [selectdic objectForKeyNotNull:@"data"];
        [selectdic setObject:data forKey:@"shop_id"];
    }

    if (isEdit) {
        listarr=[[NSMutableArray alloc]init];
        for (NSDictionary *dic in CommitList) {

            [listarr addObject:dic];
            
        }
    }

        self.mmainAddList.selectList=selectTripList;
        if (isFirstIn) {
            isFirstIn=NO;
            [self.mmainAddList initial:self];
        }else{
            [self.mmainAddList refreshData];
        }
    
        if (selectTripList.count>0) {
            self.btnCommit.hidden=NO;
        }else{
            self.btnCommit.hidden=YES;
        }
    
}

- (IBAction)actCommit:(id)sender {
    
    if(isEdit){
        if (self.textName.text.length==0) {
            [TSMessage showNotificationInViewController:self title:@"请先填写行程名称" subtitle:nil type:TSMessageNotificationTypeError];
            return;
        }else{

            NSLog(@"listarr=====%@",listarr);
            
            NSMutableArray *submitList=[[NSMutableArray alloc]init];
            for (NSDictionary *dic in listarr) {
                NSMutableDictionary *submitDic=[[NSMutableDictionary alloc]init];
                NSString *shop_id=[dic objectForKeyNotNull:@"shop_id"];
                if (shop_id.length==0) {
                    shop_id=[dic objectForKeyNotNull:@"data"];
                }
                
                [submitDic setObject:shop_id forKey:@"shop_id"];
                [submitDic setObject:[dic objectForKeyNotNull:@"type"] forKey:@"type"];
                
                NSString *time=[dic objectForKeyNotNull:@"tripDate"];
                if (!time) {
                    time=[NSString stringWithFormat:@"%@ %@",[self getNowDate],[self getNowTime]];
                }
                
                [submitDic setObject:time forKey:@"start_time"];
                [submitList addObject:submitDic];
            }
            
            NSString *submitStr=[submitList JSONRepresentation];
            
            [self showLoadingView];
            
            Api *api=[[Api alloc]init:self tag:@"editJourney"];
            [api editJourney:tripiD title:self.textName.text content:submitStr];
            [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo = YES;
            
        }
        
    }
    else{
    
        if (self.textName.text.length==0) {
            [TSMessage showNotificationInViewController:self title:@"请先填写行程名称" subtitle:nil type:TSMessageNotificationTypeError];
            return;
        }
        
        NSMutableArray *submitList=[[NSMutableArray alloc]init];
        
        for (NSDictionary *dic in CommitList) {
            NSMutableDictionary *submitDic=[[NSMutableDictionary alloc]init];
            [submitDic setObject:[dic objectForKeyNotNull:@"data"] forKey:@"shop_id"];
            [submitDic setObject:[dic objectForKeyNotNull:@"type"] forKey:@"type"];
            
            NSString *time=[dic objectForKeyNotNull:@"tripDate"];
            if (!time) {
                time=[NSString stringWithFormat:@"%@ %@",[self getNowDate],[self getNowTime]];
            }
            
            [submitDic setObject:time forKey:@"start_time"];
            [submitList addObject:submitDic];
        }
        
        NSString *submitStr=[submitList JSONRepresentation];
        
        [self showLoadingView];
        Api *api=[[Api alloc]init:self tag:@"addJourney"];
        [api addJourney:self.textName.text content:submitStr];
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo = YES;
    }
    
}

-(void)selectTime:(NSString*)tripID{
    
    trip_id=tripID;
    
    [self.textTest becomeFirstResponder];
    
    NSDate *select1  = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *show1=[dateFormatter stringFromDate:select1];
    selectedDate=[NSString stringWithFormat:@"%@",show1];
    
}

- (IBAction)actDate:(id)sender {
    
    NSDate *select1  = [self.datePicker date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd HH:mm"];
    NSString *show1=[dateFormatter stringFromDate:select1];
    selectedDate=[NSString stringWithFormat:@"%@",show1];
    
}

-(void)deleteTrip:(NSString*)tripID{
    if (isEdit) {
        int i=0;
        for (NSMutableDictionary *dic in listarr) {
            NSString *subid=[dic objectForKeyNotNull:@"shop_id"];
            if ([subid isEqual:tripID]) {
              
                break;
            }
            i++;
        }
        
        [listarr removeObjectAtIndex:i];
        
        self.mmainAddList.selectList=listarr;
        [self.mmainAddList refreshData];
    }
    else{
        int i=0;
        for (NSMutableDictionary *dic in CommitList) {
            NSString *subid=[dic objectForKeyNotNull:@"id"];
            if ([subid isEqual:tripID]) {
                break;
            }
        i++;
    }
    
    [CommitList removeObjectAtIndex:i];
    
    self.mmainAddList.selectList=CommitList;
    [self.mmainAddList refreshData];
    }
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag{
    
    [self closeLoadingView];
    if ([tag isEqual:@"addJourney"]) {
        [AppDelegate sharedAppDelegate].isNeedrefshTrip=YES;
        
        [self.navigationController popViewControllerAnimated:YES];
    }else if ([tag isEqual:@"editJourney"]){
    
        [AppDelegate sharedAppDelegate].isNeedrefshTrip=YES;
        
        [self.navigationController popViewControllerAnimated:YES];
    }
    
}



@end

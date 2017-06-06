//
//  FoodTypeChioceViewController.m
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodTypeChioceViewController.h"
#import "TSMessage.h"
#import "IQKeyboardManager.h"

@interface FoodTypeChioceViewController (){
   NSMutableArray* menuL;
   NSMutableArray* menuList;
   NSMutableArray *selectBtn;
    UIButton *InButton;
    BOOL selectBtnOther;
}

@end

@implementation FoodTypeChioceViewController
@synthesize list,backSelectBtn,Stitle;

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
    [self setNavBarTitle:@"筛选"];
    
//    self.mFoodTypeChioceList.SelectmenuL=menuL;
//    [self.mFoodTypeChioceList initial:self];
    
    [self addNavBar_RightBtnWithTitle:@"确认" action:@selector(actEnsure)];
    
    [[IQKeyboardManager sharedManager] setEnable:NO];
    [TSMessage setDefaultViewController:self.navigationController];
    
    menuList=[[NSMutableArray alloc]init];
    selectBtn=[[NSMutableArray alloc]initWithArray:backSelectBtn];
    
    selectBtnOther=NO;
    if (Stitle.length!=0 && Stitle) {
        selectBtnOther=YES;
        [self.btnOther setTitle:Stitle forState:UIControlStateNormal];
        [self.btnOther setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
        [self.btnOther setBackgroundImage:[UIImage imageNamed:@"btnSelect.png"] forState:UIControlStateNormal];
    }
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_category_lists"];
    [api get_category_lists];
    
}

-(void)viewDidDisappear:(BOOL)animated{
    [[IQKeyboardManager sharedManager] setEnable:YES];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    
    menuList=[[NSMutableArray alloc]initWithArray:response];
    self.btnOther.hidden=NO;
    
  /*  int i=0;
    for (NSMutableDictionary *dic in menuList) {
        [dic setObject:@"NO" forKey:@"select"];
        [dic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"index"];
        i++;
    }*/
    
    int btnNum=0;//第几个按钮
    for (NSDictionary *dic in response) {
        
        int btnRow=btnNum/3;//按钮在第几行
        int btnY=10+btnRow*(40+10);//顶部距离
        int btnLine=btnNum%3;//按钮在第几列
        int btnX=10+btnLine*(93+10);//左边距离
        
        NSString *name=[dic objectForKeyNotNull:@"title"];
        
        [self addAreaButton:name x:btnX y:btnY tag:btnNum];
        
        btnNum++;
    }
    
    int rowNum=(btnNum-1)/3;
    int height = 10+(rowNum+1)*50;
    int subAreaHeight=height+50;
    [MSViewFrameUtil setHeight:subAreaHeight UI:self.viewMain];
    [self.scrollView setContentSize:CGSizeMake(320, subAreaHeight)];

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
    
    for (UIButton *btnse in selectBtn) {
        if (btnse.tag == btn.tag) {
            [btn setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btnSelect.png"] forState:UIControlStateNormal];
        }
    }
    
    [btn addTarget:self action:@selector(clickArea:) forControlEvents:UIControlEventTouchDown];
    [self.viewMain addSubview:btn];
}

//选择
-(void)clickArea:(id)sender{
    
    UIButton *btn=(UIButton*)sender;
    BOOL isExcesit;
    
    if (selectBtn.count==0) {
        [selectBtn addObject:btn];
        [btn setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
        [btn setBackgroundImage:[UIImage imageNamed:@"btnSelect.png"] forState:UIControlStateNormal];

    }else{
        
        for (UIButton *sebtn in selectBtn) {
            if (sebtn.tag== btn.tag) {
                isExcesit=YES;
                InButton=sebtn;
                break;

            }else{
                isExcesit=NO;
             }
            
        }

        if (isExcesit) {
            [selectBtn removeObject:InButton];
            [btn setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        }else{
            [selectBtn addObject:btn];
            [btn setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
            [btn setBackgroundImage:[UIImage imageNamed:@"btnSelect.png"] forState:UIControlStateNormal];
        }
    }
    
}

//确认
-(void)actEnsure{
    NSString *categoryID;
    for (UIButton *btn in selectBtn) {
        int tag=btn.tag;
        
        NSDictionary *dic = menuList[tag];
        NSString *sID=[dic objectForKeyNotNull:@"id"];
        if (categoryID.length==0) {
            categoryID=sID;
        }else{
            categoryID=[NSString stringWithFormat:@"%@,%@",categoryID,sID];
        }
    }
    
    NSString *tit;
    if (selectBtnOther) {
        tit=self.btnOther.titleLabel.text;
    }else{
        tit=@"";
    }
    
    [self.delegate backWithSelectMenu:selectBtn categoryID:categoryID title:tit];
    
    [self.navigationController popViewControllerAnimated:YES];
}


-(void)getSelectCell:(NSMutableArray*)menuList{
    

}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}
//其它
- (IBAction)actOther:(id)sender {
    UIAlertView *alert = [[UIAlertView alloc] initWithTitle:@"请填写搜索内容" message:nil delegate:self cancelButtonTitle:@"取消" otherButtonTitles:@"确认",nil];
    alert.alertViewStyle = UIAlertViewStylePlainTextInput;
    [alert show];
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex{
    if(buttonIndex==alertView.cancelButtonIndex) {
        selectBtnOther=NO;
        [self.btnOther setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
        [self.btnOther setBackgroundImage:[UIImage imageNamed:@""] forState:UIControlStateNormal];
        return;
    }
    
     UITextField *labPoint=[alertView textFieldAtIndex:0];
    if (labPoint.text.length!=0) {
        [self.btnOther setTitle:labPoint.text forState:UIControlStateNormal];
    }
    
    if ([self.btnOther.titleLabel.text isEqual:@"其它"]) {
        selectBtnOther=NO;
        return;
    }
    selectBtnOther=YES;
    [self.btnOther setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
    [self.btnOther setBackgroundImage:[UIImage imageNamed:@"btnSelect.png"] forState:UIControlStateNormal];
}

@end

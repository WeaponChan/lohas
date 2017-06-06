//
//  HotelTypeViewController.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "HotelTypeViewController.h"

@interface HotelTypeViewController (){
    NSMutableArray *typeList;
    NSString *category_id;
    NSString *seName;
}

@end

@implementation HotelTypeViewController

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
    [self setNavBarTitle:@"酒店类型"];
    
    [self.btnClick setAnimationStyle:BTN_ACT_ANIMATION_STYLE_2GRAY];
    [self.btnClick addBtnAction:@selector(actClick) target:self];
    
    [self addNavBar_RightBtnWithTitle:@"确认" action:@selector(actEnsure)];
    
    category_id=@"";
    seName=@"";
    
    typeList=[[NSMutableArray alloc]init];
    
    [self getHotelCategory];
}

//点击确认
-(void)actEnsure{
    [self.delegate selectedType:category_id name:seName];
    
    [self.navigationController popViewControllerAnimated:YES];
}

//点击类型不限
-(void)actClick{
    self.labTag.hidden=!self.labTag.hidden;
    category_id=@"";
    seName=@"";
    if (!self.labTag.hidden) {
        for (NSMutableDictionary *dic in typeList) {
            [dic setObject:@"NO" forKey:@"selected"];
        }
        [self.mHotelTypeList refreshInfo:typeList];
    }
}

-(void)getHotelCategory{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_hotel_category_list"];
    [api get_hotel_category_list];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"get_hotel_category_list"]){
        int i=0;
        for (NSMutableDictionary *dic in response) {
            [dic setObject:[NSString stringWithFormat:@"%d",i] forKey:@"index"];
            [dic setObject:@"NO" forKey:@"selected"];
            [typeList addObject:dic];
             i++;
        }
        [self.mHotelTypeList initialInfo:self list:typeList];
    }
}

//点击Cell时
-(void)changeStyle:(NSString*)index{
    NSMutableDictionary *selectDic=typeList[index.intValue];
    NSString *selected=[selectDic objectForKeyNotNull:@"selected"];
    if ([selected isEqual:@"NO"]) {
        [selectDic setObject:@"YES" forKey:@"selected"];
        self.labTag.hidden=YES;
        category_id=[selectDic objectForKeyNotNull:@"id"];
        seName=[selectDic objectForKeyNotNull:@"star"];
    }else{
       [selectDic setObject:@"NO" forKey:@"selected"];
    }
    
    for (NSMutableDictionary *dic in typeList) {
         NSString *sel=[dic objectForKeyNotNull:@"selected"];
         NSString *ind=[dic objectForKeyNotNull:@"index"];
        if ([sel isEqual:@"YES"] && ind.intValue!=index.intValue) {
            [dic setObject:@"NO" forKey:@"selected"];
        }
    }
    
     [self.mHotelTypeList refreshInfo:typeList];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

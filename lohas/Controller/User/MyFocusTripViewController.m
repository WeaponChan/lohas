//
//  MyFocusTripViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/23.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MyFocusTripViewController.h"

@interface MyFocusTripViewController ()

@end

@implementation MyFocusTripViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"我的收藏"];
    
    selectList=[[NSMutableArray alloc]init];
    
    [self addNavBar_RightBtnWithTitle:@"确定" action:@selector(actComplete)];
    
    self.mAddTripList.selectList=selectList;
    [self.mAddTripList initial:self];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)actComplete{
    
    [self.delegate endSelect:selectList];
    [self.navigationController popViewControllerAnimated:YES];
}

@end

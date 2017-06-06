//
//  RaidersListViewController.m
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "RaidersListViewController.h"
#import "RaidersFilterViewController.h"

@interface RaidersListViewController ()

@end

@implementation RaidersListViewController

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
    [self setNavBarTitle:@"攻略列表"];
    [self addNavBar_RightBtnWithTitle:@"筛选" action:@selector(clickRightButton)];
    // Do any additional setup after loading the view from its nib.
     btnSelected = (UIButton*)[self.view viewWithTag:1];
    
    [self.mRaidersList initial:self];
}

//筛选
-(void)clickRightButton{
    RaidersFilterViewController *viewCtrl=[[RaidersFilterViewController alloc]initWithNibName:@"RaidersFilterViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actClickTag:(id)sender {
    
    [self setSelectedBtn:sender];
    
}

-(void)setSelectedBtn:(UIButton *)btn
{
    //修改选择按钮
    if (btnSelected) {
        [btnSelected setTitleColor:MS_RGB(51, 51, 51) forState:UIControlStateNormal];
    }
    btnSelected = btn;
    [btnSelected setTitleColor:MS_RGB(10,151,252) forState:UIControlStateNormal];
    //移动标识
    [UIView beginAnimations:@"moveViewMark" context:nil];
    [UIView setAnimationDuration:0.3];
    [UIView setAnimationCurve:UIViewAnimationCurveEaseIn];
    [self.viewMark setCenter:btnSelected.center];
    [UIView commitAnimations];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

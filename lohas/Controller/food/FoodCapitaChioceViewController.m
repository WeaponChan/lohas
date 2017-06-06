//
//  FoodCapitaChioceViewController.m
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "FoodCapitaChioceViewController.h"

@interface FoodCapitaChioceViewController (){
    NSArray *titleList;
}

@end

@implementation FoodCapitaChioceViewController

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
    [self setNavBarTitle:@"人均选择"];
    
    titleList=[[NSArray alloc]initWithObjects:@"不限人均",@"0-10",@"10-30",@"30-50",@"50-100",@"100以上", nil];
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actButton:(id)sender {
    
    UIButton *btn=(UIButton*)sender;
    
    [self.delegate getCapita:btn.tag title:titleList[btn.tag]];
    
    [self.navigationController popViewControllerAnimated:YES];
}
@end

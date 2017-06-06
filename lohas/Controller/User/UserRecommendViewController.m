//
//  UserRecommendViewController.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserRecommendViewController.h"
#import "UserRecommendBusinessViewController.h"
#import "UserRecommendFriendViewController.h"

@interface UserRecommendViewController ()

@end

@implementation UserRecommendViewController

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
    [self setNavBarTitle:@"我来推荐"];
    // Do any additional setup after loading the view from its nib.
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//推荐商家
- (IBAction)actRecommendBusiness:(id)sender {
    UserRecommendBusinessViewController *viewCtrl=[[UserRecommendBusinessViewController alloc]initWithNibName:@"UserRecommendBusinessViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//推荐用户
- (IBAction)actRecommendUser:(id)sender {
    UserRecommendFriendViewController *viewCtrl=[[UserRecommendFriendViewController alloc]initWithNibName:@"UserRecommendFriendViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

@end

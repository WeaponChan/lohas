//
//  DynamicJubaoSuccessViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicJubaoSuccessViewController.h"
#import "UserSignupPactViewController.h"

@interface DynamicJubaoSuccessViewController ()

@end

@implementation DynamicJubaoSuccessViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"举报成功"];
    
    if (self.navigationController.childViewControllers.count==1) {
        if ([MSUIUtils getIOSVersion] >= 7.0){
            [self addNavBar_LeftBtn:@"navbar_icon_back" action:@selector(actNavBar_Back:)];
        }else{
            [self addNavBar_LeftBtn:[UIImage imageNamed:@"navbar_icon_back"]
                          Highlight:[UIImage imageNamed:@"navbar_icon_back"]
                             action:@selector(actNavBar_Back:)];
        }
    }
}

-(void)actNavBar_Back:(id)sender
{
    if([self.navigationController.viewControllers objectAtIndex:0] == self){
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        [self.navigationController popToRootViewControllerAnimated:true];
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actClick:(id)sender {
    UserSignupPactViewController *viewCtrl=[[UserSignupPactViewController alloc]initWithNibName:@"UserSignupPactViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}
@end

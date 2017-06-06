//
//  UserSignupPactViewController.m
//  lohas
//
//  Created by juyuan on 14-12-15.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "UserSignupPactViewController.h"

@interface UserSignupPactViewController ()

@end

@implementation UserSignupPactViewController

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
    [self setNavBarTitle:@"注册协议"];
    
    self.scrollView.hidden=YES;
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"get_user_intro"];
    [api get_user_intro];
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    
    self.scrollView.hidden=NO;
    
    NSLog(@"respose%@",response);
    self.labInfo.text=[response objectForKeyNotNull:@"content"];
    [self.labInfo sizeToFit];
    
    int height=self.labInfo.frame.size.height;
    
    [self.scrollView setContentSize:CGSizeMake(320, height+20)];
}


- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

@end

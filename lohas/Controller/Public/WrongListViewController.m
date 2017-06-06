//
//  WrongListViewController.m
//  lohas
//
//  Created by fred on 15-4-15.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "WrongListViewController.h"
#import "TSMessage.h"

@interface WrongListViewController (){
    NSString *categoryID;
}

@end

@implementation WrongListViewController
@synthesize subID,type;

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
    [self setNavBarTitle:@"纠错列表"];
    
    [self.mWrongList initial:self];
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self addNavBar_RightBtnWithTitle:@"提交" action:@selector(actCommit)];
}

-(void)actCommit{
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"submit_wrong"];
    [api submit_wrong:subID type:type category_id:categoryID];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationInViewController:self title:message subtitle:nil type:TSMessageNotificationTypeError];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"submit_wrong"]) {
        [TSMessage showNotificationInViewController:self title:[response objectForKeyNotNull:@"message"] subtitle:nil type:TSMessageNotificationTypeSuccess];
        [self performBlock:^{
            [self.navigationController popViewControllerAnimated:YES];
        }afterDelay:1.5];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)getSelectId:(NSString*)Id{
    categoryID=Id;
    
    NSLog(@"categoryID==%@",categoryID);
}

@end

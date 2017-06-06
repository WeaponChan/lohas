//
//  DynamicJubaoListViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicJubaoListViewController.h"
#import "TSMessage.h"
#import "DynamicJubaoSuccessViewController.h"
#import "DynamicJubaoNeedknowViewController.h"

@interface DynamicJubaoListViewController (){
    NSString *jubao_id;
}

@end

@implementation DynamicJubaoListViewController
@synthesize type,typeID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"举报"];
    
    [self.mDynamicJubaoList initial:self];
    
    [self addNavBar_RightBtnWithTitle:@"提交" action:@selector(actCommit)];
    [TSMessage setDefaultViewController:self.navigationController];
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

-(void)selectJubao:(NSString*)jubaoID{
    
    jubao_id=jubaoID;
    
    self.mDynamicJubaoList.jubao_id=jubao_id;
    [self.mDynamicJubaoList refreshData];
   
}

-(void)actCommit{
    if (jubao_id.length==0) {
        [TSMessage showNotificationInViewController:self title:@"请先选择选择举报理由" subtitle:nil type:TSMessageNotificationTypeError];
        return;
    }
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"submitReport"];
    [api submitReport:type data:typeID category_id:jubao_id];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"submitReport"]) {
        DynamicJubaoSuccessViewController *viewCtrl=[[DynamicJubaoSuccessViewController alloc]initWithNibName:@"DynamicJubaoSuccessViewController" bundle:nil];
        [self.navigationController pushViewController:viewCtrl animated:YES];
    }
}

- (IBAction)actNeedKnow:(id)sender {
    DynamicJubaoNeedknowViewController *viewCtrl=[[DynamicJubaoNeedknowViewController alloc]initWithNibName:@"DynamicJubaoNeedknowViewController" bundle:nil];
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

@end

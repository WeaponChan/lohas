//
//  DynamicJubaoNeedknowViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicJubaoNeedknowViewController.h"

@interface DynamicJubaoNeedknowViewController ()

@end

@implementation DynamicJubaoNeedknowViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavBarTitle:@"举报须知"];
    
    self.scrollView.hidden=YES;
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"getReportNotice"];
    [api getReportNotice];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"getReportNotice"]) {
        self.labContent.text=[response objectForKeyNotNull:@"content"];
        
        [self.labContent sizeToFit];
        int height = self.labContent.frame.size.height;
        [self.scrollView setContentSize:CGSizeMake(SCREENWIDTH, 56+height+10)];
        
        self.scrollView.hidden=NO;
    }
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

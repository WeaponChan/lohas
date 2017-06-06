//
//  DynamicCommentListViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicCommentListViewController.h"

@interface DynamicCommentListViewController ()

@end

@implementation DynamicCommentListViewController
@synthesize said_id;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"评论"];
    
    self.mDynamicCommentList.said_id=said_id;
    [self.mDynamicCommentList initial:self];
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


@end

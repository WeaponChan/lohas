//
//  subDiscoverListViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "subDiscoverListViewController.h"

@interface subDiscoverListViewController (){
    BOOL isFirstIn;
}

@end

@implementation subDiscoverListViewController
@synthesize rankID,typeID;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:self.mainTitle];
    
    self.msubDiscoverRankList.rankID=rankID;
    self.msubDiscoverRankList.typeID=typeID;
    [self.msubDiscoverRankList initial:self];
    
    [self addNavBar_RightBtnWithTitle:@"选择地区" action:@selector(actArea)];
    
    isFirstIn=YES;
    
    [self.view addSubview:self.viewArea];
    self.viewArea.hidden=YES;
    self.mAreaList.category_id=typeID;
}

-(void)actArea{
    self.viewArea.hidden=NO;
    
    if (isFirstIn) {
        isFirstIn=NO;
        [self.mAreaList initial:self];
    }else{
        [self.mAreaList refreshData];
    }
    
}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actHidden:(id)sender {
    self.viewArea.hidden=YES;
}

-(void)refreshInfo:(NSString*)infoID{
    
    self.viewArea.hidden=YES;
    
    self.msubDiscoverRankList.rankID=infoID;
    [self.msubDiscoverRankList refreshData];
}

@end

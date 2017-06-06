//
//  DiscoverRankListViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DiscoverRankListViewController.h"
#import "ShareSdkUtils.h"

@interface DiscoverRankListViewController (){
    BOOL isFirstIn;
}

@end

@implementation DiscoverRankListViewController
@synthesize interest_id,category_id,title,mainTitle;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    [self setNavBarTitle:@"详情"];
    
    isFirstIn=YES;
    
    self.labTItle.text=mainTitle;
    
    self.mDiscoverRankList.isCityIn=YES;
    self.mDiscoverRankList.interest_id=interest_id;
    self.mDiscoverRankList.category_id=category_id;
    [self.mDiscoverRankList initial:self];
    
    [self addNavBar_RightBtn:[UIImage imageNamed:@"nShare.png"] Highlight:[UIImage imageNamed:@"nShare.png"] action:@selector(actDoFav)];
    
    /*
    [self addNavBar_RightBtnWithTitle:@"选择地区" action:@selector(actArea)];
    [self.view addSubview:self.viewArea];
    self.viewArea.hidden=YES;
    self.mAreaList.category_id=category_id;
    */
}

//分享
-(void)actDoFav{

    NSString *SUrl=[NSString stringWithFormat:@"http://lohas2.dev.lohas-travel.com/wap/share/rankShare?id=%@",interest_id];
    
    NSString *content=[NSString stringWithFormat:@"%@ %@",mainTitle, SUrl];
        
    [ShareSdkUtils share:mainTitle url:SUrl content:content image:nil delegate:nil parentView:self shareImage:self.imageView textStr:nil];


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
@end

//
//  NewUserViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/23.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "NewUserViewController.h"
#import "UserInfoChangeViewController.h"
#import "TSMessage.h"
#import "AddorReleaseCell.h"
#import "PhotoGetMoreCell.h"
#import "DynamicCollectionViewCell.h"
#import "UserSettingViewController.h"
#import "DynamicZanListViewController.h"
#import "MyTripViewController.h"
#import "MyTripListViewController.h"
#import "DynamicUserZanCell.h"
#import "MJRefresh.h"

@interface NewUserViewController (){
    NSMutableArray *totalSaidList;
    NSArray *saidList;
    
    int pageIndex;
    
    UIRefreshControl *refreshControl;
    
    NSNumber *more;
}

@end

@implementation NewUserViewController
@synthesize isOtherIn;

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    //[self closeLoadingView];
    [self setNavBarTitle:@"我的"];
    
    totalSaidList=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"tag"];
    [totalSaidList addObject:dic];
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self addNavBar_RightBtn:[UIImage imageNamed:@"newSetting.png"] Highlight:[UIImage imageNamed:@"newSetting.png"] action:@selector(actDetail)];
    
    self.imageHead.layer.cornerRadius=35;
    self.imageHead.layer.masksToBounds=YES;
    
    pageIndex=1;
    
    [self.collectionView registerClass:[AddorReleaseCell class] forCellWithReuseIdentifier:@"AddorReleaseCell"];
    [self.collectionView registerClass:[DynamicCollectionViewCell class] forCellWithReuseIdentifier: @"DynamicCollectionViewCell"];
    [self.collectionView registerClass:[PhotoGetMoreCell class] forCellWithReuseIdentifier: @"PhotoGetMoreCell"];
   // [self.scrollVIew setContentSize:CGSizeMake(320,654)];
    
    if (isOtherIn) {
        [MSViewFrameUtil setHeight:372 UI:self.collectionView];
    }
    
    [self addFooter];
    [self setCollectionInfo];
    
    [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=NO;
    
    [self getUsetInfo];
    [self closeLoadingView];
}

-(void)setCollectionInfo{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    self.collectionView.collectionViewLayout = flowLayout;
    self.collectionView.alwaysBounceVertical = YES;
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(controlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.collectionView addSubview:refreshControl];
}

-(void)controlEventValueChanged{
    
    [self.collectionView setFooterHidden:NO];
    
    pageIndex=1;
    totalSaidList=[[NSMutableArray alloc]init];
    NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
    [dic setObject:@"1" forKey:@"tag"];
    [totalSaidList addObject:dic];
    
    [self getUsetInfo];
    
}


-(void)moveScrollerView:(float)y{
    CGPoint newOffset = self.scrollVIew.contentOffset;
    newOffset.y = y;
    [self.scrollVIew setContentOffset:newOffset animated:YES];

    
}

-(void)viewWillAppear:(BOOL)animated{
    
    if (![self isLogin]) {
        self.viewHead.hidden=YES;
        self.viewMid.hidden=YES;
        self.collectionView.hidden=YES;
        [self showAlert:@"立即登录？" message:nil tag:1];
        return;
    }else{
        self.viewHead.hidden=NO;
        self.viewMid.hidden=NO;
        self.collectionView.hidden=NO;
    }
    
    if ([AppDelegate sharedAppDelegate].isNeedrefreshUserInfo) {
        
        //[self showLoadingView];
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=NO;
        
        totalSaidList=[[NSMutableArray alloc]init];
        NSMutableDictionary *dic=[[NSMutableDictionary alloc]init];
        [dic setObject:@"1" forKey:@"tag"];
        [totalSaidList addObject:dic];
        [self getUsetInfo];
        
    }
    
}

-(void)getUsetInfo{
    Api *api=[[Api alloc]init:self tag:@"get_user_info"];
    [api get_user_info];
}

-(void)actDetail{
    
    if (![self isLogin]) {
        [self showAlert:@"立即登录？" message:nil tag:1];
        
        return;
    }
    
    UserSettingViewController *viewCtrl=[[UserSettingViewController alloc]initWithNibName:@"UserSettingViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}


- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    if(buttonIndex==alertView.cancelButtonIndex){
        return;
    }
    
    if(alertView.tag==1){
        [self presentToLoginView:self];
    }
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [TSMessage showNotificationWithTitle:message
                                subtitle:nil
                                    type:TSMessageNotificationTypeError];
    
    if ([tag isEqualToString:@"get_user_info"] && [message isEqual:@"请先登录"]) {
        [[NSUserDefaults standardUserDefaults]setObject:@"" forKey:@"token"];
        [[NSUserDefaults standardUserDefaults]synchronize];
        
        [AppDelegate sharedAppDelegate].isNeedrefreshUserInfo=YES;
        
        [self presentToLoginView:self];
    }
    
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"get_user_info"]) {
        
        NSString *uid=[response objectForKeyNotNull:@"uid"];
        
        pageIndex=1;
        Api *api=[[Api alloc]init:self tag:@"homePage"];
        [api homePage:uid page:1 limit:20];
      
    }
    else if ([tag isEqual:@"homePage"]){
        NSString *avatar=[response objectForKeyNotNull:@"avatar"];
        
        [self.imageHead setContentScaleFactor:[[UIScreen mainScreen] scale]];
        self.imageHead.contentMode =  UIViewContentModeScaleAspectFill;
        self.imageHead.clipsToBounds  = YES;
        [self.imageHead loadImageAtURLString:avatar placeholderImage:[UIImage imageNamed:@"default_bg100x100.png"]];
        
        self.labName.text=[response objectForKeyNotNull:@"nick"];
        self.labInfo.text=[response objectForKeyNotNull:@"sign"];
        
        NSString *sex=[response objectForKeyNotNull:@"sex"];
        if (sex.intValue==1) {
            [self.imageSex setImage:[UIImage imageNamed:@"nan.png"]];
        }else{
            [self.imageSex setImage:[UIImage imageNamed:@"nv.png"]];
        }
        [self.labName sizeToFit];
        [MSViewFrameUtil setHeight:21 UI:self.labName];
        int width=self.labName.frame.size.width;
        [MSViewFrameUtil setLeft:78+width+2 UI:self.imageSex];

        
        self.labNum1.text=[response objectForKeyNotNull:@"said_num"];
        self.labNum2.text=[response objectForKeyNotNull:@"fans_num"];
        self.labNum3.text=[response objectForKeyNotNull:@"attention_num"];
  
        self.labNum4.text=[response objectForKeyNotNull:@"journey_num"];
        
        //saidList=[response objectForKeyNotNull:@"saidList"];
        
        Api *api=[[Api alloc]init:self tag:@"mySaidList"];
        [api mySaidList:pageIndex limit:20];
        
        
    }
    else if ([tag isEqual:@"mySaidList"]){
        
        if (refreshControl) {
            [refreshControl endRefreshing];
        }
        
        more=[response objectForKeyNotNull:@"more"];
        if (more.intValue==0) {
            [self.collectionView setFooterHidden:YES];
        }
        
        pageIndex++;
        
        saidList=[response objectForKeyNotNull:@"items"];
        [totalSaidList addObjectsFromArray:saidList];
        
        [self.collectionView reloadData];
    }
    
}

#pragma mark - Collection View Data Source
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return totalSaidList.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    /*
    if (totalSaidList.count%21==0 && indexPath.row+2>totalSaidList.count && saidList.count>0) {
        static NSString * CellIdentifier = @"PhotoGetMoreCell";
        PhotoGetMoreCell *cell = (PhotoGetMoreCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        NSDictionary *dic=[totalSaidList objectAtIndex:indexPath.row];
        [cell updateCell:self item:dic];
        return cell;
    }
    else{
        
        NSDictionary *diction=[totalSaidList objectAtIndex:indexPath.row];
        NSString *tag=[diction objectForKeyNotNull:@"tag"];
        if (tag.intValue==1) {
            
            static NSString * CellIdentifier = @"AddorReleaseCell";
            AddorReleaseCell *cell = (AddorReleaseCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];

            [cell updateCell:self item:diction];
            return cell;
            
        }else{
            static NSString * CellIdentifier = @"DynamicCollectionViewCell";
            DynamicCollectionViewCell *cell = (DynamicCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
            [cell updateCell:self itemData:diction];
            return cell;
        }
        

    }*/
    
    NSDictionary *diction=[totalSaidList objectAtIndex:indexPath.row];
    NSString *tag=[diction objectForKeyNotNull:@"tag"];
    if (tag.intValue==1) {
        
        static NSString * CellIdentifier = @"AddorReleaseCell";
        AddorReleaseCell *cell = (AddorReleaseCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        [cell updateCell:self item:diction];
        return cell;
        
    }else{
        static NSString * CellIdentifier = @"DynamicCollectionViewCell";
        DynamicCollectionViewCell *cell = (DynamicCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        [cell updateCell:self itemData:diction];
        return cell;
    }
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREENWIDTH-4)/3, (SCREENWIDTH-4)/3);
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (totalSaidList.count%21==0 && indexPath.row+2>totalSaidList.count && saidList.count>0) {
        Api *api=[[Api alloc]init:self tag:@"mySaidList"];
        [api mySaidList:pageIndex limit:20];
    }else{
        
        NSDictionary *diction=[totalSaidList objectAtIndex:indexPath.row];
        NSString *tag=[diction objectForKeyNotNull:@"tag"];
        if (tag.intValue==1) {
            AddorReleaseCell * cell = (AddorReleaseCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.backgroundColor = [UIColor clearColor];
            
        }else{
            DynamicCollectionViewCell * cell = (DynamicCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
            cell.backgroundColor = [UIColor clearColor];
        }
        

    }
    
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.collectionView addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        [self reloadDynamic];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [vc.collectionView reloadData];
            // 结束刷新
            [vc.collectionView footerEndRefreshing];
            if (more.intValue==0) {
                [vc.collectionView setFooterHidden:YES];
            }
            
        });
    }];
}

-(void)reloadDynamic{
    Api *api=[[Api alloc]init:self tag:@"mySaidList"];
    [api mySaidList:pageIndex limit:20];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actEditInfo:(id)sender {
    
    UserInfoChangeViewController *viewCtrl=[[UserInfoChangeViewController alloc]initWithNibName:@"UserInfoChangeViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actFans:(id)sender {
    DynamicZanListViewController *viewCtrl=[[DynamicZanListViewController alloc]initWithNibName:@"DynamicZanListViewController" bundle:nil];
    viewCtrl.isFans=YES;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actAttention:(id)sender {
    DynamicZanListViewController *viewCtrl=[[DynamicZanListViewController alloc]initWithNibName:@"DynamicZanListViewController" bundle:nil];
    viewCtrl.isFocus=YES;
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

//我的行程
- (IBAction)actTrip:(id)sender {
    MyTripListViewController *viewCtrl=[[MyTripListViewController alloc]initWithNibName:@"MyTripListViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

-(void)getMore{
    
    Api *api=[[Api alloc]init:self tag:@"mySaidList"];
    [api mySaidList:pageIndex limit:20];
    
}

@end

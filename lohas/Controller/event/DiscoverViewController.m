//
//  DiscoverViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DiscoverViewController.h"
#import "DiscoverGuideCollectionViewCell.h"
#import "DisCoverGuideMoreCollectionViewCell.h"
#import "DiscoverSearchViewController.h"
#import "MJRefresh.h"

@interface DiscoverViewController (){
    int page;
    NSArray *GuideList;
    NSMutableArray *DiscoverList;
    
    BOOL isFirstInRank;
    
    UIRefreshControl *refreshControl;
    
    NSNumber *more;
}

@end

@implementation DiscoverViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    DiscoverList=[[NSMutableArray alloc]init];
    
    isFirstInRank=YES;
    
    self.navigationItem.titleView=self.viewTitle;
    self.viewSub.layer.cornerRadius=4;
    self.viewSub.layer.masksToBounds=YES;
    [MSViewFrameUtil setBorder:1 Color:MS_RGB(16, 51, 92) UI:self.viewSub];
    
    [self.mDiscoverRankList setTableHeaderView:self.viewTitleHead];
    self.btnArea.hidden=YES;
    
    [self.view addSubview:self.viewArea];
    self.viewArea.hidden=YES;
    
    
    [self.collection registerClass:[DiscoverGuideCollectionViewCell class] forCellWithReuseIdentifier: @"DiscoverGuideCollectionViewCell"];
    [self.collection registerClass:[DisCoverGuideMoreCollectionViewCell class] forCellWithReuseIdentifier: @"DisCoverGuideMoreCollectionViewCell"];
    
    self.mDiscoverRankList.hidden=YES;
    
    [self setCollectionInfo];
    [self addFooter];
    
    page=1;
    //[self showLoadingView];
    //[self reloadGuide];
}

-(void)setCollectionInfo{
    UICollectionViewFlowLayout *flowLayout = [[UICollectionViewFlowLayout alloc] init];
    flowLayout.minimumInteritemSpacing = 0;
    flowLayout.minimumLineSpacing = 0;
    
    self.collection.collectionViewLayout = flowLayout;
    self.collection.alwaysBounceVertical = YES;
    
    refreshControl = [[UIRefreshControl alloc] init];
    [refreshControl addTarget:self action:@selector(controlEventValueChanged) forControlEvents:UIControlEventValueChanged];
    
    [self.collection addSubview:refreshControl];
}

- (void)addFooter
{
    __unsafe_unretained typeof(self) vc = self;
    // 添加上拉刷新尾部控件
    [self.collection addFooterWithCallback:^{
        // 进入刷新状态就会回调这个Block
        
        [self reloadGuide];
        
        // 模拟延迟加载数据，因此2秒后才调用）
        dispatch_after(dispatch_time(DISPATCH_TIME_NOW, (int64_t)(1.0 * NSEC_PER_SEC)), dispatch_get_main_queue(), ^{
            
            [vc.collection reloadData];
            // 结束刷新
            [vc.collection footerEndRefreshing];
            if (more.intValue==0) {
                [vc.collection setFooterHidden:YES];
            }
            
        });
    }];
}


-(void)controlEventValueChanged{
    
    if (![self isLogin]) {
        [self showAlert:@"立即登录？" message:nil tag:1];
        return;
    }
    
    [self.collection setFooterHidden:NO];
    
    page=1;
    DiscoverList=[[NSMutableArray alloc]init];
    [self reloadGuide];
}


-(void)viewWillAppear:(BOOL)animated{
    if (![self isLogin]) {
        
        [self showAlert:@"立即登录？" message:nil tag:1];
        return;
    }
    
    if ([AppDelegate sharedAppDelegate].isNeedReloadGuide) {
        [AppDelegate sharedAppDelegate].isNeedReloadGuide=NO;
        
        [self reloadGuide];
    }
}

-(void)reloadGuide{
    
    Api *api=[[Api alloc]init:self tag:@"guideList"];
    [api guideList:page limit:20];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showMessage:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"guideList"]) {
        
        if (refreshControl) {
            [refreshControl endRefreshing];
        }
        
        more=[response objectForKeyNotNull:@"more"];
        if (more.intValue==0) {
            [self.collection setFooterHidden:YES];
        }
        
        page++;
        
        NSArray *items=[response objectForKeyNotNull:@"items"];
        
        GuideList=items;
        
        [DiscoverList addObjectsFromArray:GuideList];
        
        [self.collection reloadData];
        
    }
}

- (void)alertView:(UIAlertView *)alertView clickedButtonAtIndex:(NSInteger)buttonIndex NS_DEPRECATED_IOS(2_0, 9_0){
    if(buttonIndex==alertView.cancelButtonIndex){
        return;
    }
    
    if(alertView.tag==1){
        [self presentToLoginView:self];
    }
}


#pragma mark - Collection View Data Source
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return DiscoverList.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    if (DiscoverList.count%20==0 && indexPath.row+2>DiscoverList.count && GuideList.count>0 && DiscoverList.count>0) {
        static NSString * CellIdentifier = @"DisCoverGuideMoreCollectionViewCell";
        DisCoverGuideMoreCollectionViewCell *cell = (DisCoverGuideMoreCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        NSDictionary *dic=[DiscoverList objectAtIndex:indexPath.row];
        [cell updateCell:self item:dic];
        return cell;
    }
    else{
        static NSString * CellIdentifier = @"DiscoverGuideCollectionViewCell";
        DiscoverGuideCollectionViewCell *cell = (DiscoverGuideCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        
        if (DiscoverList.count>0) {
            NSDictionary *dic=[DiscoverList objectAtIndex:indexPath.row];
            [cell updateCell:self itemData:dic];
        }

        return cell;
    }
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREENWIDTH-4)/2, (SCREENWIDTH-4)/2);
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(1, 1, 1, 1);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DiscoverGuideCollectionViewCell * cell = (DiscoverGuideCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}




- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (IBAction)actRank:(id)sender {
    self.collection.hidden=YES;
    self.mDiscoverRankList.hidden=NO;
    
    [self.btnGuide setBackgroundColor:[UIColor clearColor]];
    [self.btnRank setBackgroundColor:MS_RGB(42, 141, 250)];
    
    if (isFirstInRank) {
        isFirstInRank=NO;
        [self.mDiscoverRankList initial:self];
    }else{
        [self.mDiscoverRankList refreshData];
    }
    
    self.btnArea.hidden=NO;
    self.btnSearch.hidden=YES;
    
}

- (IBAction)actGuide:(id)sender {
    self.collection.hidden=NO;
    self.mDiscoverRankList.hidden=YES;
    
    [self.btnRank setBackgroundColor:[UIColor clearColor]];
    [self.btnGuide setBackgroundColor:MS_RGB(42, 141, 250)];

    self.btnArea.hidden=YES;
    self.btnSearch.hidden=NO;
}

- (IBAction)actSearch:(id)sender {
    DiscoverSearchViewController *viewCtrl=[[DiscoverSearchViewController alloc]initWithNibName:@"DiscoverSearchViewController" bundle:nil];
    viewCtrl.hidesBottomBarWhenPushed=YES;
    [self.navigationController pushViewController:viewCtrl animated:YES];
}

- (IBAction)actArea:(id)sender {
    self.viewArea.hidden=NO;
}

- (IBAction)actHidden:(id)sender {
    self.viewArea.hidden=YES;
}

@end

//
//  DiscoverSearchViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DiscoverSearchViewController.h"
#import "DiscoverGuideCollectionViewCell.h"
#import "DisCoverGuideMoreCollectionViewCell.h"
#import "TSMessage.h"

@interface DiscoverSearchViewController (){
    NSArray *searchList;
}

@end

@implementation DiscoverSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    self.navigationItem.titleView=self.viewHead;
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    [self.collection registerClass:[DiscoverGuideCollectionViewCell class] forCellWithReuseIdentifier: @"DiscoverGuideCollectionViewCell"];
    [self.collection registerClass:[DisCoverGuideMoreCollectionViewCell class] forCellWithReuseIdentifier: @"DisCoverGuideMoreCollectionViewCell"];
    
    UIColor *color = MS_RGB(255, 255, 255);
    self.textSearch.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"城市，文章名称" attributes:@{NSForegroundColorAttributeName: color}];
}


- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}


- (IBAction)actSearch:(id)sender {
    
    if (self.textSearch.text.length==0) {
        [TSMessage showNotificationInViewController:self title:@"请填写搜索内容" subtitle:nil type:TSMessageNotificationTypeError];
        return;
    }
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"guideSearch"];
    [api guideSearch:self.textSearch.text page:1 limit:100];
    
}


-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"guideSearch"]) {
        
        NSArray *items=[response objectForKeyNotNull:@"items"];
        
        searchList=items;
        
        [self.collection reloadData];
        
    }
}

#pragma mark - Collection View Data Source
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return searchList.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
        static NSString * CellIdentifier = @"DiscoverGuideCollectionViewCell";
        DiscoverGuideCollectionViewCell *cell = (DiscoverGuideCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        NSDictionary *dic=[searchList objectAtIndex:indexPath.row];
        [cell updateCell:self itemData:dic];
        return cell;
    
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


@end

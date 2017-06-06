//
//  DynamicSearchViewController.m
//  lohas
//
//  Created by Juyuan123 on 16/3/21.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "DynamicSearchViewController.h"
#import "PhotoGetMoreCell.h"
#import "DynamicCollectionViewCell.h"
#import "TSMessage.h"

@interface DynamicSearchViewController (){
    NSMutableArray *photoList;
    NSArray *saidList;
    int page;
}

@end

@implementation DynamicSearchViewController

- (void)viewDidLoad {
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    page=1;
    
    photoList=[[NSMutableArray alloc]init];
    
    self.navigationItem.titleView=self.viewHead;
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    UIColor *color = MS_RGB(255, 255, 255);
    self.textSearch.attributedPlaceholder=[[NSAttributedString alloc] initWithString:@"动态关键字" attributes:@{NSForegroundColorAttributeName: color}];
    
    [self.collection registerClass:[DynamicCollectionViewCell class] forCellWithReuseIdentifier: @"DynamicCollectionViewCell"];
    [self.collection registerClass:[PhotoGetMoreCell class] forCellWithReuseIdentifier: @"PhotoGetMoreCell"];

}

- (void)didReceiveMemoryWarning {
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

//搜索
- (IBAction)actSearch:(id)sender {
    
    if (self.textSearch.text.length==0) {
        [TSMessage showNotificationInViewController:self title:@"请先填写" subtitle:nil type:TSMessageNotificationTypeError];
        return;
    }
    
    [self.textSearch resignFirstResponder];
    
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"searchSaidList"];
    [api searchSaidList:self.textSearch.text page:page limit:21];
    
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"searchSaidList"]) {
        saidList=[response objectForKeyNotNull:@"items"];
        
        page++;
        [photoList addObjectsFromArray:saidList];

        [self.collection reloadData];
        
    }
}

#pragma mark - Collection View Data Source
//定义展示的UICollectionViewCell的个数
-(NSInteger)collectionView:(UICollectionView *)collectionView numberOfItemsInSection:(NSInteger)section
{
    return photoList.count;
}

//定义展示的Section的个数
-(NSInteger)numberOfSectionsInCollectionView:(UICollectionView *)collectionView
{
    return 1;
}

//每个UICollectionView展示的内容
-(UICollectionViewCell *)collectionView:(UICollectionView *)collectionView cellForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    if (photoList.count%21==0 && indexPath.row+2>photoList.count && saidList.count>0) {
        
        static NSString * CellIdentifier = @"PhotoGetMoreCell";
        PhotoGetMoreCell *cell = (PhotoGetMoreCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        NSDictionary *dic=[photoList objectAtIndex:indexPath.row];
        [cell updateCell:self item:dic];
        return cell;
    }
    else{
        static NSString * CellIdentifier = @"DynamicCollectionViewCell";
        DynamicCollectionViewCell *cell = (DynamicCollectionViewCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        NSDictionary *dic=[photoList objectAtIndex:indexPath.row];
        [cell updateCell:self itemData:dic];
        return cell;
    }
    
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    
    return CGSizeMake((SCREENWIDTH-40)/3, (SCREENWIDTH-40)/3);
    
}

//定义每个UICollectionView 的 margin
-(UIEdgeInsets)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout *)collectionViewLayout insetForSectionAtIndex:(NSInteger)section
{
    return UIEdgeInsetsMake(8, 8, 8, 8);
}

//UICollectionView被选中时调用的方法
-(void)collectionView:(UICollectionView *)collectionView didSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    DynamicCollectionViewCell * cell = (DynamicCollectionViewCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor clearColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}


@end

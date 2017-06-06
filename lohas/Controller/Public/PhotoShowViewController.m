//
//  PhotoShowViewController.m
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "PhotoShowViewController.h"
#import "PhotoCell.h"
#import "PhotoGetMoreCell.h"

@interface PhotoShowViewController (){
    int pageSize;
    NSMutableArray *photoList;
    
    NSArray *responseList;
}

@end

@implementation PhotoShowViewController
@synthesize caID,type;

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
    [self setNavBarTitle:@"相册展示"];
    
    self.collection.backgroundColor=[UIColor whiteColor];
    self.collection.dataSource=self;
    self.collection.delegate=self;
    
    [self.collection registerClass:[PhotoCell class] forCellWithReuseIdentifier: @"PhotoCell"];
    [self.collection registerClass:[PhotoGetMoreCell class] forCellWithReuseIdentifier: @"PhotoGetMoreCell"];
    
    pageSize=1;
    photoList=[[NSMutableArray alloc]init];
    
    [self loadData];
    
}

-(void)loadData{
    [self showLoadingView];
    Api *api=[[Api alloc]init:self tag:@"photo_list"];
    [api photo_list:caID type:type page:pageSize count:21];
}

-(void)error:(NSString*)message tag:(NSString*)tag
{
    [self closeLoadingView];
    [self showAlert:message];
}

-(void)loaded:(id)response tag:(NSString*)tag
{
    [self closeLoadingView];
    if ([tag isEqual:@"photo_list"]) {
        
        responseList=response;
        
        pageSize++;
        [photoList addObjectsFromArray:response];
        int i=0;
        for (NSMutableDictionary *dic in photoList) {
            NSString *index=[NSString stringWithFormat:@"%d",i];
            [dic setObject:index forKey:@"index"];
            i++;
        }
        
        [self.collection reloadData];
        
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
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
    if (photoList.count%21==0 && indexPath.row+2>photoList.count && responseList.count>0) {
        static NSString * CellIdentifier = @"PhotoGetMoreCell";
        PhotoGetMoreCell *cell = (PhotoGetMoreCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        NSDictionary *dic=[photoList objectAtIndex:indexPath.row];
        [cell updateCell:self item:dic];
        return cell;
    }
    else{
        static NSString * CellIdentifier = @"PhotoCell";
        PhotoCell *cell = (PhotoCell *)[collectionView dequeueReusableCellWithReuseIdentifier:CellIdentifier forIndexPath:indexPath];
        NSDictionary *dic=[photoList objectAtIndex:indexPath.row];
        cell.photoList=photoList;
        [cell updateCell:self itemData:dic];
        return cell;
    }
    
    
}

//定义每个UICollectionView 的大小
- (CGSize)collectionView:(UICollectionView *)collectionView layout:(UICollectionViewLayout*)collectionViewLayout sizeForItemAtIndexPath:(NSIndexPath *)indexPath
{
    //return CGSizeMake(94, 87);
    
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
    PhotoCell * cell = (PhotoCell *)[collectionView cellForItemAtIndexPath:indexPath];
    cell.backgroundColor = [UIColor whiteColor];
}

//返回这个UICollectionView是否可以被选择
-(BOOL)collectionView:(UICollectionView *)collectionView shouldSelectItemAtIndexPath:(NSIndexPath *)indexPath
{
    return YES;
}

-(void)getMorePhoto{
    [self loadData];
}

@end

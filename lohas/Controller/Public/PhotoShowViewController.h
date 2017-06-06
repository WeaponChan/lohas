//
//  PhotoShowViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface PhotoShowViewController : MainViewController<UICollectionViewDelegate,UICollectionViewDataSource>

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property(copy,nonatomic)NSString *caID;
@property int type;

-(void)getMorePhoto;

@end

//
//  DynamicSearchViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/3/21.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface DynamicSearchViewController : MainViewController


@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
- (IBAction)actSearch:(id)sender;

@end

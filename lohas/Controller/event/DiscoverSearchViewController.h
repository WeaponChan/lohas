//
//  DiscoverSearchViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface DiscoverSearchViewController : MainViewController

@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property (weak, nonatomic) IBOutlet UITextField *textSearch;
@property (weak, nonatomic) IBOutlet UICollectionView *collection;

- (IBAction)actSearch:(id)sender;

@end

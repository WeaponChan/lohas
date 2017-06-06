//
//  DiscoverViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "DiscoverRankList.h"
#import "AreaList.h"

@interface DiscoverViewController : MainViewController

@property (strong, nonatomic) IBOutlet UIView *viewTitle;
@property (weak, nonatomic) IBOutlet UIView *viewSub;

@property (weak, nonatomic) IBOutlet UIButton *btnGuide;
@property (weak, nonatomic) IBOutlet UIButton *btnRank;
- (IBAction)actRank:(id)sender;
- (IBAction)actGuide:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;
@property (weak, nonatomic) IBOutlet DiscoverRankList *mDiscoverRankList;

- (IBAction)actSearch:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewTitleHead;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
@property (weak, nonatomic) IBOutlet UIButton *btnArea;
- (IBAction)actArea:(id)sender;

@property (strong, nonatomic) IBOutlet UIView *viewArea;

@property (weak, nonatomic) IBOutlet AreaList *mAreaList;
- (IBAction)actHidden:(id)sender;


@end

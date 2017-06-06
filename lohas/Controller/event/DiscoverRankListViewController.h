//
//  DiscoverRankListViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "DiscoverRankList.h"
#import "AreaList.h"

@interface DiscoverRankListViewController : MainViewController

@property(copy,nonatomic)NSString *mainTitle;
@property(copy,nonatomic)NSString *interest_id;
@property(copy,nonatomic)NSString *category_id;

@property(copy,nonatomic)UIImage *imageView;

@property (weak, nonatomic) IBOutlet DiscoverRankList *mDiscoverRankList;

@property (weak, nonatomic) IBOutlet UILabel *labTItle;

@property (strong, nonatomic) IBOutlet UIView *viewArea;
@property (weak, nonatomic) IBOutlet AreaList *mAreaList;
- (IBAction)actHidden:(id)sender;

@end

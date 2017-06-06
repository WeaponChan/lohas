//
//  subDiscoverListViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/3/3.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "subDiscoverRankList.h"
#import "AreaList.h"

@interface subDiscoverListViewController : MainViewController
@property (weak, nonatomic) IBOutlet subDiscoverRankList *msubDiscoverRankList;

@property(copy,nonatomic)NSString *rankID;
@property(copy,nonatomic)NSString *typeID;

@property(copy,nonatomic)NSString *mainTitle;

@property (strong, nonatomic) IBOutlet UIView *viewArea;
@property (weak, nonatomic) IBOutlet AreaList *mAreaList;
- (IBAction)actHidden:(id)sender;

-(void)refreshInfo:(NSString*)infoID;

@end

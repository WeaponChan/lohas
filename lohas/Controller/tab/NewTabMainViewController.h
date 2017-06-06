//
//  NewTabMainViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "NewTabMainList.h"

@interface NewTabMainViewController : MainViewController

@property (weak, nonatomic) IBOutlet UIView *viewNavbarTitle;
@property (weak, nonatomic) IBOutlet UIButton *btnCity;
@property (weak, nonatomic) IBOutlet UILabel *labMainTitle;
- (IBAction)actSelectCity:(id)sender;

@property (weak, nonatomic) IBOutlet NewTabMainList *mNewTabMainList;

-(void)reloadData;

- (IBAction)actSearch:(id)sender;


@end

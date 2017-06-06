//
//  RaidersListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "RaidersList.h"
@interface RaidersListViewController : MainViewController{
    UIButton *btnSelected;
}
@property (weak, nonatomic) IBOutlet RaidersList *mRaidersList;

@property (weak, nonatomic) IBOutlet UIView *viewMark;

- (IBAction)actClickTag:(id)sender;

@end

//
//  MyTripListViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/23.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MyTripList.h"
#import "MSButtonToAction.h"

@interface MyTripListViewController : MainViewController

@property (weak, nonatomic) IBOutlet MyTripList *mMyTripList;

-(void)getItem:(NSDictionary*)tripItem;

@end

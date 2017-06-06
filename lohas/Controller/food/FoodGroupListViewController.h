//
//  FoodGroupListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-3.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "FoodGroupList.h"
#import "MSButtonToAction.h"

@interface FoodGroupListViewController : MainViewController
@property (weak, nonatomic) IBOutlet FoodGroupList *mFoodGroupList;
@property (weak, nonatomic) IBOutlet MSButtonToAction *btnDistance;

@end

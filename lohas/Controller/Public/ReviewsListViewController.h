//
//  ReviewsListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "FoodReviewList.h"

@interface ReviewsListViewController : MainViewController
@property (weak, nonatomic) IBOutlet FoodReviewList *mFoodReviewList;

@property int type;
@property (copy,nonatomic)NSString *seID;

@end

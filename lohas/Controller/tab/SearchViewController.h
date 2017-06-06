//
//  SearchViewController.h
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "SearchPlaceList.h"
#import "SearchHisList.h"
#import "MSButtonToAction.h"

@interface SearchViewController : MainViewController


@property (weak, nonatomic) IBOutlet SearchPlaceList *mSearchPlaceList;

-(void)actSearchHistory;

- (IBAction)actBtnType:(id)sender;

@property (weak, nonatomic) IBOutlet UIView *viewType;
@property (weak, nonatomic) IBOutlet UITextField *textTest;

@end

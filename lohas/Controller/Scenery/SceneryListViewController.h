//
//  SceneryListViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "SceneryList.h"

@interface SceneryListViewController : MainViewController{
    UIButton *btnSelected;
}
@property (weak, nonatomic) IBOutlet SceneryList *mSceneryList;

@property (weak, nonatomic) IBOutlet UIView *viewMark;

- (IBAction)actClickTag:(id)sender;

@property(copy,nonatomic)NSString *searchTitle;
@property(copy,nonatomic)NSString *searchcityID;
@property (weak, nonatomic) IBOutlet UIButton *btnFirst;
//@property(copy,nonatomic)CLLocation *searchLocation;
@property (copy,nonatomic)NSString *categoryID;

@property float lat;
@property float lng;


@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property BOOL isNext;

@end



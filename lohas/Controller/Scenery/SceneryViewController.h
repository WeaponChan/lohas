//
//  SceneryViewController.h
//  lohas
//
//  Created by juyuan on 14-12-9.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "SceneryViewList.h"

@interface SceneryViewController : MainViewController
@property (weak, nonatomic) IBOutlet SceneryViewList *mSceneryViewList;

@property (copy,nonatomic)NSString *countryID;
@property (copy,nonatomic)NSDictionary *HeadDic;

- (IBAction)actComment:(id)sender;
- (IBAction)actWrong:(id)sender;
- (IBAction)actPicture:(id)sender;
- (IBAction)actShare:(id)sender;

-(void)getMore:(BOOL)isHide;
-(void)refresh;

@end

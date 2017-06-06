//
//  TopViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "TopViewList.h"

@interface TopViewController : MainViewController
@property (weak, nonatomic) IBOutlet TopViewList *mTopViewList;

@property(copy,nonatomic)NSString *subID;
@property(copy,nonatomic)NSDictionary *headDic;

@property (weak, nonatomic) IBOutlet UILabel *labInfo;
@property (weak, nonatomic) IBOutlet UIView *viewHead;

-(void)refreshInfo:(NSDictionary*)diction;

@end

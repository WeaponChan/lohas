//
//  WrongListViewController.h
//  lohas
//
//  Created by fred on 15-4-15.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "WrongList.h"

@interface WrongListViewController : MainViewController
@property (weak, nonatomic) IBOutlet WrongList *mWrongList;

@property(copy,nonatomic)NSString *subID;
@property int type;

-(void)getSelectId:(NSString*)Id;

@end

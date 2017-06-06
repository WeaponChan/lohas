//
//  DynamicZanListViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "DynamicZanList.h"

@interface DynamicZanListViewController : MainViewController

@property BOOL isOtherFans;
@property BOOL isOtherFocus;
@property BOOL isFans;
@property BOOL isFocus;
@property(copy,nonatomic)NSString *said_id;
@property (weak, nonatomic) IBOutlet DynamicZanList *mDynamicZanList;

@property(copy,nonatomic)NSString *user_id;


-(void)refreshMessage:(NSString*)user_id type:(NSString*)type;

@end

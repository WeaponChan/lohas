//
//  UserBlackViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "UserBlackList.h"

@interface UserBlackViewController : MainViewController

@property (weak, nonatomic) IBOutlet UserBlackList *mUserBlackList;

-(void)deleteBlack:(NSString*)blackID;

@end

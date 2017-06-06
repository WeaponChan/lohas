//
//  WatchOtherTripViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "OtherTripList.h"

@interface WatchOtherTripViewController : MainViewController

@property (weak, nonatomic) IBOutlet OtherTripList *mOtherTripList;

@property(copy,nonatomic)NSString *user_id;

@end

//
//  DynamicCommentListViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "DynamicCommentList.h"

@interface DynamicCommentListViewController : MainViewController

@property(copy,nonatomic)NSString *said_id;
@property (weak, nonatomic) IBOutlet DynamicCommentList *mDynamicCommentList;

@end

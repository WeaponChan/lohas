//
//  TopBussinessViewController.h
//  lohas
//
//  Created by juyuan on 14-12-8.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface TopBussinessViewController : MainViewController
@property (weak, nonatomic) IBOutlet UIView *viewtag;

@property(copy,nonatomic)NSDictionary *HeadDic;
@property(copy,nonatomic)NSDictionary *NextDic;

@property (weak, nonatomic) IBOutlet MSImageView *imageHead;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labAddress;



@end

//
//  EventViewController.h
//  lohas
//
//  Created by juyuan on 15-2-14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "EventBanner.h"

@interface EventViewController : MainViewController{
    EventBanner *bannerView;
}

@property(copy,nonatomic)NSString *eventID;
@property(copy,nonatomic)NSDictionary *headDic;

@property (weak, nonatomic) IBOutlet UILabel *labTitle;
@property (weak, nonatomic) IBOutlet UILabel *labInfo;
@property (weak, nonatomic) IBOutlet UILabel *labContent;
@property (weak, nonatomic) IBOutlet UIView *viewMain;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewSub;

@property (weak, nonatomic) IBOutlet UIView *viewBanner;

@end

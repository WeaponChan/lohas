//
//  EventListViewController.h
//  lohas
//
//  Created by juyuan on 15-2-14.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "EventList.h"

@interface EventListViewController : MainViewController{

    UIButton *btnSelected;
}

@property (weak, nonatomic) IBOutlet EventList *mEventList;
@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property (weak, nonatomic) IBOutlet UIView *viewMark;

@property(copy,nonatomic)NSString *title;
@property(copy,nonatomic)NSString *categoryId;
@property(copy,nonatomic)NSArray *backBtnList;
- (IBAction)actClickTag:(id)sender;

@property BOOL isNext;
//@property(copy,nonatomic)CLLocation *location;

@property float lat;
@property float lng;

@end

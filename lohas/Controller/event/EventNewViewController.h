//
//  EventNewViewController.h
//  lohas
//
//  Created by Juyuan123 on 15/5/9.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "EventViewList.h"

@interface EventNewViewController : MainViewController

@property(copy,nonatomic)NSString *eventID;
@property(copy,nonatomic)NSDictionary *headDic;

@property (weak, nonatomic) IBOutlet EventViewList *mEventViewList;

- (IBAction)actComment:(id)sender;
- (IBAction)actWrong:(id)sender;
- (IBAction)actPicture:(id)sender;
- (IBAction)actShare:(id)sender;

-(void)getMore:(BOOL)isHide;
-(void)refresh;

@end

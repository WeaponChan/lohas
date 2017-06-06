//
//  HotelViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "HotelViewList.h"

@interface HotelViewController : MainViewController
@property (weak, nonatomic) IBOutlet HotelViewList *mHotelViewList;

- (IBAction)actPostPicture:(id)sender;
- (IBAction)actErrorCorrect:(id)sender;
- (IBAction)actComment:(id)sender;
- (IBAction)actShare:(id)sender;

@property(copy,nonatomic)NSString *hotelID;
@property(copy,nonatomic)NSString *sdate;
@property(copy,nonatomic)NSString *edate;
@property(copy,nonatomic)NSDictionary *listItem;

-(void)getMore:(BOOL)isHide;

-(void)refresh;

@end

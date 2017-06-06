//
//  DateViewController.h
//  lohas
//
//  Created by fred on 15-3-10.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//
#import "MainViewController.h"
#import "DSLCalendarView.h"

@protocol DayPickerDelegate <NSObject>

-(void)pickedDay:(NSString*)_day;

-(void)pickedDay:(NSString*)_day type:(NSInteger)_type;

@end

@interface DateViewController : MainViewController<DSLCalendarViewDelegate>

@property(nonatomic,weak)id<DayPickerDelegate> delegate;
@property(nonatomic,assign)NSInteger type;

@property (weak, nonatomic) IBOutlet DSLCalendarView *calendarView;


@end

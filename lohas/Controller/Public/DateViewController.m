//
//  DateViewController.m
//  lohas
//
//  Created by fred on 15-3-10.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "DateViewController.h"
#import "TSMessage.h"

@interface DateViewController (){
    NSDate *dateToday;;
}

@end

@implementation DateViewController

- (id)initWithNibName:(NSString *)nibNameOrNil bundle:(NSBundle *)nibBundleOrNil
{
    self = [super initWithNibName:nibNameOrNil bundle:nibBundleOrNil];
    if (self) {
        // Custom initialization
    }
    return self;
}

- (void)viewDidLoad
{
    [super viewDidLoad];
    // Do any additional setup after loading the view from its nib.
    
    [self setNavBarTitle:@"日期选择"];
    
    self.calendarView.delegate = self;
    
    [TSMessage setDefaultViewController:self.navigationController];
    
    NSDate *  senddate=[NSDate date];
    NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
    [dateFormatter setDateFormat:@"yyyy-MM-dd"];
    NSString *today=[dateFormatter stringFromDate:senddate];
    dateToday=[dateFormatter dateFromString:today];
    
    if ([MSUIUtils getIOSVersion] >= 7.0){
        [self addNavBar_LeftBtn:@"navbar_back" action:@selector(actNavBar_Back:)];
    }else{
        [self addNavBar_LeftBtn:[UIImage imageNamed:@"navbar_back"]
                      Highlight:[UIImage imageNamed:@"navbar_back"]
                         action:@selector(actNavBar_Back:)];
    }
}

-(void)actNavBar_Back:(id)sender
{
    if([self.navigationController.viewControllers objectAtIndex:0] == self){
        [self dismissViewControllerAnimated:true completion:nil];
    }else{
        [self.navigationController popViewControllerAnimated:true];
    }
}

- (void)didReceiveMemoryWarning
{
    [super didReceiveMemoryWarning];
    // Dispose of any resources that can be recreated.
}

- (BOOL)shouldAutorotateToInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation
{
    return (interfaceOrientation != UIInterfaceOrientationPortraitUpsideDown);
}

#pragma mark - DSLCalendarViewDelegate methods

- (void)calendarView:(DSLCalendarView *)calendarView didSelectRange:(DSLCalendarRange *)range {
    if (range != nil) {
        NSLog( @"Selected %d/%d - %d/%d", range.startDay.day, range.startDay.month, range.endDay.day, range.endDay.month);
        NSDateFormatter *dateFormatter = [[NSDateFormatter alloc] init];
        [dateFormatter setDateFormat:@"yyyy-MM-dd"];
        NSString *day = [dateFormatter stringFromDate:[range.startDay date]];
        
        NSDate *DateChoose=[dateFormatter dateFromString:day];
        NSComparisonResult result = [dateToday compare:DateChoose];
        
        NSLog(@"result===%ld",result);
        
        if (result == 1) {
            //            UIAlertView *alert=[[UIAlertView alloc]initWithTitle:@"当前日期已失效" message:@"请重新选择" delegate:self cancelButtonTitle:@"确认" otherButtonTitles:nil, nil];
            //            [alert show];
            
            [TSMessage showNotificationWithTitle:@"当前日期已失效,请重新选择"
                                        subtitle:nil
                                            type:TSMessageNotificationTypeError];
            
        }else{
            
            [self.delegate  pickedDay:day];
            [self.delegate  pickedDay:day type:self.type];
            [self.navigationController popViewControllerAnimated:YES];
            
        }
    }
    else {
        NSLog( @"No selection" );
    }
}

- (DSLCalendarRange*)calendarView:(DSLCalendarView *)calendarView didDragToDay:(NSDateComponents *)day selectingRange:(DSLCalendarRange *)range {
    if (NO) { // Only select a single day
        return [[DSLCalendarRange alloc] initWithStartDay:day endDay:day];
    }
    else if (NO) { // Don't allow selections before today
        NSDateComponents *today = [[NSDate date] dslCalendarView_dayWithCalendar:calendarView.visibleMonth.calendar];
        
        NSDateComponents *startDate = range.startDay;
        NSDateComponents *endDate = range.endDay;
        
        if ([self day:startDate isBeforeDay:today] && [self day:endDate isBeforeDay:today]) {
            return nil;
        }
        else {
            if ([self day:startDate isBeforeDay:today]) {
                startDate = [today copy];
            }
            if ([self day:endDate isBeforeDay:today]) {
                endDate = [today copy];
            }
            
            return [[DSLCalendarRange alloc] initWithStartDay:startDate endDay:endDate];
        }
    }
    
    return range;
}

- (void)calendarView:(DSLCalendarView *)calendarView willChangeToVisibleMonth:(NSDateComponents *)month duration:(NSTimeInterval)duration {
    NSLog(@"Will show %@ in %.3f seconds", month, duration);
}

- (void)calendarView:(DSLCalendarView *)calendarView didChangeToVisibleMonth:(NSDateComponents *)month {
    NSLog(@"Now showing %@", month);
}

- (BOOL)day:(NSDateComponents*)day1 isBeforeDay:(NSDateComponents*)day2 {
    return ([day1.date compare:day2.date] == NSOrderedAscending);
}


@end

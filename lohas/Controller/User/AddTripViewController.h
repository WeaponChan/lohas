//
//  AddTripViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/23.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "MyFocusTripViewController.h"
#import "mainAddList.h"


@interface AddTripViewController : MainViewController<selectTripDelegate,UITextFieldDelegate>

@property(copy,nonatomic)NSMutableArray *selectList;

- (IBAction)actDestation:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textName;
@property (weak, nonatomic) IBOutlet mainAddList *mmainAddList;

@property (weak, nonatomic) IBOutlet UIButton *btnCommit;
- (IBAction)actCommit:(id)sender;
@property (weak, nonatomic) IBOutlet UIView *viewBtn;

-(void)selectTime:(NSString*)tripID;
-(void)deleteTrip:(NSString*)tripID;

@property (strong, nonatomic) IBOutlet UIDatePicker *datePicker;
- (IBAction)actDate:(id)sender;
@property (weak, nonatomic) IBOutlet UITextField *textTest;

@property (copy ,nonatomic) NSString *Title;
@property BOOL isEdit;
@property  (copy ,nonatomic) NSMutableArray *listarr11;
@property (copy,nonatomic)NSString *tripiD;



@end

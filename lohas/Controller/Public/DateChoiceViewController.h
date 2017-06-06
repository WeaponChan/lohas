//
//  DateChoiceViewController.h
//  lohas
//
//  Created by juyuan on 14-12-4.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"

@interface DateChoiceViewController : MainViewController

@property (weak, nonatomic) IBOutlet UITextField *textSdate;
@property (weak, nonatomic) IBOutlet UITextField *textEdate;
- (IBAction)actEdate:(id)sender;
- (IBAction)actSDate:(id)sender;


@end

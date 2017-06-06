//
//  DestinationViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/3/4.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "DestinationList.h"

@interface DestinationViewController : MainViewController

@property (weak, nonatomic) IBOutlet DestinationList *mDestinationList;

- (IBAction)actComment:(id)sender;
- (IBAction)actCommitWrong:(id)sender;

@property(copy,nonatomic)NSDictionary *responseItem;
@property(copy,nonatomic)NSString *title;
- (IBAction)actPicture:(id)sender;
- (IBAction)actShare:(id)sender;

-(void)getMore:(BOOL)isHide;
-(void)refresh;

@end

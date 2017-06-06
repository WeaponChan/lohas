//
//  DynamicJubaoListViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "DynamicJubaoList.h"

@interface DynamicJubaoListViewController : MainViewController

@property (weak, nonatomic) IBOutlet DynamicJubaoList *mDynamicJubaoList;

-(void)selectJubao:(NSString*)jubaoID;
@property(copy,nonatomic)NSString *type;

@property(copy,nonatomic)NSString *typeID;
- (IBAction)actNeedKnow:(id)sender;

@end

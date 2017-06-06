//
//  ShopViewController.h
//  lohas
//
//  Created by juyuan on 15-3-11.
//  Copyright (c) 2015年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "ShopViewList.h"

@interface ShopViewController : MainViewController
@property (weak, nonatomic) IBOutlet ShopViewList *mShopViewList;

- (IBAction)actComment:(id)sender;
- (IBAction)actCommitWrong:(id)sender;

@property(copy,nonatomic)NSDictionary *responseItem;
@property(copy,nonatomic)NSString *title;
- (IBAction)actPicture:(id)sender;
- (IBAction)actShare:(id)sender;

-(void)getMore:(BOOL)isHide;
-(void)refresh;

@end

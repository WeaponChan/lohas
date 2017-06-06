//
//  FoodTypeChioceViewController.h
//  lohas
//
//  Created by juyuan on 14-12-2.
//  Copyright (c) 2014年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "FoodTypeChioceList.h"

@protocol MenuSelectDelete <NSObject>

-(void)backWithSelectMenu:(NSArray*)btnList categoryID:(NSString*)categoryID title:(NSString*)titile;

@end

@interface FoodTypeChioceViewController : MainViewController
@property (weak, nonatomic) IBOutlet FoodTypeChioceList *mFoodTypeChioceList;
@property (weak, nonatomic) IBOutlet UIScrollView *scrollView;
@property (weak, nonatomic) IBOutlet UIView *viewMain;

-(void)getSelectCell:(NSMutableArray*)menuList;

@property(weak,nonatomic)id<MenuSelectDelete>delegate;

@property(copy,nonatomic)NSArray *list;
@property(copy,nonatomic)NSString *Stitle;
@property (weak, nonatomic) IBOutlet UIButton *btnOther;
@property(weak, nonatomic)  NSArray *backSelectBtn;

- (IBAction)actOther:(id)sender;

@end

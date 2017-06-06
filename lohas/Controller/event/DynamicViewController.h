//
//  DynamicViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/2/19.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "DynamicList.h"
#import "DyMessageList.h"

@interface DynamicViewController : MainViewController<UIActionSheetDelegate,UITextFieldDelegate>

@property (strong, nonatomic) IBOutlet UIView *viewHead;
@property (weak, nonatomic) IBOutlet UIView *viewStatus;
@property (weak, nonatomic) IBOutlet UIButton *btnDynamic;
@property (weak, nonatomic) IBOutlet UIButton *btnAttention;
@property (weak, nonatomic) IBOutlet UIButton *btnMessage;
@property (weak, nonatomic) IBOutlet UIView *viewDot;
- (IBAction)actDynamic:(id)sender;
- (IBAction)actAttention:(id)sender;
- (IBAction)actMessage:(id)sender;

@property (weak, nonatomic) IBOutlet UIButton *btnFabu;
- (IBAction)actFabu:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnSearch;
- (IBAction)actSearch:(id)sender;

@property (weak, nonatomic) IBOutlet UICollectionView *collection;

@property (weak, nonatomic) IBOutlet DynamicList *mDynamicList;
@property (weak, nonatomic) IBOutlet DyMessageList *mDyMessageList;

-(void)sendComment:(NSString*)saidID;
-(void)juBao:(NSString*)saidID userid:(NSString*)userid;

@property (weak, nonatomic) IBOutlet UIView *viewBottom;
@property (weak, nonatomic) IBOutlet UITextField *textComment;
@property (weak, nonatomic) IBOutlet UIButton *btnSend;
- (IBAction)actSend:(id)sender;

-(void)actZan:(NSString*)saidID type:(NSString*)type;

-(void)refreshMessage:(NSString*)user_id type:(NSString*)type;

-(void)getMore;

-(void)actShare:(NSString*)saidID saidItem:(NSDictionary*)saidItem;
- (IBAction)actEdit:(id)sender;

@end

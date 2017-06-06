//
//  OtherTripViewController.h
//  lohas
//
//  Created by Juyuan123 on 16/3/1.
//  Copyright © 2016年 juyuan. All rights reserved.
//

#import "MainViewController.h"
#import "OtherTripList.h"
#import "MSButtonToAction.h"

@interface OtherTripViewController : MainViewController<UITextFieldDelegate>{
    MSButtonToAction *btnFav;
}

@property BOOL isOther;
@property(copy,nonatomic)NSString *tripID;
@property (weak, nonatomic) IBOutlet OtherTripList *mOtherTripList;
@property (weak, nonatomic) IBOutlet UIView *viewHead;
@property (weak, nonatomic) IBOutlet UILabel *labTitle;

@property (weak, nonatomic) IBOutlet UIView *btnView;
- (IBAction)actEdit:(id)sender;
@property (weak, nonatomic) IBOutlet UIButton *btnEdit;
@property(copy,nonatomic)NSString *userID;



-(void)requestedSuccess:(NSDictionary*)diction;

@end

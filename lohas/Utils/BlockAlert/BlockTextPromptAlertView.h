//
//  BlockTextPromptAlertView.h
//  BlockAlertsDemo
//
//  Created by Barrett Jacobsen on 2/13/12.
//  Copyright (c) 2012 Barrett Jacobsen. All rights reserved.
//

#import "BlockAlertView.h"

@class BlockTextPromptAlertView;

typedef BOOL(^TextFieldReturnCallBack)(BlockTextPromptAlertView *);

@interface BlockTextPromptAlertView : BlockAlertView <UITextFieldDelegate> {
    
    NSCharacterSet *unacceptedInput;
    NSInteger maxLength;
    CGRect origFrame;
}

@property (nonatomic, retain) NSMutableArray *textFields;

-(UITextField*)field:(int)index;

+ (BlockTextPromptAlertView *)promptWithTitle:(NSString *)title message:(NSString *)message block: (TextFieldReturnCallBack) block;

-(void)addEditField:(out UITextField**)textField;


@end

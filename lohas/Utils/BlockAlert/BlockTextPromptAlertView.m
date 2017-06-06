//
//  BlockTextPromptAlertView.m
//  BlockAlertsDemo
//
//  Created by Barrett Jacobsen on 2/13/12.
//  Copyright (c) 2012 Barrett Jacobsen. All rights reserved.
//

#import "BlockTextPromptAlertView.h"

#define kTextBoxHeight      30
#define kTextBoxSpacing     20
#define kTextBoxHorizontalMargin 30

#define kKeyboardResizeBounce         20

@interface BlockTextPromptAlertView()
@property(nonatomic, copy) TextFieldReturnCallBack callBack;
@end

@implementation BlockTextPromptAlertView
@synthesize textFields, callBack;


+ (BlockTextPromptAlertView *)promptWithTitle:(NSString *)title message:(NSString *)message block: (TextFieldReturnCallBack) block

{
    BlockTextPromptAlertView *prompt = [[super alloc] initWithTitle:title message:message];    
    prompt.textFields = [[NSMutableArray alloc] init];
    prompt.callBack = block;
    return prompt;
}

-(UITextField*)field:(int)index
{
    if(index>=0 && self.textFields.count>index)
    {
        return [self.textFields objectAtIndex:index];
    }
    return nil;
}

-(void)addEditField:(out UITextField**)textField
{
    NSLog(@"_view.bounds.size.width:%f",_view.bounds.size.width);
    
    if (self)  {
        UITextField *theTextField = [[UITextField alloc] initWithFrame:CGRectMake(kTextBoxHorizontalMargin, _height, _view.bounds.size.width - kTextBoxHorizontalMargin * 2, kTextBoxHeight)];
        
        [theTextField setKeyboardType:UIKeyboardTypeDefault];
        [theTextField setContentVerticalAlignment:UIControlContentVerticalAlignmentCenter];
        [theTextField setContentHorizontalAlignment:UIControlContentHorizontalAlignmentLeft];
        [theTextField setAutocapitalizationType:UITextAutocapitalizationTypeNone];
        [theTextField setBorderStyle:UITextBorderStyleRoundedRect];
        [theTextField setAutocorrectionType:UITextAutocorrectionTypeNo];
        [theTextField setClearButtonMode:UITextFieldViewModeAlways];
        [theTextField setFont:[UIFont systemFontOfSize:14]];
        
        theTextField.delegate = self;
        
        [_view addSubview:theTextField];
        
        [self.textFields addObject: theTextField];
        *textField = theTextField;
        
        _height += kTextBoxHeight + kTextBoxSpacing;
    }
}

- (void)show {
    
    
    [[NSNotificationCenter defaultCenter] addObserver:self
                                             selector:@selector(keyboardWillShow:)
                                                 name:UIKeyboardWillShowNotification
                                               object:nil];
    
    [[NSNotificationCenter defaultCenter] addObserver:self selector:@selector(keyboardWillHide:) name:UIKeyboardWillHideNotification object:nil];
    
    [super show];
    
    
}

- (void)dismiss:(BOOL)animated
{    
    [super dismissWithClickedButtonIndex:0 animated:animated];
    
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillShowNotification object:nil];
    [[NSNotificationCenter defaultCenter] removeObserver:self name:UIKeyboardWillHideNotification object:nil];
}

- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated {
    if(buttonIndex>0) {
        if(callBack){
            BOOL result = callBack(self);
            if(result) {
                [self dismiss:NO];
            } else {
            }
        }
    } else {
        [self dismiss:YES];
    }
}

-(BOOL)textFieldShouldReturn:(UITextField *)_textField
{
    if(self.textFields.count>0) {
        int index = [self.textFields indexOfObject:_textField];
        if(index>=0 && index<self.textFields.count-1) {
            UITextField* field = [self.textFields objectAtIndex:index+1];
            [field becomeFirstResponder];
        } else if(index==self.textFields.count-1){
            if(callBack){
                BOOL result = callBack(self);
                if(result) {
                    [self dismiss:NO];
                } else {
                }
            }
        }
    }
    return YES;
}

- (BOOL)textFieldShouldBeginEditing:(UITextField *)_textField
{
    if(self.textFields.count>0) {
        int index = [self.textFields indexOfObject:_textField];
        if(index==self.textFields.count-1){
            _textField.returnKeyType = UIReturnKeyGo;
        } else {
            _textField.returnKeyType = UIReturnKeyNext;
        }
    }
    return YES;
}

-(void)keyboardWillHide:(NSNotification *)notification {

    [UIView animateWithDuration:0.3
                          delay:0.0
                        options:UIViewAnimationCurveEaseOut
                     animations:^{
                         _view.frame = origFrame;
                     }
                     completion:nil];
}

- (void)keyboardWillShow:(NSNotification *)notification {
    CGSize keyboardSize = [[[notification userInfo] objectForKey:UIKeyboardFrameBeginUserInfoKey] CGRectValue].size;
    
    CGFloat screenHeight = [UIScreen mainScreen].bounds.size.width;
    __block CGRect frame = _view.frame;
    
    origFrame = _view.frame;
    
    if (frame.origin.y + frame.size.height > screenHeight - keyboardSize.width) {
        
        frame.origin.y = screenHeight - keyboardSize.width - frame.size.height-20;
        
        if (frame.origin.y < 0)
            frame.origin.y = 0;
        
        [UIView animateWithDuration:0.3
                              delay:0.0
                            options:UIViewAnimationCurveEaseOut
                         animations:^{
                             _view.frame = frame;
                         }
                         completion:nil];
    }
}


@end

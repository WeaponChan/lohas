//
//  BlockAlertView.h
//
//

#import <UIKit/UIKit.h>

@interface BlockAlertView : NSObject {
@protected
    UIView *_view;
    NSMutableArray *_blocks;
    CGFloat _height;
    
    UILabel *messageView;
    
}

+ (BlockAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message;
+ (BlockAlertView *)alertWithTitle:(NSString *)title message:(NSString *)message usingInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

- (id)initWithTitle:(NSString *)title message:(NSString *)message;
- (id)initWithTitle:(NSString *)title message:(NSString *)message usingInterfaceOrientation:(UIInterfaceOrientation)interfaceOrientation;

- (void)setDestructiveButtonWithTitle:(NSString *)title block:(void (^)())block;
- (void)setCancelButtonWithTitle:(NSString *)title block:(void (^)())block;
- (void)addButtonWithTitle:(NSString *)title block:(void (^)())block;

- (void)setMessage:(NSString*)message;
- (void)show;
- (void)dismissWithClickedButtonIndex:(NSInteger)buttonIndex animated:(BOOL)animated;

@property (nonatomic, retain) UIImage *backgroundImage;
@property (nonatomic, readonly) UIView *view;
@property (nonatomic, readwrite) BOOL vignetteBackground;
@property (nonatomic, assign) BOOL needSecondButton;

@end

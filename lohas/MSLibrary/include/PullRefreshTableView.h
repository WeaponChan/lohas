
#import <UIKit/UIKit.h>




@interface PullRefreshTableView : UITableView{
    UIView *refreshHeaderView;
    UILabel *refreshTipsLabel;
    UILabel *refreshDateLabel;
    UIImageView *refreshArrow;
    UIActivityIndicatorView *refreshSpinner;
    BOOL isDragging;
    BOOL isLoading;
    NSString *textPull;
    NSString *textRelease;
    NSString *textLoading;
    
}
//@property (nonatomic, readwrite) UITableView *tableView;
@property (nonatomic, retain) UIView *refreshHeaderView;
@property (nonatomic, retain) UILabel *refreshTipsLabel;
@property (nonatomic, retain) UILabel *refreshDateLabel;
@property (nonatomic, retain) UIImageView *refreshArrow;
@property (nonatomic, retain) UIActivityIndicatorView *refreshSpinner;
@property (nonatomic, copy) NSString *textPull;
@property (nonatomic, copy) NSString *textRelease;
@property (nonatomic, copy) NSString *textLoading;

- (void)setupStrings;
- (void)addPullToRefreshHeader;
- (void)startLoading;
- (void)stopLoading;
- (void)onPullRefresh;

@end
